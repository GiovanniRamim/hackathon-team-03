---
title: "Stage 2 — Modern Spec Guide"
description: "Guide for writing EARS specifications and architecture decisions for modernized SIFAP"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.2.0"
status: "approved"
tags: ["stage-2", "specification", "architecture", "design", "adr"]
---

# 📋 Stage 2: Modern Spec

> ⏱️ **Duration**: 3 hours. This is where we distill what we learned in Stage 1 into a precise, testable specification that will guide implementation. Every requirement must be written in EARS notation with a unique ID (REQ-*) and measurable acceptance criteria.

---

## 📑 Table of Contents

1. [Where are we on the journey](#-where-are-we-on-the-journey)
2. [Objective](#-objective)
3. [EARS Notation Primer](#-ears-notation-primer)
4. [Specification Workflow](#-specification-workflow)
5. [ADR Template](#-adr-template)
6. [Quality Checklist](#-quality-checklist)
7. [Output Artifacts](#-output-artifacts)
8. [Definition of Done](#-definition-of-done)
9. [Navigation](#-navigation)

---

## 🎬 Where are we on the journey

You've completed archaeology (Stage 1). You have 13 business rules documented, dependencies mapped, mysteries mostly resolved. Now comes specification: translating this knowledge into a precise, unambiguous requirements document that developers can implement.

**Key principle**: A good specification is testable. If you can't write a test for it, it's not specific enough.

---

## 🎯 Objective

Write a complete SPECIFICATION.md using EARS (Easy Approach to Requirements Syntax) notation, establish architecture decisions through Architecture Decision Records (ADRs), and document scope decisions (what's in/out of modern SIFAP).

**Deliverables**:
1. SPECIFICATION.md with 30+ EARS requirements (REQ-*)
2. 5-8 Architecture Decision Records (ADR-*)
3. Scope decisions document (migrations, deletions, evolutions)
4. Cross-referenced with Stage 1 artifacts

---

## 📖 EARS Notation Primer

EARS is a structured way to write requirements so they're unambiguous and testable.

### The 6 EARS Patterns

#### Pattern 1: Ubiquitous Requirement

**Trigger**: Something that must always be true about the system.

**Format**: **The system shall** [action]

**Examples**:
- REQ-BEN-001: The system shall validate beneficiary CPF using modulo-11 algorithm.
- REQ-AUD-001: The system shall maintain an immutable audit trail of all changes.

**Test**: "Does the system always do this? Yes/No?"

---

#### Pattern 2: Event-Driven Requirement

**Trigger**: When something happens, the system must respond.

**Format**: **When [event], the system shall** [action]

**Examples**:
- REQ-PAY-001: When a payment is created, the system shall apply all discount rules.
- REQ-BEN-002: When a beneficiary is suspended, the system shall reject any pending payments.

**Test**: "If event happens, does the system respond correctly? Yes/No?"

---

#### Pattern 3: State-Driven Requirement

**Trigger**: While the system is in a particular state, something must be true.

**Format**: **While [state], the system shall** [action]

**Examples**:
- REQ-BEN-003: While a beneficiary is in SUSPENDED state, the system shall prevent payment processing.
- REQ-AUD-002: While in production, the system shall retain audit logs for 7 years minimum.

**Test**: "In this state, is this true? Yes/No?"

---

#### Pattern 4: Optional Requirement

**Trigger**: Under specific conditions, the system must do something.

**Format**: **Where [condition], the system shall** [action]

**Examples**:
- REQ-PAY-002: Where a discount type is JUDICIAL, the system shall bypass the 30% discount ceiling.
- REQ-CALC-001: Where the payment cycle is December, the system shall add a 13th month bonus.

**Test**: "If condition is met, does this apply? Yes/No?"

---

#### Pattern 5: Unwanted Behavior

**Trigger**: The system must NOT do something, even if provoked.

**Format**: **If [condition], then the system shall NOT** [action]

**Examples**:
- REQ-AUD-003: If a user attempts to delete an audit record, then the system shall NOT permit the deletion.
- REQ-PAY-003: If the net payment becomes zero or negative, then the system shall NOT create the payment record.

**Test**: "Can the system be made to do this? No."

---

#### Pattern 6: Complex Requirement

**Trigger**: Combination of state, event, and condition.

**Format**: **While [state], when [event], where [condition], the system shall** [action]

**Examples**:
- REQ-PAY-004: While processing a payment cycle, when calculating discounts, where the beneficiary has judicial deductions, the system shall apply them before other discounts.

---

### Writing Good Acceptance Criteria

Each EARS requirement needs 2-3 acceptance criteria - measurable test cases.

**Template**:

```markdown
### REQ-BEN-001: Validate beneficiary CPF

**Type**: Ubiquitous

**Statement**: The system shall validate beneficiary CPF using modulo-11 algorithm.

**Acceptance Criteria**:
1. Given valid CPF "123.456.789-10", when registering beneficiary, then registration succeeds
2. Given invalid CPF "123.456.789-11", when registering beneficiary, then registration fails with error "Invalid CPF"
3. Given all-zero CPF "000.000.000-00", when registering beneficiary, then registration fails

**Traceability**: Maps to BR-BEN-001 from Stage 1
```

---

## 🔄 Specification Workflow

### Phase 1: Organize Legacy Business Rules (45 minutes)

Start with Stage 1 artifacts:
- Business Rules Catalog (BR-*)
- Dependency Map
- Glossary

For each business rule, write EARS requirements:

| BR ID | BR Description | EARS Pattern | REQ ID | REQ Statement |
|-------|---|---|---|---|
| BR-BEN-001 | CPF validation | Ubiquitous | REQ-BEN-001 | The system shall validate CPF with modulo-11 |
| BR-PAY-001 | 30% discount ceiling | Optional | REQ-PAY-001 | Where discount type is non-judicial, the system shall limit discount to 30% |
| BR-AUD-001 | Immutable audit | Ubiquitous | REQ-AUD-001 | The system shall maintain immutable audit trail |

**Output**: 15-20 REQ-* statements

---

### Phase 2: Add Modern Requirements (45 minutes)

Write new requirements for features not in legacy SIFAP:

1. **User experience**
   - REQ-UI-001: The system shall provide a responsive web interface accessible on mobile devices
   - REQ-UI-002: The system shall support dark mode theme

2. **Integration**
   - REQ-API-001: The system shall expose REST APIs with OpenAPI documentation
   - REQ-AUTH-001: The system shall authenticate users via OAuth2/Entra ID

3. **Performance**
   - REQ-PERF-001: The system shall calculate payments for 10,000 beneficiaries within 15 minutes
   - REQ-PERF-002: The system shall respond to beneficiary queries within 500ms (p99)

4. **Security**
   - REQ-SEC-001: The system shall encrypt all secrets using Azure Key Vault
   - REQ-SEC-002: The system shall log all access for audit purposes

**Output**: 10-15 additional REQ-* statements

---

### Phase 3: Architecture Decisions (60 minutes)

For each major design choice, write an ADR:

1. **Technology choices**
   - ADR-001: Why Java 21 + Spring Boot?
   - ADR-002: Why Next.js 15 for frontend?
   - ADR-003: Why PostgreSQL over legacy Adabas?

2. **Architecture patterns**
   - ADR-004: Monolith vs. microservices?
   - ADR-005: Real-time processing vs. batch?

3. **Data handling**
   - ADR-006: How to migrate 7 years of payment history?
   - ADR-007: How to maintain audit trail across systems?

**Output**: 5-8 ADR-* documents

---

## 📝 ADR Template

Use the `ADR-TEMPLATE.md` file in this directory as a starting point.

**Minimal ADR structure**:

```markdown
# ADR-NNN: [Title]

**Status**: Proposed | Accepted | Rejected

**Context**: Why did we need to make a decision?

**Decision**: What did we decide?

**Rationale**: Why this choice over alternatives?

**Consequences**: What are the trade-offs?

**Alternatives Considered**:
- Alternative A: [description] - Rejected because...
- Alternative B: [description] - Rejected because...

**Approval**: [Tech Lead, Product Owner, Architect signatures]
```

---

## ✅ Quality Checklist

Before moving to Stage 3, ensure your specification meets these criteria:

### Completeness

- [ ] All Stage 1 business rules mapped to REQ-*
- [ ] All modern requirements documented
- [ ] REQ-* count is 30+ (covers beneficiary, payment, audit, UI, API, security, performance)
- [ ] Every REQ has 2-3 acceptance criteria
- [ ] Every REQ has EARS pattern label

### Clarity

- [ ] Every REQ written in active voice ("the system shall", not "should be")
- [ ] No ambiguous words ("may", "might", "could")
- [ ] No domain jargon without glossary reference
- [ ] Every acceptance criterion is testable (use Given/When/Then format)

### Traceability

- [ ] Every modern REQ-* traces back to BR-* or new capability
- [ ] Every ADR references the requirements it impacts
- [ ] Dependencies between requirements documented (if A, then B)

### Architecture

- [ ] 5-8 ADRs covering major decisions
- [ ] Each ADR includes alternatives considered
- [ ] Risk/mitigation documented for each ADR

---

## 📊 Output Artifacts

### Artifact 1: SPECIFICATION.md

**Location**: the **reference SIFAP 2.0 Spec** (shared by facilitators at start of Stage 2)

**Structure**:
```markdown
# SIFAP 2.0 Specification

## Overview
[Brief description of system scope and objectives]

## Functional Requirements

### Beneficiary Management (REQ-BEN-*)
[List all beneficiary-related requirements]

### Payment Processing (REQ-PAY-*)
[List all payment-related requirements]

### Audit and Compliance (REQ-AUD-*)
[List all audit-related requirements]

### User Interface (REQ-UI-*)
[List all UI requirements]

### API and Integration (REQ-API-*)
[List all API requirements]

### Security (REQ-SEC-*)
[List all security requirements]

### Performance (REQ-PERF-*)
[List all performance requirements]

## Non-Functional Requirements
[Cross-cutting concerns: scalability, availability, etc.]

## Glossary
[Reference to 01-arqueologia/glossary.md]

## Traceability Matrix
[Table showing REQ -> BR -> Test mapping]
```

### Artifact 2: Architecture Decision Records

**Location**: the **reference ADRs** (provided by facilitators)

**Naming**: ADR-001-java21.md, ADR-002-nextjs15.md, etc.

### Artifact 3: Scope Decisions

**Location**: `02-spec-moderna/scope-decisions.md`

**Content**:
- What's being migrated from legacy? (With priority)
- What's being discarded? (With rationale)
- What's being evolved? (With improvements)
- Timeline and phases

---

## ✅ Definition of Done

At the end of Stage 2, you must have:

- [ ] SPECIFICATION.md with 30+ EARS requirements (REQ-*)
  - [ ] Each REQ has ID (REQ-XXX-NNN format)
  - [ ] Each REQ labeled with EARS pattern (Ubiquitous, Event-driven, State-driven, Optional, Unwanted, Complex)
  - [ ] Each REQ has 2-3 acceptance criteria in Given/When/Then format
  - [ ] Each REQ traces to Stage 1 business rule (BR-*) or new capability

- [ ] 5-8 Architecture Decision Records (ADR-*)
  - [ ] Each ADR covers a major technical decision
  - [ ] Each ADR includes context, decision, rationale, and consequences
  - [ ] Each ADR documents alternatives considered
  - [ ] Each ADR is approved by tech lead and architect

- [ ] Scope Decisions document showing:
  - [ ] What will be migrated (with techniques)
  - [ ] What will be discarded (with reasons)
  - [ ] What will be evolved (with improvements)
  - [ ] Migration timeline and phases
  - [ ] Known risks and mitigations

- [ ] Quality checklist completed:
  - [ ] No ambiguous wording
  - [ ] Every requirement testable
  - [ ] Full traceability (REQ -> BR -> Test)
  - [ ] All Stage 1 mysteries resolved

---

## 💡 Pro Tips

1. **Use GitHub Copilot Chat to draft requirements**: "Based on this business rule, write 3 EARS requirements in different patterns"
2. **Validate EARS syntax**: Each REQ should start with "The system shall", "When", "While", or "Where"
3. **Get stakeholder review early**: Have business owners review REQ drafts before Stage 3 implementation starts
4. **Create acceptance criteria as test cases**: Write them so QA can turn them into automated tests
5. **Leverage Specky SDD tool**: Use `sdd_write_spec` to generate structured spec template

---

## Navigation

| Previous | Home | Next |
|---|---|---|
| [Stage 1: Archaeology](../01-arqueologia/GUIDE.md) | [Kit README](../README.md) | [Stage 3: Implementation](../03-implementacao/GUIDE.md) |

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Stage Home](README.md) | [Kit Home](../README.md) | [ADR Template →](ADR-TEMPLATE.md) |
