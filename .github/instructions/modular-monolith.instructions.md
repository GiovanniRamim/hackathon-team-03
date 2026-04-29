---
description: "Architecture guide for Modular Monolith — package-by-feature, bounded contexts, JPA mapping, Strangler Fig"
applyTo: '**/src/main/java/**,**/pom.xml,**/build.gradle*'
---

# Modular Monolith Architecture Guide

This file is activated when you work on Java source files or build configurations. It reinforces the target architecture: a **Modular Monolith** — not microservices.

## Core Principle: One Deployable, Many Modules

The target system is a single Spring Boot application with clear internal module boundaries. Each bounded context is a Maven module (or a top-level package) that owns its domain, repository, and service layers.

Why Modular Monolith and not microservices:

- **Hackathon constraint**: 8 hours is not enough time to manage distributed systems, service discovery, and inter-service communication.
- **Complexity budget**: A monolith with good module boundaries gives you 80% of the benefits of microservices (team autonomy, clear ownership) with 20% of the operational cost.
- **Migration path**: A well-structured Modular Monolith can be decomposed into microservices later if needed. The reverse is much harder.

## Package-by-Feature Structure

Organize code by business capability, not by technical layer:

```
src/main/java/com/example/app/
├── payment/                    # Bounded context: Payment
│   ├── PaymentController.java  # REST endpoint
│   ├── PaymentService.java     # Business logic
│   ├── PaymentRepository.java  # Data access
│   ├── Payment.java            # JPA entity
│   └── PaymentDto.java         # DTO (Java record)
├── enrollment/                 # Bounded context: Enrollment
│   ├── EnrollmentController.java
│   ├── ...
├── shared/                     # Shared kernel
│   ├── audit/                  # Cross-cutting: audit trail
│   └── exception/              # Cross-cutting: error handling
└── Application.java            # Spring Boot entry point
```

Rules:

- A module **never** imports from another module's internal classes directly. Use interfaces or events.
- The `shared/` package contains only cross-cutting concerns (audit, exceptions, base entities).
- Each module has its own `*Repository`, `*Service`, and `*Controller`.

## Bounded Context Boundaries

When deciding where to draw module boundaries, ask:

1. **Who owns this data?** If two features share the same table, they might belong in the same context.
2. **What changes together?** Features that are modified in the same sprint belong together.
3. **What can fail independently?** If Feature A failing should not break Feature B, they belong in separate contexts.

Common pattern for legacy Natural/Adabas modernization: each Adabas file (FNR) often maps to one bounded context, though some files are shared reference data that belongs in a shared kernel.

## JPA Mapping from Adabas FDT

### Simple Fields

| Adabas Format | Java Type | JPA Annotation |
|---|---|---|
| `A` (alphanumeric) | `String` | `@Column(length = N)` |
| `N` (numeric, no decimal) | `Long` or `Integer` | `@Column` |
| `N` (numeric, with decimal) | `BigDecimal` | `@Column(precision = P, scale = S)` |
| `P` (packed decimal) | `BigDecimal` | `@Column(precision = P, scale = S)` |
| `D` (date) | `LocalDate` | `@Column` |
| `T` (time/datetime) | `LocalDateTime` | `@Column` |
| `B` (binary) | `byte[]` | `@Column` / `@Lob` |

### MU Fields (Multiple-Value) → JSONB

```java
@Column(columnDefinition = "jsonb")
@JdbcTypeCode(SqlTypes.JSON)
private List<String> alternateNames;  // Was MU field in Adabas
```

Or with `@ElementCollection` if you need queryability:

```java
@ElementCollection
@CollectionTable(name = "person_alternate_names")
private List<String> alternateNames;
```

### PE Groups (Periodic Groups) → @OneToMany

```java
@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
@JoinColumn(name = "person_id")
private List<AddressHistory> addressHistory;  // Was PE group
```

Where `AddressHistory` is an `@Entity` with its own table.

## Spring Boot 3.3 Conventions

- **Constructor injection**: No `@Autowired` on fields. Use `@RequiredArgsConstructor` (Lombok) or explicit constructors.
- **Records for DTOs**: `public record PaymentDto(Long id, BigDecimal amount, LocalDate dueDate) {}`
- **Validation at controller layer**: `@Valid @RequestBody PaymentDto dto` with Bean Validation annotations on the DTO.
- **@Transactional on service layer only**: Never on repositories, never on controllers.
- **Optional for nullable returns**: `Optional<Payment> findById(Long id)` — never return `null` from public methods.
- **Sealed interfaces for type unions**: `sealed interface PaymentStatus permits Pending, Approved, Rejected {}`

## Error Handling Pattern

```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(EntityNotFoundException.class)
    public ResponseEntity<ProblemDetail> handleNotFound(EntityNotFoundException ex) {
        ProblemDetail detail = ProblemDetail.forStatusAndDetail(
            HttpStatus.NOT_FOUND, ex.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(detail);
    }
}
```

Use `ProblemDetail` (RFC 7807) for all error responses.

## Strangler Fig Pattern

When the modern system must coexist with legacy:

1. **Facade**: All requests flow through a routing layer
2. **New path**: New or migrated features are handled by the Spring Boot modules
3. **Legacy path**: Unmigrated features are proxied to the legacy system
4. **Gradual migration**: As each feature is migrated, its route switches from legacy to modern

This pattern applies even within the hackathon scope: teams may not migrate everything, and that is acceptable. The architecture should support partial migration gracefully.

## What NOT to Do

- **No microservices**: Do not create separate Spring Boot applications for each context
- **No stored procedures**: All business logic lives in Java, not in PostgreSQL functions
- **No string concatenation for SQL**: Use JPA/JPQL or Spring Data derived queries
- **No `@Autowired` field injection**: Use constructor injection
- **No `null` returns**: Use `Optional` for methods that might not find a result
