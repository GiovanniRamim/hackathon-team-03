# Feature Specification: Payment Cycle Generation

**Feature Branch**: `payment-cycle-generation`  
**Created**: 2026-04-29  
**Status**: Draft  
**Input**: User description: "Allow operators to generate a monthly payment cycle for active beneficiaries."

## Goal

Allow operators to generate a monthly payment cycle (Ciclo de Pagamento) for all active beneficiaries, applying the legacy SIFAP business rules for benefit type multipliers, discount ceilings, and 13th month bonus — producing payment records with status APPROVED and a complete audit trail.

## Personas

- **Operator (Operador)** — registers beneficiaries and processes payments via SIFAP. Read/Write on beneficiaries and payments; cannot delete; can view audit logs. (Source: [glossary.md](../../01-arqueologia/glossary.md))
- **Auditor** — monitors operations and generates compliance reports. Read-only on all data. (Source: [glossary.md](../../01-arqueologia/glossary.md))

## Domain Terms

> All terms sourced from [glossary.md](../../01-arqueologia/glossary.md).

| Portuguese         | English             | Modern Equivalent                   |
| ------------------ | ------------------- | ----------------------------------- |
| Ciclo de Pagamento | Payment Cycle       | `PaymentCycle` (format YYYY-MM)     |
| Beneficiário       | Beneficiary         | `Beneficiary` (JPA entity)          |
| Pagamento          | Payment             | `Payment` (JPA entity)              |
| Desconto           | Deduction           | `Deduction` (JPA entity)            |
| Auditoria          | Audit               | `AuditLog` (JPA entity, immutable)  |
| 13º Salário        | 13th Month Bonus    | `calculateYearEndBonus()`           |
| CPMF               | Social Contribution | `DeductionType.SOCIAL_CONTRIBUTION` |
| DESIF              | Judicial Deduction  | `DeductionType.JUDICIAL`            |
| IRPF               | Income Tax          | `DeductionType.INCOME_TAX`          |

## Business Rules Applied

> All rules sourced from [business-rules-catalog.md](../../01-arqueologia/business-rules-catalog.md).

| Rule ID     | Summary                                                                                                           |
| ----------- | ----------------------------------------------------------------------------------------------------------------- |
| BR-BEN-003  | Only ACTIVE beneficiaries are included in the payment cycle. SUSPENDED and CANCELLED are excluded.                |
| BR-PAY-001  | Total non-judicial discounts capped at 30% of base amount. Excess is truncated, not rejected.                     |
| BR-PAY-002  | Judicial discounts (type J) bypass the 30% ceiling entirely.                                                      |
| BR-PAY-003  | Net payment (BaseAmount − DiscountTotal) must be positive. Zero or negative amounts are rejected.                 |
| BR-PAY-004  | Payment date must fall within the cycle month (1st to last day).                                                  |
| BR-CALC-001 | In December cycle, beneficiary receives 13th month bonus = average of last 12 months' payments.                   |
| BR-CALC-002 | Benefit type multiplier: Regular (R) = 1.0×, Extended (E) = 1.5×, Special (S) = 2.0×.                             |
| BR-AUD-001  | Every payment creation must generate an immutable audit record (operation=CREATE, entity=PAYMENT, timestamp=UTC). |
| BR-AUD-002  | Audit records cannot be deleted (compliance requirement).                                                         |

## Legacy Process Reference

> Sourced from [discovery-report.md](../../01-arqueologia/discovery-report.md) and [dependency-map.md](../../01-arqueologia/dependency-map.md).

The legacy system triggers the payment cycle on the 1st of each month via `NIGHTLY-BATCH → PROCESS-CYCLE → CALCPAY`. For each ACTIVE beneficiary:

1. `GET-BENEFIC` — fetch beneficiary master data from BENEFIC.DDM
2. `CALCULATE-DISCOUNT` → `GET-DISCOUNTS` — sum discounts from DISCOUNT.DDM, apply 30% ceiling (non-judicial), bypass ceiling for judicial
3. `VALIDATE-PAYMENT` — verify net > 0, date in cycle, all rules pass
4. `PERSIST-PAYMENT` — create payment record with status=APPROVED in PAYMENT.DDM
5. `STORE-AUDIT` — write immutable audit record to AUDIT.DDM

Performance: ~10,000+ payments per cycle, 50ms per record, total batch 30–45 minutes. (Source: [dependency-map.md](../../01-arqueologia/dependency-map.md))

## User Scenarios & Testing _(mandatory)_

### User Story 1 — Generate Monthly Payment Cycle (Priority: P1)

As an operator, I want to generate a monthly payment cycle so that all active beneficiaries receive their calculated benefit amounts for the reference month.

**Why this priority**: This is the core functionality that replaces the legacy `NIGHTLY-BATCH → CALCPAY` flow. Without it, no payments can be processed.

**Independent Test**: Log in as operator, select a reference month (YYYY-MM), trigger generation, and verify payment records are created for all ACTIVE beneficiaries with correct amounts.

**Acceptance Scenarios**:

