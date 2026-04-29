---
title: "Mysteries Checklist"
description: "Unresolved questions from Stage 1 legacy code exploration"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
status: "approved"
tags: ["stage-1", "mysteries", "questions", "investigation"]
---

# 🔍 Open Mysteries — SIFAP Legacy Archaeology

> Track unknowns discovered during code archaeology. Resolve before Stage 2 (specification) begins. Categorize by severity.

---

## 📑 Table of Contents

1. [🔍 Critical Mysteries (Blocks Stage 2)](#critical-mysteries-blocks-stage-2)
2. [🔍 Important Mysteries (Should Clarify Before Stage 3)](#important-mysteries-should-clarify-before-stage-3)
3. [🔍 Nice-to-Know Mysteries (Can Defer Until After Go-Live)](#nice-to-know-mysteries-can-defer-until-after-go-live)
4. [📋 Resolution Tracking](#resolution-tracking)
5. [🔬 Investigation Methods](#investigation-methods)
6. [➡️ Next Steps](#next-steps)

---

---

## 🔍 Critical Mysteries (Blocks Stage 2)

These questions must be answered before architecture decisions can be made.

### M-001: Payment Record Archival Strategy

**Question**: How are payment records older than 7 years archived? Are they physically deleted from PAYMENT.DDM or moved to archive tables?

**Why it matters**: Impacts database schema design, backup strategy, and data migration approach for modernization.

**Impact**: HIGH (Must finalize retention policy)

**Discovered by**: [Team member]

**Investigation status**: OPEN
- [ ] Ask legacy system admin
- [ ] Check Adabas archival logs
- [ ] Review compliance documentation

**Resolution**: [Pending]

---

### M-002: Suspended Beneficiary Payment Workflow

**Question**: What happens to payment records for a beneficiary who is suspended mid-cycle? Are they automatically rejected, held pending, or sent to manual review?

**Why it matters**: Need to handle this scenario in modern system with a clear rule.

**Impact**: HIGH (Core payment logic)

**Discovered by**: [Team member]

**Status quo**: Program code shows status check but unclear what trigger causes suspension.

**Investigation status**: OPEN
- [ ] Trace REGISTBN for suspension logic
- [ ] Check if there are compensating transactions
- [ ] Ask operator about manual process

**Resolution**: [Pending]

---

### M-003: Multiple Active Discounts Per Beneficiary

**Question**: Can a beneficiary have multiple active discount records of the same type simultaneously (e.g., two judicial discounts)? Or is the maximum one per type?

**Why it matters**: Affects discount aggregation logic during payment calculation.

**Impact**: MEDIUM (Validation logic)

**Discovered by**: [Team member]

**Current assumption**: One discount per type (needs verification)

**Investigation status**: OPEN
- [ ] Query DISCOUNT.DDM for examples
- [ ] Review CALCULATE-DISCOUNT logic
- [ ] Test with sample data

**Resolution**: [Pending]

---

### M-004: Judicial Discount Priority and Stacking

**Question**: When a beneficiary has multiple discount types (judicial + CPMF + income tax), what is the priority order? Does judicial apply first, or is order irrelevant?

**Why it matters**: Affects net amount calculation if there are rounding or maximum amount constraints.

**Impact**: MEDIUM (Calculation correctness)

**Discovered by**: [Team member]

**Investigation status**: OPEN
- [ ] Review CALCDSCT.NSN line 101-120 in detail
- [ ] Create test case with 3+ discounts
- [ ] Ask auditor about historical disputes

**Resolution**: [Pending]

---

## 🔍 Important Mysteries (Should Clarify Before Stage 3)

These should be resolved to avoid surprises during implementation.

### M-005: Undocumented Discount Types

**Question**: Are there discount types in active use beyond J, C, I, S, O? Check if there are any "hidden" discount codes in live data.

**Why it matters**: Need complete list for modern system; missing types cause bugs in production.

**Impact**: MEDIUM (Missing functionality)

**Discovered by**: [Team member]

**Investigation status**: OPEN
- [ ] Query DISCOUNT.DDM for distinct type values
- [ ] Check if any payments have discounts of unknown types
- [ ] Ask operators for complete list

**Resolution**: [Pending]

**Findings so far**: J, C, I, S, O documented. Need to verify if these are exhaustive.

---

### M-006: Maximum Payment Amount Limits

**Question**: Is there a maximum payment amount that triggers special handling (e.g., fraud detection, extra approval)?

**Why it matters**: Modern system may need similar controls.

**Impact**: MEDIUM (Business logic completeness)

**Discovered by**: [Team member]

**Investigation status**: OPEN
- [ ] Check VALIDATE-PAYMENT subroutine
- [ ] Query PAYMENT.DDM for max amounts historically
- [ ] Ask fraud prevention team

**Resolution**: [Pending]

---

### M-007: Payment Reversal After Finance Dispatch

**Question**: If a payment has been sent to Finance system but an error is later discovered (e.g., wrong CPF), what is the reversal process? Can legacy SIFAP reverse it, or is it manual?

**Why it matters**: Modern system should have clear reversal workflow.

**Impact**: MEDIUM (Error handling)

**Discovered by**: [Team member]

**Investigation status**: OPEN
- [ ] Check if CALCPAY has reversal logic
- [ ] Ask Finance team about reconciliation process
- [ ] Review audit logs for reversal examples

**Resolution**: [Pending]

---

### M-008: CPF Validation External Service

**Question**: Does SIFAP call an external CPF validation service (e.g., Federal Tax Authority API), or is validation purely algorithmic (modulo-11)?

**Why it matters**: Modern system may need to replicate external call or replace with API.

**Impact**: MEDIUM (External dependency)

**Discovered by**: [Team member]

**Investigation status**: OPEN
- [ ] Check VALIDATE-CPF for external calls
- [ ] Look for network/API logs
- [ ] Ask legacy admin about external integrations

**Resolution**: [Pending]

**Current finding**: Appears to be local (modulo-11 only), but needs confirmation.

---

## 🔍 Nice-to-Know Mysteries (Can Defer Until After Go-Live)

These are interesting but not blocking.

### M-009: Historical System Evolution

**Question**: Why was Natural/Adabas chosen in 2015? Were there other options considered?

**Why it matters**: Historical context; helps understand architectural decisions.

**Impact**: LOW (Historical interest)

**Status**: Deferred (post-go-live)

---

### M-010: Performance Characteristics at Scale

**Question**: Have there been performance issues when beneficiary count exceeded 1M? What was the response time degradation?

**Why it matters**: Helps inform capacity planning for modern system.

**Impact**: LOW (Performance tuning)

**Status**: Deferred (post-go-live)

**Investigation approach**: Review historical load test reports if available.

---

### M-011: Batch Job Failure Recovery

**Question**: If the nightly batch (NIGHTLY-BATCH) fails mid-execution, what is the recovery process? Does it resume from checkpoint or restart?

**Why it matters**: Modern system should have similar resilience.

**Impact**: LOW (Operational knowledge)

**Status**: Deferred (post-go-live)

---

## 📋 Resolution Tracking

| Mystery ID | Status | Resolved By | Resolution Date | Answer |
|---|---|---|---|---|
| M-001 | OPEN | TBD | TBD | |
| M-002 | OPEN | TBD | TBD | |
| M-003 | OPEN | TBD | TBD | |
| M-004 | OPEN | TBD | TBD | |
| M-005 | OPEN | TBD | TBD | |
| M-006 | OPEN | TBD | TBD | |
| M-007 | OPEN | TBD | TBD | |
| M-008 | OPEN | TBD | TBD | |
| M-009 | DEFERRED | TBD | TBD | |
| M-010 | DEFERRED | TBD | TBD | |
| M-011 | DEFERRED | TBD | TBD | |

---

## 🔬 Investigation Methods

### Method 1: Code Reading

Read Natural programs, check for patterns and calls.

**Tools**: Text editor, GitHub Copilot Chat

**Time**: 15-30 minutes per program

---

### Method 2: Data Query

Query Adabas DDM samples to understand real-world variations.

**Tools**: SQL client (if DDM can be queried) or raw file inspection

**Time**: 10-20 minutes per query

---

### Method 3: Stakeholder Interview

Ask business owners or legacy admin directly.

**Stakeholders**: Operations team, auditor, legacy system admin

**Time**: 20-30 minutes per interview

---

### Method 4: Historical Audit Log Analysis

Review AUDIT.DDM for patterns of operations or edge cases.

**Tools**: SQL or report generation

**Time**: 30-60 minutes

---

## ➡️ Next Steps

1. **Assign investigators** to each critical mystery (M-001 through M-008)
2. **Schedule interviews** with legacy admin and business stakeholders
3. **Target resolution date**: Before Stage 2 kickoff (28/04 afternoon)
4. **Document findings** in discovery-report.md
5. **Update SPECIFICATION.md** with resolved business rules

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Discovery Report](discovery-report.md) | [Kit Home](../README.md) | [Mysteries Found →](mysteries-found.md) |
