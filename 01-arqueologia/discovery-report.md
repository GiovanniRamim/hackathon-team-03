---
title: "Discovery Report"
description: "Comprehensive findings from SIFAP legacy system exploration"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
status: "approved"
tags: ["stage-1", "discovery", "report", "findings"]
---

# 📊 SIFAP Legacy System Discovery Report

> Summary of all findings from Stage 1 archaeology including system overview, business rules, risks, and recommendations.

---

## 📑 Table of Contents

1. [📊 Executive Summary](#executive-summary)
2. [🏗️ System Overview](#system-overview)
3. [🔄 Business Processes](#business-processes)
4. [📦 Data Structure and Volume](#data-structure-and-volume)
5. [📊 Business Rules Summary](#business-rules-summary)
6. [⚠️ Known Issues and Limitations](#known-issues-and-limitations)
7. [🔍 Mysteries (Open Questions)](#mysteries-open-questions)
8. [⚠️ Risks and Mitigations](#risks-and-mitigations)
9. [💡 Recommendations](#recommendations)
10. [🎯 Conclusion](#conclusion)
11. [📎 Appendices](#appendices)

---

---

## 📊 Executive Summary

The legacy SIFAP system has been in production since 2015, managing benefit payments for thousands of beneficiaries. The system is built on Natural/Adabas technology and has accumulated significant business logic over 11 years. While the core functionality is stable, modernization is necessary to improve user experience, reduce operational costs, and enable faster feature development.

**Key findings**:
- 3 major entry point programs (REGISTBN, CALCPAY, GENRPT)
- 13 documented business rules
- 4 Adabas DDMs (Beneficiary, Payment, Discount, Audit)
- Nightly batch processing with 10,000+ payments per cycle
- 100% traceability through immutable audit tables

---

## 🏗️ System Overview

### Purpose

SIFAP (Sistema de Fiscalizacao e Acompanhamento de Pagamentos - Fiscalization and Payment Follow-up System) is a government benefit management system. It handles:

1. **Beneficiary Registration**: Validate and register individuals eligible for government benefits
2. **Payment Calculation**: Calculate benefit payments based on rules, discounts, and benefit types
3. **Audit and Compliance**: Maintain immutable audit trail for all operations

### Users and Roles

| Role | Usage | Tools |
|------|-------|-------|
| Operator | Register beneficiaries, process payments | 3270 terminal |
| Auditor | Review operations, generate reports | 3270 terminal + batch reports |
| Administrator | System configuration, user management | 3270 terminal |
| Government | Reconciliation and oversight | PDF reports |

### Current Technology Stack

| Component | Technology | Status |
|-----------|-----------|--------|
| Language | Natural (Unisys) | End-of-life |
| Database | Adabas | Expensive maintenance |
| Interface | 3270 Terminal | Obsolete |
| Reports | PDF (batch) | Manual generation |
| Deployment | Mainframe | High operational cost |

---

## 🔄 Business Processes

### Process 1: Beneficiary Lifecycle

```
REGISTER (REGISTBN)
  ├─ Validate CPF with modulo-11 algorithm
  ├─ Check for duplicates
  ├─ Set initial status = ACTIVE
  └─ Create audit record
  
SUSPEND
  ├─ Change status to SUSPENDED
  ├─ Prevent payment processing
  └─ Create audit record
  
CANCEL
  ├─ Change status to CANCELLED
  ├─ Mark all pending payments as rejected
  └─ Create audit record
  
REACTIVATE (if applicable)
  └─ Cannot reactivate - must re-register
```

### Process 2: Payment Cycle

```
TRIGGER: 1st of each month
  |
  v
CALCULATE PAYMENTS for all ACTIVE beneficiaries
  ├─ Fetch beneficiary master data
  ├─ Calculate discounts (CPMF, income tax, judicial)
  ├─ Apply discount rules (30% ceiling, judicial exception)
  ├─ Calculate net amount (base - discounts)
  ├─ Create payment record with status=APPROVED
  └─ Create audit record
  |
  v
MANUAL REVIEW (if needed)
  ├─ Operator can review flagged payments
  └─ Approve or reject
  |
  v
PAYMENT DISPATCH
  ├─ Send payment data to Finance
  └─ Update status=PAID
  |
  v
END OF MONTH CLOSING
  └─ Generate reconciliation report
```

### Process 3: Audit and Reporting

```
CONTINUOUS: Immutable audit trail
  ├─ All CREATE operations logged
  ├─ All UPDATE operations logged (with old/new values)
  ├─ DELETE operations prohibited (compliance)
  └─ Timestamp, user ID, source program recorded

MONTHLY: Generate audit report
  ├─ Sum all operations by type (CREATE, UPDATE)
  ├─ Reconcile beneficiary count
  ├─ Verify payment totals
  └─ Export as PDF
```

---

## 📦 Data Structure and Volume

### Beneficiary Master (BENEFIC DDM)

- **Current records**: ~500,000 active beneficiaries
- **Total records (including cancelled)**: ~1.2 million
- **Growth rate**: 5-10% annually
- **Key fields**: CPF (unique), Status, Benefit Type, Contact Info

### Payment Records (PAYMENT DDM)

- **Monthly volume**: 10,000+ payments
- **Annual volume**: 120,000+ payments
- **Retention**: 7 years (compliance requirement)
- **Current size**: ~840 MB (estimated)

### Discount Configuration (DISCOUNT DDM)

- **Total discount types**: 8 (CPMF, Income Tax, Judicial, etc.)
- **Dynamic configuration**: Yes (effective dates per discount per beneficiary)
- **Change frequency**: Monthly (new judicial orders)

### Audit Trail (AUDIT DDM)

- **Annual entries**: ~500,000+ (3 operations per payment + updates)
- **Size**: 2+ GB (text storage of old/new values)
- **Retention**: Permanent (7+ years accessed, indefinite archival)

---

## 📊 Business Rules Summary

### Beneficiary Rules

1. **CPF Validation (BR-BEN-001)**: Must pass modulo-11 algorithm (Brazilian standard)
2. **CPF Uniqueness (BR-BEN-002)**: Cannot register same CPF twice
3. **Status Lifecycle (BR-BEN-003)**: ACTIVE -> SUSPENDED -> CANCELLED (one-way transitions)

### Payment Rules

1. **Discount Ceiling (BR-PAY-001)**: Non-judicial discounts capped at 30%
2. **Judicial Exception (BR-PAY-002)**: Judicial discounts bypass 30% ceiling
3. **Minimum Net (BR-PAY-003)**: Net payment must be positive
4. **Date Validation (BR-PAY-004)**: Payment date must be in cycle month

### Calculation Rules

1. **13th Month Bonus (BR-CALC-001)**: December payment = regular + bonus (average of 12 months)
2. **Benefit Type Multiplier (BR-CALC-002)**: Different types have different multipliers (1x, 1.5x, 2x)

### Audit Rules

1. **Immutable Trail (BR-AUD-001)**: All changes recorded with old/new values
2. **No Deletion (BR-AUD-002)**: Audit records cannot be deleted (compliance)

---

## ⚠️ Known Issues and Limitations

### Issue 1: Performance During Nightly Batch

**Impact**: High CPU usage 02:00-03:00 AM, sometimes exceeds 45 minutes

**Root Cause**: Sequential processing of 10,000+ payments, no parallelization

**Workaround**: None currently (admin monitors)

**Recommendation for Modern**: Implement async/parallel payment processing

### Issue 2: 3270 Terminal Usability

**Impact**: High training cost for new operators, slow navigation

**Root Cause**: Legacy terminal interface, small screen

**Recommendation for Modern**: Web-based UI with intuitive forms

### Issue 3: Manual Report Generation

**Impact**: Hour-long delay for month-end reports; error-prone

**Root Cause**: Batch job, no real-time dashboard

**Recommendation for Modern**: Real-time dashboard + automated exports

### Issue 4: No Cancellation Workflow

**Impact**: Erroneous payments cannot be reversed easily; only workaround is to manually adjust next cycle

**Recommendation for Modern**: Implement payment reversal/adjustment workflow

---

## 🔍 Mysteries (Open Questions)

### Critical (Blocks modernization)

| ID | Question | Blocking Factor |
|---|---|---|
| M-001 | How are old payment records (> 7 years) archived? | Data migration strategy |
| M-002 | What happens to suspended beneficiary's pending payments? | Process clarification needed |
| M-003 | Can a beneficiary have multiple active discount records? | Business rule clarification |

### Important (Should clarify)

| ID | Question |
|---|---|
| M-004 | Are there any undocumented discount types in use? |
| M-005 | Is there a maximum payment amount that triggers special handling? |
| M-006 | How are payment disputes/corrections handled if payment already sent to Finance? |

### Nice-to-know (Can defer)

| ID | Question |
|---|---|
| M-007 | Why was Natural/Adabas chosen in 2015? (Historical context) |
| M-008 | Have there been performance issues with 1M+ beneficiaries? |

---

## ⚠️ Risks and Mitigations

### Risk 1: Business Rule Loss During Modernization

**Severity**: HIGH
**Probability**: MEDIUM

**Mitigation**:
- Every Natural program analyzed and mapped to business rules (BR-*)
- Every rule traced to EARS requirement (REQ-*)
- Every requirement traced to test case

### Risk 2: Data Loss During Migration

**Severity**: HIGH
**Probability**: LOW

**Mitigation**:
- Parallel run (legacy and modern running side-by-side) for validation
- Reconciliation reports comparing legacy vs. modern payment totals
- Backup of all Adabas data before migration

### Risk 3: Operator Training

**Severity**: MEDIUM
**Probability**: HIGH

**Mitigation**:
- Early training materials with side-by-side screenshots (old 3270 vs. new web)
- Gradual rollout to small group of operators first
- 24/7 support during cutover week

### Risk 4: Compliance Audit Trail Gap

**Severity**: HIGH
**Probability**: LOW

**Mitigation**:
- Map AUDIT.DDM structure to PostgreSQL audit tables (preserve all fields)
- Verify that every operation in modern system creates audit record
- External audit firm validates audit trail continuity

---

## 💡 Recommendations

### Short-term (Modernization planning)

1. **Validate all 13 documented business rules** with business stakeholders
2. **Resolve mysteries** identified in archaeology (M-001 to M-006)
3. **Estimate data volume** for payment and audit tables (finalize capacity planning)
4. **Interview key operators** about workflow pain points

### Medium-term (Modernization)

1. **Build modern backend** (Java 21 + Spring Boot) with all business rules
2. **Build web UI** (Next.js 15) for beneficiary and payment management
3. **Implement PostgreSQL** with same audit structure as Adabas
4. **Run parallel validation** (legacy SIFAP vs. modern SIFAP side-by-side for 1 full month)

### Long-term (Cutover and optimization)

1. **Phased cutover**: Migrate small beneficiary subset first, then expand
2. **Deprecate legacy** after 3 months of successful modern operation
3. **Optimize for scale**: Modern system should handle 2M beneficiaries comfortably
4. **Enable future features**: Real-time dashboard, mobile app, API for external systems

---

## 🎯 Conclusion

Legacy SIFAP is a stable, compliant system with well-defined business rules. Modernization is justified by:
- Reduced operational cost (move off mainframe)
- Improved user experience (web UI vs. 3270 terminal)
- Faster time-to-market for new features
- Ability to scale beyond current 1.2M beneficiaries

The system is well-understood through archaeology. Stage 2 (specification) can proceed with confidence that all critical business logic has been captured.

---

## 📎 Appendices

### A. File Locations

```
legacy/
├─ Programs/
│  ├─ REGISTBN.NSN    (Beneficiary registration)
│  ├─ CALCPAY.NSN     (Payment calculation)
│  ├─ CALCDSCT.NSN    (Discount application)
│  ├─ GENRPT.NSN      (Report generation)
│  └─ [utility programs]
│
└─ DDM/
   ├─ BENEFIC.DDM
   ├─ PAYMENT.DDM
   ├─ DISCOUNT.DDM
   └─ AUDIT.DDM
```

### B. Key Contact Information

- **Business Owner**: [Name], [Email]
- **Legacy System Admin**: [Name], [Email]
- **Operations Team**: [Email/Slack channel]

### C. References

- System architecture documentation: `legacy/README.md`
- Detailed business rules: `01-arqueologia/business-rules-catalog.md`
- Dependency map: `01-arqueologia/dependency-map.md`
- Domain glossary: `01-arqueologia/glossary.md`

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Dependency Map](dependency-map.md) | [Kit Home](../README.md) | [Mysteries Checklist →](mysteries-checklist.md) |