1. **Given** there are ACTIVE beneficiaries with benefit types R, E, and S, **When** the operator generates a cycle for 2026-04, **Then** a payment record is created for each ACTIVE beneficiary with BaseAmount multiplied by the correct type multiplier (1.0×, 1.5×, 2.0×) per BR-CALC-002.
2. **Given** a beneficiary has non-judicial discounts totaling 35% of base amount, **When** the cycle is generated, **Then** the discount is truncated to 30% per BR-PAY-001, and NetAmount = BaseAmount − (BaseAmount × 0.30).
3. **Given** a beneficiary has a judicial discount of 60% of base amount, **When** the cycle is generated, **Then** the full 60% judicial discount is applied (no ceiling) per BR-PAY-002.
4. **Given** a beneficiary's discounts result in net amount ≤ 0, **When** the cycle is generated, **Then** the payment is rejected (not created) per BR-PAY-003, and the operator is informed.
5. **Given** the cycle month is December, **When** the cycle is generated, **Then** each beneficiary receives regular payment plus 13th month bonus (average of last 12 months) per BR-CALC-001.
6. **Given** beneficiaries with status SUSPENDED or CANCELLED exist, **When** the cycle is generated, **Then** they are excluded from the cycle per BR-BEN-003.
7. **Given** a payment cycle already exists for the selected month, **When** the operator attempts to generate another cycle for the same month, **Then** the system prevents duplicate generation.
8. **Given** a payment is created with status APPROVED, **When** it is persisted, **Then** an immutable audit record is created with operation=CREATE, entity=PAYMENT, and UTC timestamp per BR-AUD-001.

---

### User Story 2 — View Payment Cycle Summary (Priority: P2)

As an operator, I want to view a summary of the generated payment cycle so that I can verify totals before approval and dispatch.

**Why this priority**: The legacy system requires manual review of flagged payments before dispatch. Operators need visibility to catch errors.

**Independent Test**: Generate a cycle and verify the summary displays total beneficiaries, total gross amount, total deductions, total net amount, breakdown by benefit type (R/E/S), and count of rejected payments.

**Acceptance Scenarios**:

1. **Given** a payment cycle has been generated for 2026-04, **When** the operator opens the cycle summary, **Then** the system displays: total beneficiaries processed, total APPROVED payments, total REJECTED payments, total BaseAmount, total DiscountTotal, total NetAmount, and breakdown by benefit type.
2. **Given** there are rejected payments (net ≤ 0), **When** the operator views the summary, **Then** those payments are listed separately with the reason for rejection.

---

### User Story 3 — Audit Trail for Cycle Generation (Priority: P3)

As an auditor, I want every payment cycle generation to produce a complete audit trail so that compliance requirements are met.

**Why this priority**: BR-AUD-001 and BR-AUD-002 are compliance-critical. The legacy system maintains immutable audit records and the modern system must replicate this guarantee.

**Independent Test**: Generate a cycle and verify that each payment record has a corresponding audit log entry with EntityType=PAYMENT, Operation=CREATE, UserID, and UTC timestamp.

**Acceptance Scenarios**:

1. **Given** a cycle generates N payments, **When** the auditor queries the audit log, **Then** there are exactly N audit records with operation=CREATE and entity=PAYMENT for that cycle.
2. **Given** audit records exist, **When** any user attempts to delete or modify them, **Then** the operation is rejected per BR-AUD-002.

---

### Edge Cases

- What happens to a SUSPENDED beneficiary's pending payments from a previous cycle? (Mystery M-002, unresolved)
- Can a beneficiary have multiple active discount records of different types simultaneously? (Mystery M-003, unresolved)
- Is there a maximum payment amount that triggers special handling? (Mystery M-005, unresolved)
- How are payment disputes/corrections handled if a payment was already dispatched? (Mystery M-006, unresolved)

## Open Mysteries (from Stage 1)

> Sourced from [mysteries-found.md](../../01-arqueologia/mysteries-found.md). All pending resolution.

| ID    | Question                                                  | Impact on This Feature                                                     |
| ----- | --------------------------------------------------------- | -------------------------------------------------------------------------- |
| M-002 | What happens to suspended beneficiary's pending payments? | Defines whether SUSPENDED beneficiaries have partial payments carried over |
| M-003 | Can a beneficiary have multiple active discount records?  | Affects discount calculation logic (stacking vs. priority)                 |
| M-005 | Is there a maximum payment amount limit?                  | May require upper-bound validation                                         |
| M-006 | How are payment corrections handled after dispatch?       | Out of scope for generation, but affects downstream                        |

## Out of Scope

- Payment dispatch to Finance (status transition APPROVED → PAID)
- Beneficiary registration and status management (covered by REGISTBN flow)
- Bank integration for fund transfers
- Report generation (covered by GENRPT flow)
- Payment reversal/cancellation workflow (Issue #4 from discovery-report)
- Data archival for records > 7 years old (Mystery M-001)
- CPF validation (handled at registration, not during cycle generation)

## References

- [01-arqueologia/business-rules-catalog.md](../../01-arqueologia/business-rules-catalog.md) — BR-BEN-003, BR-PAY-001–004, BR-CALC-001–002, BR-AUD-001–002
- [01-arqueologia/discovery-report.md](../../01-arqueologia/discovery-report.md) — Payment Cycle process, data volumes, known issues
- [01-arqueologia/glossary.md](../../01-arqueologia/glossary.md) — Domain term mappings (Portuguese → English → Java)
- [01-arqueologia/dependency-map.md](../../01-arqueologia/dependency-map.md) — CALCPAY call graph and performance metrics
- [01-arqueologia/mysteries-found.md](../../01-arqueologia/mysteries-found.md) — Unresolved questions M-002, M-003, M-005, M-006

## Requirements _(mandatory)_

- Backend: Java 21 + Spring Boot 3.3 + JPA/Hibernate + PostgreSQL 16
- RESTful API at `/api/v1/payment-cycles`
- Modern equivalents per dependency-map: `PaymentService.calculateForCycle()` → `DiscountService.calculateTotal()` → `PaymentRepository.save()` + `AuditService.record()`
- Sensitive data (CPF, benefit amounts) must never be exposed in logs
- Unit tests mandatory for all business rules (BR-PAY-001–004, BR-CALC-001–002)
- Must handle volume of ~500,000 active beneficiaries (current production scale)
- Audit records must be immutable (no UPDATE/DELETE on audit table)
