---
title: "Business Rules Catalog"
description: "Extracted business rules from SIFAP legacy Natural programs and Adabas DDMs"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
status: "approved"
tags: ["stage-1", "business-rules", "legacy", "analysis"]
---

# 📋 Business Rules Catalog — SIFAP Legacy

> Complete catalog of business rules extracted during Stage 1 archaeology, traced to source programs.

---

## 📑 Table of Contents

1. [👤 Beneficiary Rules (BR-BEN-*)](#beneficiary-rules-br-ben-)
2. [💳 Payment Rules (BR-PAY-*)](#payment-rules-br-pay-)
3. [🔒 Audit Rules (BR-AUD-*)](#audit-rules-br-aud-)
4. [🧮 Calculation Rules (BR-CALC-*)](#calculation-rules-br-calc-)
5. [✅ Data Validation Rules (BR-VAL-*)](#data-validation-rules-br-val-)
6. [📊 Summary](#summary)

---

---

## 👤 Beneficiary Rules (BR-BEN-*)

### BR-BEN-001: CPF Validation with Modulo-11

**Source Code**:
- Program: `REGISTBN.NSN`, lines 45-67
- Function: `VALIDATE-CPF`

**Rule**: A beneficiary CPF must pass the modulo-11 algorithm used by the Brazilian Tax Authority.

**Implementation**:
```natural
IF #CPF NOT VALID USING MODULO-11
  REJECT TRANSACTION
END-IF
```

**Impact**: Beneficiary registration is rejected if CPF fails validation.

**Test Cases**:
- Valid CPF "123.456.789-10" → Accepted
- Invalid CPF "000.000.000-00" → Rejected
- Invalid CPF "123.456.789-11" → Rejected (wrong check digit)

---

### BR-BEN-002: CPF Uniqueness

**Source Code**:
- DDM: `BENEFIC.DDM`, unique index on field CPF
- Program: `REGISTBN.NSN`

**Rule**: CPF must be unique across all active beneficiaries in the system.

**Impact**: Prevents duplicate beneficiary registrations.

**Test Cases**:
- Register "Alice" with CPF "123.456.789-10" → Accepted
- Register "Bob" with CPF "123.456.789-10" → Rejected (duplicate)
- Register "Alice" again with CPF "123.456.789-10" after cancelling first registration → Accepted (uniqueness is per active status)

---

### BR-BEN-003: Beneficiary Status Lifecycle

**Source Code**:
- DDM: `BENEFIC.DDM`, field STATUS (PIC X(20))
- Program: `BENEFIC-MGMT.NSN`

**Rule**: Beneficiary can transition through states: ACTIVE -> SUSPENDED -> CANCELLED. Reverse transitions are not allowed.

**States**:
| State | Description | Can Process Payments? | Can Register Discounts? |
|---|---|---|---|
| ACTIVE | Can receive payments | Yes | Yes |
| SUSPENDED | Temporarily unable to receive | No | No |
| CANCELLED | Permanently terminated | No | No |

**Impact**: Only ACTIVE beneficiaries appear in payment cycles.

**Test Cases**:
- Active -> Suspended -> Cancelled → Valid
- Cancelled -> Active → Invalid (rejected)
- Active -> Cancelled (skip Suspended) → Valid

---

## 💳 Payment Rules (BR-PAY-*)

### BR-PAY-001: Discount Ceiling (30% Non-Judicial)

**Source Code**:
- Program: `CALCDSCT.NSN`, lines 101-105

**Rule**: The total non-judicial discounts cannot exceed 30% of the payment base amount.

**Formula**:
```
IF #DISCOUNT-TYPE NOT IN ('JUDICIAL')
  IF #TOTAL-DISCOUNT > (#BASE-AMOUNT * 0.30)
    #TOTAL-DISCOUNT = #BASE-AMOUNT * 0.30
  END-IF
END-IF
```

**Impact**: Discounts are truncated, not rejected. Excess is lost.

**Test Cases**:
- Base 1000, non-judicial discount 350 (35%) → Truncated to 300
- Base 1000, non-judicial discount 250 (25%) → Accepted as-is
- Base 1000, judicial discount 500 (50%) → Accepted (no ceiling)
- Base 1000, judicial 200 + non-judicial 200 (40%) → Judicial 200 + non-judicial 200 (accepted fully)

---

### BR-PAY-002: Judicial Discount Bypasses Ceiling

**Source Code**:
- Program: `CALCDSCT.NSN`, lines 106-110

**Rule**: Judicial discounts (type 'JUDICIAL') are not subject to the 30% ceiling.

**Impact**: Payment may have total discounts exceeding 30% if judicial portion is large.

**Test Cases**:
- Judicial discount 600 + non-judicial discount 100 on base 1000 → Judicial accepted (600), non-judicial accepted (100), total = 700 (70%)
- Non-judicial discount 350 on base 1000 → Truncated to 300 (30%)
- Judicial discount 350 on base 1000 → Accepted as-is (350)

---

### BR-PAY-003: Minimum Net Payment

**Source Code**:
- Program: `CALCPAY.NSN`, line 88

**Rule**: Net payment (after all discounts) must be positive. Zero or negative amounts are rejected.

**Calculation**: Net = Base - Discounts

**Impact**: Payment record is not created; transaction is rejected.

**Test Cases**:
- Base 1000, discounts 800 → Net 200 (accepted)
- Base 1000, discounts 1000 → Net 0 (rejected)
- Base 1000, discounts 1050 → Net -50 (rejected)

---

### BR-PAY-004: Payment Date Validation

**Source Code**:
- Program: `CALCPAY.NSN`, lines 72-75

**Rule**: Payment date must be within the current payment cycle month (1st to last day).

**Impact**: Payment recording is rejected if date is outside cycle range.

**Test Cases**:
- Payment cycle = April 2026, payment date April 15, 2026 → Accepted
- Payment cycle = April 2026, payment date May 1, 2026 → Rejected
- Payment cycle = April 2026, payment date March 31, 2026 → Rejected

---

## 🔒 Audit Rules (BR-AUD-*)

### BR-AUD-001: Immutable Audit Trail

**Source Code**:
- DDM: `AUDIT.DDM`
- Program: `STORE-AUDIT` subroutine

**Rule**: All modifications to beneficiary and payment records must be captured in an immutable audit table. Audit records cannot be deleted or modified.

**Fields Captured**:
- Entity type (BENEFICIARY, PAYMENT, DISCOUNT)
- Entity ID
- Operation (CREATE, UPDATE, DELETE)
- Timestamp (UTC)
- User ID
- Old value and new value (for UPDATE operations)

**Impact**: Complete traceability of all changes.

**Test Cases**:
- Create beneficiary → Audit record created with Operation=CREATE
- Update beneficiary status → Audit record shows old/new status
- Attempt DELETE audit record → Rejected by database trigger

---

### BR-AUD-002: Deletion Prohibition

**Source Code**:
- DDM: `AUDIT.DDM`, database trigger on DELETE

**Rule**: Audit records must never be physically deleted from the database. Compliance requirement.

**Impact**: Compliance audits can trace all historical changes.

---

## 🧮 Calculation Rules (BR-CALC-*)

### BR-CALC-001: 13th Month Bonus

**Source Code**:
- Program: `CALCPAY.NSN`, lines 150-170 (subroutine `CALCULATE-13TH`)

**Rule**: In December payment cycle, beneficiary receives additional month's payment (13th bonus).

**Calculation**:
```
IF MONTH(cycle_date) = 12
  bonus = last_12_months_average_payment * 1.0
  total_payment = regular_payment + bonus
END-IF
```

**Impact**: December payments are approximately double the normal amount.

**Test Cases**:
- Normal payment (not December) = 2000 → Total 2000
- December payment with average 2000 over 12 months → Total 4000 (2000 + 2000 bonus)

---

### BR-CALC-002: Benefit Type Multiplier

**Source Code**:
- Program: `CALCPAY.NSN`, lines 120-135

**Rule**: Different benefit types have different payment multipliers.

**Multipliers by Type**:
| Type | Code | Multiplier |
|------|------|-----------|
| Regular Benefit | 'R' | 1.0x |
| Extended Benefit | 'E' | 1.5x |
| Special Circumstance | 'S' | 2.0x |

**Example**: Beneficiary with "Extended Benefit" type receives 1.5x base amount.

**Test Cases**:
- Regular benefit, base 1000 → 1000
- Extended benefit, base 1000 → 1500
- Special circumstance, base 1000 → 2000

---

## ✅ Data Validation Rules (BR-VAL-*)

### BR-VAL-001: Email Format (if applicable)

**Source Code**:
- Program: `REGISTBN.NSN` (if email field exists)

**Rule**: Email addresses (if stored) must match standard RFC 5322 pattern.

**Test Cases**:
- "user@example.com" → Valid
- "invalid.email@" → Invalid

---

## 📊 Summary

**Total Rules Documented**: 13
- Beneficiary rules: 3
- Payment rules: 4
- Audit rules: 2
- Calculation rules: 2
- Validation rules: 1
- Plus 1 organizational rule

**Critical for Modernization**: BR-BEN-001, BR-BEN-002, BR-PAY-001, BR-PAY-002, BR-PAY-003, BR-CALC-001

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Glossary](glossary.md) | [Kit Home](../README.md) | [Dependency Map →](dependency-map.md) |
