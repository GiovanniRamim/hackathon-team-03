---
title: "payment-cycle-generation — Specification"
feature_id: "001-payment-cycle-generation"
version: "1.0.0"
date: "2026-04-29"
author: "SDD Pipeline / spec-engineer"
status: "Draft"
ears_valid: true
total_requirements: 25
---
<!-- markdownlint-disable -->
# payment-cycle-generation — Specification

> All requirements use **EARS notation** (Easy Approach to Requirements Syntax).
> Each requirement is testable, unambiguous, and traceable to a legacy business rule.

---

## Table of Contents

- [1. Payment Cycle Initiation](#1-payment-cycle-initiation)
- [2. Beneficiary Selection](#2-beneficiary-selection)
- [3. Payment Calculation](#3-payment-calculation)
- [4. Discount Application](#4-discount-application)
- [5. Payment Validation](#5-payment-validation)
- [6. 13th Month Bonus](#6-13th-month-bonus)
- [7. Payment Batch Generation](#7-payment-batch-generation)
- [8. Audit Trail](#8-audit-trail)
- [9. REST API](#9-rest-api)
- [10. Non-Functional Requirements](#10-non-functional-requirements)
- [Traceability Matrix](#traceability-matrix)

---

## 1. Payment Cycle Initiation

### REQ-PAY-001 (Event-Driven) — Operator-Initiated Payment Cycle

**When** an operator submits a request to generate a payment cycle for a given month (YYYY-MM),
**the system shall** create a new payment cycle record with status `PROCESSING` and begin calculating payments for all eligible beneficiaries.

- **Priority:** Must
- **Source:** Legacy Process 2 (CALCPAY.NSN)
- **Acceptance Criteria:**
  - AC-001: POST `/api/v1/payment-cycles` with `{ "cycleDate": "2026-05" }` returns `201 Created` with a cycle ID.
  - AC-002: The cycle record is persisted with status `PROCESSING`.
  - AC-003: Payment calculation begins asynchronously for all eligible beneficiaries.

---

### REQ-PAY-002 (Unwanted Behavior) — Duplicate Cycle Prevention

**If** a payment cycle already exists for the requested month,
**then the system shall** reject the request and return an error indicating the cycle already exists.

- **Priority:** Must
- **Source:** Implied by BR-PAY-004
- **Acceptance Criteria:**
  - AC-004: POST `/api/v1/payment-cycles` with an existing `cycleDate` returns `409 Conflict`.
  - AC-005: No duplicate cycle record is created.

---

## 2. Beneficiary Selection

### REQ-PAY-003 (State-Driven) — Active Beneficiary Inclusion

**While** a beneficiary's status is `ACTIVE`,
**the system shall** include that beneficiary in the payment cycle calculation.

- **Priority:** Must
- **Source:** BR-BEN-003
- **Acceptance Criteria:**
  - AC-006: All beneficiaries with status `ACTIVE` have a payment record created for the cycle.
  - AC-007: Beneficiaries with status `SUSPENDED` or `CANCELLED` are excluded.

---

### REQ-PAY-004 (State-Driven) — Suspended/Cancelled Exclusion

**While** a beneficiary's status is `SUSPENDED` or `CANCELLED`,
**the system shall** exclude that beneficiary from payment cycle calculations.

- **Priority:** Must
- **Source:** BR-BEN-003
- **Acceptance Criteria:**
  - AC-008: No payment record is created for `SUSPENDED` beneficiaries.
  - AC-009: No payment record is created for `CANCELLED` beneficiaries.

---

## 3. Payment Calculation

### REQ-PAY-005 (Ubiquitous) — Benefit Type Multiplier

**The system shall** apply the benefit type multiplier to the base amount when calculating payments: Regular (R) = 1.0x, Extended (E) = 1.5x, Special (S) = 2.0x.

- **Priority:** Must
- **Source:** BR-CALC-002
- **Acceptance Criteria:**
  - AC-010: Beneficiary with type `R` and base 1000 → calculated amount = 1000.
  - AC-011: Beneficiary with type `E` and base 1000 → calculated amount = 1500.
  - AC-012: Beneficiary with type `S` and base 1000 → calculated amount = 2000.

---

### REQ-PAY-006 (Ubiquitous) — Net Amount Calculation

**The system shall** calculate the net payment amount as: `NetAmount = BaseAmount * Multiplier - DiscountTotal`.

- **Priority:** Must
- **Source:** BR-PAY-003, CALCPAY.NSN
- **Acceptance Criteria:**
  - AC-013: Base 1000, multiplier 1.0, discounts 200 → net = 800.
  - AC-014: Base 1000, multiplier 1.5, discounts 300 → net = 1200.

---

## 4. Discount Application

### REQ-PAY-007 (Ubiquitous) — Non-Judicial Discount Ceiling

**The system shall** cap the total of non-judicial discounts at 30% of the base amount, truncating any excess.

- **Priority:** Must
- **Source:** BR-PAY-001
- **Acceptance Criteria:**
  - AC-015: Base 1000, non-judicial discount 350 → truncated to 300.
  - AC-016: Base 1000, non-judicial discount 250 → applied as 250.
  - AC-017: Truncation occurs silently (no error), excess is discarded.

---

### REQ-PAY-008 (Optional Feature) — Judicial Discount Bypass

**Where** a discount is of type `JUDICIAL`,
**the system shall** apply the full discount amount without applying the 30% ceiling.

- **Priority:** Must
- **Source:** BR-PAY-002
- **Acceptance Criteria:**
  - AC-018: Judicial discount of 600 on base 1000 → applied as 600 (60%).
  - AC-019: Judicial 200 + non-judicial 200 on base 1000 → both applied fully (total 400).
  - AC-020: Judicial 600 + non-judicial 350 on base 1000 → judicial 600 + non-judicial 300 (capped), total 900.

---

### REQ-PAY-009 (Ubiquitous) — Effective Date Filtering for Discounts

**The system shall** only apply discounts whose effective date range (`EffectiveFrom` to `EffectiveTo`) includes the payment cycle month.

- **Priority:** Must
- **Source:** DISCOUNT.DDM, CALCDSCT.NSN
- **Acceptance Criteria:**
  - AC-021: Discount effective 2026-01 to 2026-06, cycle 2026-04 → applied.
  - AC-022: Discount effective 2026-01 to 2026-03, cycle 2026-04 → not applied.

---

## 5. Payment Validation

### REQ-PAY-010 (Unwanted Behavior) — Reject Non-Positive Net Payment

**If** the calculated net payment amount is zero or negative,
**then the system shall** reject the payment and create the payment record with status `REJECTED`.

- **Priority:** Must
- **Source:** BR-PAY-003
- **Acceptance Criteria:**
  - AC-023: Base 1000, discounts 1000 → net 0 → status `REJECTED`.
  - AC-024: Base 1000, discounts 1050 → net -50 → status `REJECTED`.
  - AC-025: Base 1000, discounts 800 → net 200 → status `APPROVED`.

---

### REQ-PAY-011 (Unwanted Behavior) — Payment Date Validation

**If** the payment date falls outside the cycle month (1st to last day),
**then the system shall** reject the payment record.

- **Priority:** Must
- **Source:** BR-PAY-004
- **Acceptance Criteria:**
  - AC-026: Cycle 2026-04, date 2026-04-15 → accepted.
  - AC-027: Cycle 2026-04, date 2026-05-01 → rejected.
  - AC-028: Cycle 2026-04, date 2026-03-31 → rejected.

---

## 6. 13th Month Bonus

### REQ-PAY-012 (Complex) — December 13th Month Bonus

**While** the payment cycle month is December,
**when** the system calculates a beneficiary's payment,
**the system shall** add a bonus equal to the average of the beneficiary's net payments over the previous 12 months.

- **Priority:** Must
- **Source:** BR-CALC-001
- **Acceptance Criteria:**
  - AC-029: December cycle, beneficiary avg net over 12 months = 2000 → bonus = 2000, total = regular + 2000.
  - AC-030: Non-December cycle → no bonus added.
  - AC-031: Beneficiary with fewer than 12 months of history → average over available months.

---

## 7. Payment Batch Generation

### REQ-PAY-013 (Event-Driven) — Generate Bank Payment Batch

**When** all payments in a cycle have been calculated and approved,
**the system shall** generate a bank-compatible payment batch file containing all `APPROVED` payment records.

- **Priority:** Must
- **Source:** Legacy Process 2 (Payment Dispatch)
- **Acceptance Criteria:**
  - AC-032: Batch file includes all `APPROVED` payments with beneficiary bank details.
  - AC-033: `REJECTED` payments are excluded from the batch.
  - AC-034: Batch file format is compatible with bank processing requirements.

---

### REQ-PAY-014 (Event-Driven) — Cycle Status Completion

**When** the payment batch file has been generated,
**the system shall** update the cycle status from `PROCESSING` to `COMPLETED`.

- **Priority:** Must
- **Source:** Legacy Process 2
- **Acceptance Criteria:**
  - AC-035: Cycle status transitions from `PROCESSING` to `COMPLETED`.
  - AC-036: The cycle record includes a summary: total beneficiaries, total approved, total rejected, total amount.

---

## 8. Audit Trail

### REQ-PAY-015 (Ubiquitous) — Immutable Audit Record for Payments

**The system shall** create an immutable audit record for every payment operation (CREATE, UPDATE) capturing entity type, entity ID, operation, timestamp, user ID, and old/new values.

- **Priority:** Must
- **Source:** BR-AUD-001
- **Acceptance Criteria:**
  - AC-037: Creating a payment record generates an audit entry with operation `CREATE`.
  - AC-038: Updating a payment status generates an audit entry with old and new status values.
  - AC-039: Audit records include timestamp (UTC) and operator user ID.

---

### REQ-PAY-016 (Unwanted Behavior) — Audit Deletion Prevention

**If** an attempt is made to delete an audit record,
**then the system shall** reject the operation and return an error.

- **Priority:** Must
- **Source:** BR-AUD-002
- **Acceptance Criteria:**
  - AC-040: DELETE request on audit records returns `403 Forbidden`.
  - AC-041: No audit record is physically removed from the database.

---

## 9. REST API

### REQ-PAY-017 (Ubiquitous) — Payment Cycle API Endpoints

**The system shall** expose the following REST API endpoints for payment cycles:
- `POST /api/v1/payment-cycles` — create a new payment cycle
- `GET /api/v1/payment-cycles` — list payment cycles with pagination
- `GET /api/v1/payment-cycles/{id}` — retrieve a specific cycle with summary

- **Priority:** Must
- **Source:** Project conventions (copilot-instructions.md)
- **Acceptance Criteria:**
  - AC-042: POST returns `201` with cycle ID on success.
  - AC-043: GET list supports `page` and `size` query parameters.
  - AC-044: GET by ID returns cycle details including payment summary.

---

### REQ-PAY-018 (Ubiquitous) — Payment Query API Endpoints

**The system shall** expose the following REST API endpoints for payments:
- `GET /api/v1/payments` — list payments with filtering by cycle, beneficiary, and status
- `GET /api/v1/payments/{id}` — retrieve a specific payment with discount breakdown

- **Priority:** Must
- **Source:** Project conventions
- **Acceptance Criteria:**
  - AC-045: GET list supports filtering by `cycleId`, `beneficiaryId`, and `status`.
  - AC-046: GET by ID returns payment details including individual discount lines.

---

### REQ-PAY-019 (Event-Driven) — Payment Batch Download

**When** an operator requests the batch file for a completed cycle,
**the system shall** return the bank payment batch file as a downloadable resource.

- **Priority:** Must
- **Source:** Legacy Process 2
- **Acceptance Criteria:**
  - AC-047: GET `/api/v1/payment-cycles/{id}/batch` returns the file with `Content-Disposition: attachment`.
  - AC-048: Request for a cycle still in `PROCESSING` returns `409 Conflict`.

---

## 10. Non-Functional Requirements

### REQ-PAY-020 (Ubiquitous) — Processing Performance

**The system shall** process a payment cycle of 10,000+ beneficiaries within 5 minutes.

- **Priority:** Must
- **Source:** Legacy volume (10K+ payments/cycle)
- **Acceptance Criteria:**
  - AC-049: A cycle with 10,000 active beneficiaries completes in <= 300 seconds.
  - AC-050: Processing uses batch/bulk database operations to minimize round-trips.

---

### REQ-PAY-021 (Ubiquitous) — Sensitive Data Masking in Logs

**The system shall** mask CPF numbers and payment amounts in all application logs, replacing them with redacted placeholders.

- **Priority:** Must
- **Source:** copilot-instructions.md ("Never expose sensitive data in logs")
- **Acceptance Criteria:**
  - AC-051: Log output contains `CPF=***.***.***-**` instead of real CPF.
  - AC-052: Log output contains `amount=***` instead of real amounts.
  - AC-053: No grep of log files reveals unmasked CPF or amount values.

---

### REQ-PAY-022 (Ubiquitous) — Data Retention

**The system shall** retain payment and audit records for a minimum of 7 years to comply with regulatory requirements.

- **Priority:** Must
- **Source:** Discovery Report — Data retention compliance
- **Acceptance Criteria:**
  - AC-054: Records older than 7 years may be archived but not deleted.
  - AC-055: Archived records remain queryable through a dedicated endpoint.

---

### REQ-PAY-023 (Ubiquitous) — Payment Record Status Lifecycle

**The system shall** enforce the payment status lifecycle: `APPROVED` -> `PAID` or `APPROVED` -> `CANCELLED`, and `REJECTED` (terminal state).

- **Priority:** Must
- **Source:** PAYMENT.DDM status field
- **Acceptance Criteria:**
  - AC-056: APPROVED -> PAID transition succeeds.
  - AC-057: APPROVED -> CANCELLED transition succeeds.
  - AC-058: REJECTED -> any state transition is rejected.
  - AC-059: PAID -> any state transition is rejected.

---

### REQ-PAY-024 (Complex) — Flagged Payment Review

**While** a payment has been flagged for manual review,
**when** an operator approves or rejects the flagged payment,
**the system shall** update the payment status accordingly and create an audit record capturing the operator's decision.

- **Priority:** Should
- **Source:** Legacy Process 2 (Manual Review step)
- **Acceptance Criteria:**
  - AC-060: Flagged payments appear in a review queue via `GET /api/v1/payments?status=FLAGGED`.
  - AC-061: Operator can PATCH `/api/v1/payments/{id}` with `{ "status": "APPROVED" }` or `{ "status": "REJECTED" }`.
  - AC-062: Audit record captures the reviewer's user ID and decision.

---

### REQ-PAY-025 (Ubiquitous) — Error Summary in Cycle Response

**The system shall** include an error summary in the cycle response listing all rejected payments with their rejection reason.

- **Priority:** Should
- **Source:** Operational visibility
- **Acceptance Criteria:**
  - AC-063: GET `/api/v1/payment-cycles/{id}` includes a `rejectedPayments` array with beneficiary ID and reason.
  - AC-064: Reasons include "NET_AMOUNT_NON_POSITIVE", "DATE_OUT_OF_RANGE", etc.

---

## Traceability Matrix

| REQ-ID | EARS Pattern | Source Rule | Priority | Acceptance Criteria |
|--------|-------------|-------------|----------|-------------------|
| REQ-PAY-001 | Event-Driven | CALCPAY.NSN | Must | AC-001 to AC-003 |
| REQ-PAY-002 | Unwanted | BR-PAY-004 | Must | AC-004, AC-005 |
| REQ-PAY-003 | State-Driven | BR-BEN-003 | Must | AC-006, AC-007 |
| REQ-PAY-004 | State-Driven | BR-BEN-003 | Must | AC-008, AC-009 |
| REQ-PAY-005 | Ubiquitous | BR-CALC-002 | Must | AC-010 to AC-012 |
| REQ-PAY-006 | Ubiquitous | BR-PAY-003 | Must | AC-013, AC-014 |
| REQ-PAY-007 | Ubiquitous | BR-PAY-001 | Must | AC-015 to AC-017 |
| REQ-PAY-008 | Optional | BR-PAY-002 | Must | AC-018 to AC-020 |
| REQ-PAY-009 | Ubiquitous | DISCOUNT.DDM | Must | AC-021, AC-022 |
| REQ-PAY-010 | Unwanted | BR-PAY-003 | Must | AC-023 to AC-025 |
| REQ-PAY-011 | Unwanted | BR-PAY-004 | Must | AC-026 to AC-028 |
| REQ-PAY-012 | Complex | BR-CALC-001 | Must | AC-029 to AC-031 |
| REQ-PAY-013 | Event-Driven | Legacy Process 2 | Must | AC-032 to AC-034 |
| REQ-PAY-014 | Event-Driven | Legacy Process 2 | Must | AC-035, AC-036 |
| REQ-PAY-015 | Ubiquitous | BR-AUD-001 | Must | AC-037 to AC-039 |
| REQ-PAY-016 | Unwanted | BR-AUD-002 | Must | AC-040, AC-041 |
| REQ-PAY-017 | Ubiquitous | Conventions | Must | AC-042 to AC-044 |
| REQ-PAY-018 | Ubiquitous | Conventions | Must | AC-045, AC-046 |
| REQ-PAY-019 | Event-Driven | Legacy Process 2 | Must | AC-047, AC-048 |
| REQ-PAY-020 | Ubiquitous | Volume reqs | Must | AC-049, AC-050 |
| REQ-PAY-021 | Ubiquitous | Security | Must | AC-051 to AC-053 |
| REQ-PAY-022 | Ubiquitous | Compliance | Must | AC-054, AC-055 |
| REQ-PAY-023 | Ubiquitous | PAYMENT.DDM | Must | AC-056 to AC-059 |
| REQ-PAY-024 | Complex | Legacy Process 2 | Should | AC-060 to AC-062 |
| REQ-PAY-025 | Ubiquitous | Operational | Should | AC-063, AC-064 |

---

## EARS Pattern Coverage

| Pattern | Count | REQ-IDs |
|---------|-------|---------|
| Ubiquitous | 12 | REQ-PAY-005, 006, 007, 009, 015, 017, 018, 020, 021, 022, 023, 025 |
| Event-Driven | 4 | REQ-PAY-001, 013, 014, 019 |
| State-Driven | 2 | REQ-PAY-003, 004 |
| Optional Feature | 1 | REQ-PAY-008 |
| Unwanted Behavior | 4 | REQ-PAY-002, 010, 011, 016 |
| Complex | 2 | REQ-PAY-012, 024 |
| **Total** | **25** | |

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← CONSTITUTION.md](CONSTITUTION.md) | [Specs Home](../README.md) | CLARIFICATION-LOG.md → |
