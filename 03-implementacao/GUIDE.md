---
title: "Stage 3 — Implementation Guide"
description: "Guide for building SIFAP 2.0 backend and frontend from specification"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.2.0"
status: "approved"
tags: ["stage-3", "implementation", "backend", "frontend", "java", "nextjs"]
---

# 🛠️ Stage 3: Implementation

> ⏱️ **Duration**: 4 hours. This is where specification becomes working code. The backend team builds Java services; the frontend team builds Next.js UI. Both teams work in parallel, communicating through API contracts.

---

## 📑 Table of Contents

1. [Where are we on the journey](#-where-are-we-on-the-journey)
2. [Objective](#-objective)
3. [Architecture Overview](#-architecture-overview)
4. [Backend Development](#-backend-development)
5. [Frontend Development](#-frontend-development)
6. [Integration Points](#-integration-points)
7. [Quality and Testing](#-quality-and-testing)
8. [Definition of Done](#-definition-of-done)
9. [Navigation](#-navigation)

---

## 🎬 Where are we on the journey

Archaeology (Stage 1) gave us knowledge. Specification (Stage 2) gave us requirements. Now comes implementation: turning requirements into running code.

**Key principle**: Code should match specification exactly. Every REQ-* requirement should have a corresponding implementation with tests.

---

## 🎯 Objective

Build a working SIFAP 2.0 prototype with:
- Backend: Java 21 + Spring Boot services with REST APIs
- Frontend: Next.js web UI for beneficiary and payment management
- Database: PostgreSQL with audit logging
- Testing: Unit and integration tests with 70%+ coverage
- Documentation: OpenAPI (Swagger) for APIs

**Success metric**: All Priority 1 and Priority 2 requirements from Stage 2 implemented and tested.

---

## 🏗️ Architecture Overview

### Deployment Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Azure Cloud                              │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────┐              ┌──────────────────┐    │
│  │   App Service    │              │   App Service    │    │
│  │  (Backend Java)  │              │ (Frontend Next.js)     │
│  │   Port 8080      │              │   Port 3000      │    │
│  └────────┬─────────┘              └──────────┬───────┘    │
│           │                                    │             │
│           │    REST APIs                       │             │
│           │    (OpenAPI/Swagger)               │             │
│           │                                    │             │
│           └────────────┬─────────────────────┬─┘            │
│                        │                     │               │
│                   Application Logic      User Browser        │
│                        │                                      │
│           ┌────────────┴──────────────┐                      │
│           v                           v                      │
│      ┌──────────────────────────────────────┐                │
│      │  PostgreSQL Flexible Server          │                │
│      │  (Database + Audit Trail)            │                │
│      │  Port 5432                           │                │
│      └──────────────────────────────────────┘                │
│                                                               │
│      ┌────────────────────────────┐                          │
│      │  Azure Key Vault           │                          │
│      │  (Secrets Management)      │                          │
│      └────────────────────────────┘                          │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

### Backend Service Architecture

```
Controller Layer (REST Endpoints)
├─ BeneficiaryController
├─ PaymentController
├─ DeductionController
└─ ReportController

Service Layer (Business Logic)
├─ BeneficiaryService
├─ PaymentService
├─ DeductionService
├─ AuditService
└─ ReportService

Repository Layer (Data Access)
├─ BeneficiaryRepository (JPA)
├─ PaymentRepository (JPA)
├─ DeductionRepository (JPA)
└─ AuditLogRepository (JPA)

Database Layer
└─ PostgreSQL (16+)
   ├─ beneficiary table
   ├─ payment table
   ├─ deduction table
   └─ audit_log table (append-only)
```

### Frontend Component Structure

```
Next.js App Router
├─ /api/route.ts (proxies to backend)
├─ /beneficiaries
│  ├─ page.tsx (Beneficiary list)
│  ├─ [id]
│  │  └─ page.tsx (Beneficiary detail)
│  └─ new
│     └─ page.tsx (Beneficiary registration form)
├─ /payments
│  ├─ page.tsx (Payment list)
│  └─ [id]
│     └─ page.tsx (Payment detail)
└─ /audit
   └─ page.tsx (Audit log dashboard)

Components/
├─ BeneficiaryForm.tsx
├─ PaymentTable.tsx
├─ AuditLog.tsx
└─ Common UI components
```

---

## 💼 Backend Development

### Setup

**Prerequisites**:
- Java 21 JDK
- Maven 3.9+
- PostgreSQL 16+
- IDE: IntelliJ IDEA or VS Code with Java Extension Pack

**Project scaffolding**:
```bash
mvn archetype:generate \
  -DgroupId=com.sifap \
  -DartifactId=sifap-api \
  -DarchetypeArtifactId=maven-archetype-quickstart
```

Or use Spring Boot CLI:
```bash
spring boot new --name sifap-api --type maven-project
```

### Dependencies

**Recommended pom.xml additions**:
```xml
<dependencies>
  <!-- Spring Boot Starters -->
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
  </dependency>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
  </dependency>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
  </dependency>
  
  <!-- Database -->
  <dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <version>42.7.0</version>
  </dependency>
  
  <!-- OpenAPI/Swagger -->
  <dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.0.2</version>
  </dependency>
  
  <!-- Testing -->
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
  </dependency>
</dependencies>
```

### Key Entities

**File**: `src/main/java/com/sifap/domain/entity/Beneficiary.java`

```java
@Entity
@Table(name = "beneficiary")
public class Beneficiary {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  
  @Column(unique = true, length = 11)
  private String cpf;
  
  @Column(length = 100)
  private String name;
  
  @Enumerated(EnumType.STRING)
  private BeneficiaryStatus status;  // ACTIVE, SUSPENDED, CANCELLED
  
  @Enumerated(EnumType.STRING)
  private BenefitType benefitType;  // REGULAR, EXTENDED, SPECIAL
  
  @Column(length = 100)
  private String email;
  
  @Column(length = 20)
  private String phone;
  
  @CreationTimestamp
  private LocalDateTime createdAt;
  
  @UpdateTimestamp
  private LocalDateTime modifiedAt;
  
  @Column(length = 20)
  private String modifiedBy;
  
  // Getters, setters, constructors
}
```

**File**: `src/main/java/com/sifap/domain/entity/Payment.java`

```java
@Entity
@Table(name = "payment")
public class Payment {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  
  @ManyToOne
  @JoinColumn(name = "beneficiary_id", nullable = false)
  private Beneficiary beneficiary;
  
  @Column(length = 7)  // YYYY-MM format
  private String cycleDate;
  
  @Column(precision = 13, scale = 2)
  private BigDecimal baseAmount;
  
  @Column(precision = 13, scale = 2)
  private BigDecimal discountTotal;
  
  @Column(precision = 13, scale = 2)
  private BigDecimal netAmount;
  
  @Enumerated(EnumType.STRING)
  private PaymentStatus status;  // APPROVED, PAID, REJECTED, CANCELLED
  
  @Column(length = 10)  // YYYY-MM-DD format
  private String paymentDate;
  
  @CreationTimestamp
  private LocalDateTime createdAt;
  
  @Column(length = 20)
  private String createdBy;
  
  // Getters, setters
}
```

### Service Layer

**File**: `src/main/java/com/sifap/service/BeneficiaryService.java`

```java
@Service
@Transactional
public class BeneficiaryService {
  
  @Autowired
  private BeneficiaryRepository repository;
  
  @Autowired
  private AuditService auditService;
  
  public Beneficiary register(BeneficiaryRequest request) {
    // Validate CPF
    if (!CpfValidator.isValid(request.getCpf())) {
      throw new InvalidCpfException("CPF validation failed");
    }
    
    // Check for duplicates
    if (repository.existsByCpf(request.getCpf())) {
      throw new DuplicateCpfException("CPF already registered");
    }
    
    // Create beneficiary
    Beneficiary beneficiary = new Beneficiary();
    beneficiary.setCpf(request.getCpf());
    beneficiary.setName(request.getName());
    beneficiary.setStatus(BeneficiaryStatus.ACTIVE);
    beneficiary.setBenefitType(request.getBenefitType());
    
    Beneficiary saved = repository.save(beneficiary);
    
    // Audit
    auditService.record(EntityType.BENEFICIARY, saved.getId(), 
      Operation.CREATE, null, beneficiary);
    
    return saved;
  }
  
  public Beneficiary findById(Long id) {
    return repository.findById(id)
      .orElseThrow(() -> new BeneficiaryNotFoundException("Not found"));
  }
  
  public Beneficiary suspend(Long id) {
    Beneficiary beneficiary = findById(id);
    Beneficiary old = new Beneficiary(beneficiary);  // Copy for audit
    beneficiary.setStatus(BeneficiaryStatus.SUSPENDED);
    Beneficiary saved = repository.save(beneficiary);
    auditService.record(EntityType.BENEFICIARY, id, Operation.UPDATE, old, saved);
    return saved;
  }
}
```

### REST Controller

**File**: `src/main/java/com/sifap/controller/BeneficiaryController.java`

```java
@RestController
@RequestMapping("/api/beneficiaries")
@OpenAPIDefinition(...)
public class BeneficiaryController {
  
  @Autowired
  private BeneficiaryService service;
  
  @PostMapping
  @Operation(summary = "Register new beneficiary")
  public ResponseEntity<BeneficiaryResponse> register(
    @Valid @RequestBody BeneficiaryRequest request) {
    Beneficiary beneficiary = service.register(request);
    return ResponseEntity.status(CREATED).body(toResponse(beneficiary));
  }
  
  @GetMapping("/{id}")
  @Operation(summary = "Get beneficiary by ID")
  public ResponseEntity<BeneficiaryResponse> getById(@PathVariable Long id) {
    Beneficiary beneficiary = service.findById(id);
    return ResponseEntity.ok(toResponse(beneficiary));
  }
  
  @GetMapping
  @Operation(summary = "List all beneficiaries with filter")
  public ResponseEntity<Page<BeneficiaryResponse>> list(
    @RequestParam(required = false) String cpf,
    @RequestParam(required = false) BeneficiaryStatus status,
    @PageableDefault(size = 20) Pageable pageable) {
    // Implementation
  }
  
  @PutMapping("/{id}/suspend")
  @Operation(summary = "Suspend beneficiary")
  public ResponseEntity<BeneficiaryResponse> suspend(@PathVariable Long id) {
    Beneficiary beneficiary = service.suspend(id);
    return ResponseEntity.ok(toResponse(beneficiary));
  }
}
```

---

## 🎨 Frontend Development

### Setup

**Prerequisites**:
- Node.js 18+ (with npm or pnpm)
- VS Code or IntelliJ

**Project scaffolding**:
```bash
npx create-next-app@latest sifap-web --typescript --tailwind
cd sifap-web
npm install
```

### Environment Configuration

**File**: `.env.local`

```
NEXT_PUBLIC_API_URL=http://localhost:8080
NEXT_PUBLIC_AZURE_CLIENT_ID=[Entra ID App ID]
NEXT_PUBLIC_AZURE_TENANT_ID=[Entra ID Tenant ID]
```

### Key Pages

**File**: `app/beneficiaries/page.tsx`

```typescript
'use client'

import { useState, useEffect } from 'react'
import { useFetch } from '@/hooks/useFetch'
import BeneficiaryTable from '@/components/BeneficiaryTable'
import BeneficiaryForm from '@/components/BeneficiaryForm'

export default function BeneficiariesPage() {
  const [mode, setMode] = useState<'list' | 'create'>('list')
  const { data: beneficiaries, isLoading } = useFetch('/api/beneficiaries')
  
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-8">Beneficiaries</h1>
      
      {mode === 'list' ? (
        <div>
          <button
            onClick={() => setMode('create')}
            className="mb-4 px-4 py-2 bg-blue-600 text-white rounded"
          >
            Register New
          </button>
          <BeneficiaryTable 
            beneficiaries={beneficiaries} 
            isLoading={isLoading}
          />
        </div>
      ) : (
        <BeneficiaryForm onSuccess={() => setMode('list')} />
      )}
    </div>
  )
}
```

**File**: `components/BeneficiaryTable.tsx`

```typescript
import Link from 'next/link'

interface Beneficiary {
  id: number
  cpf: string
  name: string
  status: 'ACTIVE' | 'SUSPENDED' | 'CANCELLED'
  benefitType: string
}

export default function BeneficiaryTable({
  beneficiaries,
  isLoading,
}: {
  beneficiaries: Beneficiary[]
  isLoading: boolean
}) {
  if (isLoading) return <div>Loading...</div>
  
  return (
    <table className="w-full border">
      <thead>
        <tr className="bg-gray-100">
          <th className="p-3">CPF</th>
          <th className="p-3">Name</th>
          <th className="p-3">Status</th>
          <th className="p-3">Benefit Type</th>
          <th className="p-3">Actions</th>
        </tr>
      </thead>
      <tbody>
        {beneficiaries.map((b) => (
          <tr key={b.id} className="border-t hover:bg-gray-50">
            <td className="p-3">{b.cpf}</td>
            <td className="p-3">{b.name}</td>
            <td className="p-3">
              <span className={`px-2 py-1 rounded ${
                b.status === 'ACTIVE' ? 'bg-green-100' : 'bg-red-100'
              }`}>
                {b.status}
              </span>
            </td>
            <td className="p-3">{b.benefitType}</td>
            <td className="p-3">
              <Link href={`/beneficiaries/${b.id}`}>
                <a className="text-blue-600 hover:underline">View</a>
              </Link>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  )
}
```

---

## 🔗 Integration Points

### API Contracts

**Document**: Maintain `api-contracts.md` with all endpoints

**Example**:

```markdown
## POST /api/beneficiaries

Register new beneficiary.

Request:
```json
{
  "cpf": "123.456.789-10",
  "name": "John Doe",
  "email": "john@example.com",
  "benefitType": "REGULAR"
}
```

Response (201 Created):
```json
{
  "id": 1,
  "cpf": "123.456.789-10",
  "name": "John Doe",
  "status": "ACTIVE",
  "createdAt": "2026-04-28T10:00:00Z"
}
```
```

### Frontend-Backend Communication

Use API layer (`lib/api.ts`):

```typescript
export async function registerBeneficiary(data: BeneficiaryRequest) {
  const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/beneficiaries`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data),
  })
  
  if (!response.ok) {
    throw new Error(`API error: ${response.status}`)
  }
  
  return response.json()
}
```

---

## ✅ Quality and Testing

### Backend Testing

**File**: `src/test/java/com/sifap/service/BeneficiaryServiceTest.java`

```java
@SpringBootTest
public class BeneficiaryServiceTest {
  
  @Autowired
  private BeneficiaryService service;
  
  @MockBean
  private AuditService auditService;
  
  @Test
  public void testRegisterValidBeneficiary() {
    BeneficiaryRequest request = new BeneficiaryRequest(...);
    Beneficiary result = service.register(request);
    assertNotNull(result.getId());
    assertEquals(ACTIVE, result.getStatus());
  }
  
  @Test
  public void testRegisterInvalidCpf() {
    BeneficiaryRequest request = new BeneficiaryRequest("000.000.000-00", ...);
    assertThrows(InvalidCpfException.class, () -> service.register(request));
  }
  
  @Test
  public void testRegisterDuplicateCpf() {
    // Setup: beneficiary already exists
    BeneficiaryRequest request = new BeneficiaryRequest("123.456.789-10", ...);
    assertThrows(DuplicateCpfException.class, () -> service.register(request));
  }
}
```

### Frontend Testing

**File**: `__tests__/components/BeneficiaryTable.test.tsx`

```typescript
import { render, screen } from '@testing-library/react'
import BeneficiaryTable from '@/components/BeneficiaryTable'

describe('BeneficiaryTable', () => {
  it('renders beneficiary list', () => {
    const beneficiaries = [
      { id: 1, cpf: '123.456.789-10', name: 'John', status: 'ACTIVE', benefitType: 'REGULAR' },
    ]
    
    render(<BeneficiaryTable beneficiaries={beneficiaries} isLoading={false} />)
    expect(screen.getByText('John')).toBeInTheDocument()
  })
  
  it('shows loading state', () => {
    render(<BeneficiaryTable beneficiaries={[]} isLoading={true} />)
    expect(screen.getByText('Loading...')).toBeInTheDocument()
  })
})
```

### Test Coverage Target

- Backend: 70%+ line coverage
- Frontend: 60%+ component coverage
- Run: `mvn test` (backend) and `npm test` (frontend)

---

## ✅ Definition of Done

At end of Stage 3, you must have:

- [ ] **Backend (Java)**
  - [ ] All CRUD endpoints implemented (Beneficiary, Payment, Deduction, Audit)
  - [ ] All business rules enforced (validation, calculations, state transitions)
  - [ ] OpenAPI documentation generated
  - [ ] Unit tests passing with 70%+ coverage
  - [ ] PostgreSQL database schema created with audit logging

- [ ] **Frontend (Next.js)**
  - [ ] All Priority 1 pages implemented (beneficiary list/create/detail, payment list)
  - [ ] Authentication integration with Entra ID
  - [ ] Responsive design (mobile, tablet, desktop)
  - [ ] Error handling and user feedback
  - [ ] Component tests passing

- [ ] **Integration**
  - [ ] Frontend calls backend APIs successfully
  - [ ] API response times acceptable (< 500ms p99)
  - [ ] No console errors or warnings
  - [ ] CORS configured correctly

- [ ] **Documentation**
  - [ ] API endpoints documented in OpenAPI/Swagger
  - [ ] Deployment steps documented
  - [ ] Database schema documented

---

## Navigation

| Previous | Home | Next |
|---|---|---|
| [Stage 2: Modern Spec](../02-spec-moderna/GUIDE.md) | [Kit README](../README.md) | [Stage 4: Evolution](../04-evolucao/GUIDE.md) |

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Stage Home](README.md) | [Kit Home](../README.md) | [Stage 4 Home →](../04-evolucao/README.md) |
