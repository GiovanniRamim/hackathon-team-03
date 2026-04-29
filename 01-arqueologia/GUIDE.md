---
title: "Stage 1 — Archaeology Guide"
description: "Guide for discovering legacy SIFAP domain through code exploration and systematic documentation"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.2.0"
status: "approved"
tags: ["stage-1", "archaeology", "discovery", "legacy", "natural", "adabas"]
---

# 🏛️ Stage 1: Archaeology

> ⏱️ **Duration**: 2 hours. This is where we learn from history. By systematically exploring the legacy SIFAP codebase, we uncover the business rules, hidden dependencies, and mysteries that will inform the modern design.

<p align="center">
  <img src="../assets/archaeology-journey.svg" alt="Journey through legacy code" width="100%"/>
</p>

---

## 📑 Table of Contents

1. [Where are we on the journey](#-where-are-we-on-the-journey)
2. [Objective](#-objective)
3. [What you'll find in legacy SIFAP](#-what-youll-find-in-legacy-sifap)
4. [Archaeology Workflow](#-archaeology-workflow)
5. [Discovery Tools](#-discovery-tools)
6. [Mysteries Checklist](#-mysteries-checklist)
7. [Output Artifacts](#-output-artifacts)
8. [Definition of Done](#-definition-of-done)
9. [Navigation](#-navigation)

---

## 🎬 Where are we on the journey

You're standing at the mouth of a cave. Inside are decades of business knowledge encoded in Natural programs and Adabas databases. Some of this knowledge is documented. Most of it isn't.

Your mission: Go in, map what you find, write it down clearly. The modern SIFAP will be built on this foundation. Get it wrong here, and Stage 2 and 3 will fail.

> 💡 **Mindset**: Treat legacy code like archaeology. You're not there to fix or judge. You're there to understand why it exists and what it reveals about the business.

---

## 🎯 Objective

Systematically explore the legacy SIFAP codebase (Natural programs, Adabas DDMs), document business rules, map dependencies, identify unknowns, and prepare a comprehensive discovery report that informs the modern architecture.

**Deliverables**:
1. Business Rules Catalog (BR-001, BR-002, etc.)
2. Dependency Map (visual + list)
3. Glossary (SIFAP domain terms)
4. Mysteries Checklist (unknowns and questions)
5. Discovery Report (comprehensive findings)

---

## 📦 What you'll find in legacy SIFAP

### Folder Structure

```
legacy/
├─ DDM/                      # Adabas data definitions
│  ├─ BENEFIC.DDM            # Beneficiary master data
│  ├─ PAYMENT.DDM            # Payment records
│  ├─ DISCOUNT.DDM           # Discount calculations
│  └─ AUDIT.DDM              # Audit tables
│
├─ Programs/                 # Natural source code
│  ├─ REGISTBN.NSN           # Register beneficiary
│  ├─ CALCPAY.NSN            # Calculate payment
│  ├─ CALCDSCT.NSN           # Calculate discount
│  ├─ GENRPT.NSN             # Generate reports
│  └─ README-Programs.md     # Program guide
│
├─ Data/                     # Sample data and test cases
│  ├─ beneficiaries.csv
│  ├─ payments.csv
│  └─ test-scenarios.xlsx
│
└─ README.md                 # Overview of legacy system
```

### Natural Program Example

**File: `legacy/natural-programs/CALCPAY.NSN`**

```natural
* Program: CALCPAY
* Purpose: Calculate payment amount for beneficiary
* Date: 2015-03-12
* Author: (Unknown)

PROCESS SQL
  DEFINE DATA LOCAL
    1 #BENEFIC-ID PIC 9(8)
    1 #BENEFIT-TYPE PIC X(3)
    1 #BASE-AMOUNT DEC(13,2)
    1 #DISCOUNT-TOTAL DEC(13,2)
    1 #NET-AMOUNT DEC(13,2)
    1 #PAYMENT-DATE PIC D
    1 #STATUS PIC X(20)
  END-DEFINE

  RESET
  
  * Get beneficiary and discount info
  SELECT (BENEFIC.ID, BENEFIT.TYPE, BENEFIT.AMOUNT)
    FROM BENEFIC, BENEFIT
    WHERE BENEFIC.ID = #BENEFIC-ID
    AND BENEFIT.BENEFIC_ID = BENEFIC.ID
  INTO (#BENEFIC-ID, #BENEFIT-TYPE, #BASE-AMOUNT)
  
  * Calculate discounts
  PERFORM CALCULATE-DISCOUNT
  
  * Net amount = Base - Discounts
  COMPUTE #NET-AMOUNT = #BASE-AMOUNT - #DISCOUNT-TOTAL
  
  * Validation
  IF #NET-AMOUNT < 0
    SET #STATUS = 'INVALID_CALCULATION'
    REJECT
  END-IF
  
  * Record payment
  STORE (PAYMENT.ID, PAYMENT.AMOUNT, PAYMENT.DATE)
    VALUES (NEXT SEQUENCE, #NET-AMOUNT, #PAYMENT-DATE)
  
  SET #STATUS = 'SUCCESS'
  ACCEPT
END-PROCESS

PERFORM CALCULATE-DISCOUNT
  SELECT SUM(DISCOUNT.AMOUNT)
    FROM DISCOUNT
    WHERE DISCOUNT.BENEFIC_ID = #BENEFIC-ID
    AND DISCOUNT.TYPE NOT IN ('JUDICIAL')
  INTO #DISCOUNT-TOTAL
  
  * Apply 30% ceiling on non-judicial discounts
  IF #DISCOUNT-TOTAL > (#BASE-AMOUNT * 0.30)
    COMPUTE #DISCOUNT-TOTAL = #BASE-AMOUNT * 0.30
  END-IF
END-PERFORM
```

---

## 🔍 Archaeology Workflow

### Phase 1: Initial Exploration (30 mins)

1. **Read the README**
   - `legacy/README.md` - Overview and history
   - Understand the domain: What is SIFAP? Who uses it? What problems does it solve?

2. **Map the programs**
   - List all Natural programs in `legacy/natural-programs/`
   - Note the naming convention (REGISTBN, CALCPAY, etc.)
   - Identify entry points (programs called by users vs. utility programs)

3. **Understand the data**
   - Read each Adabas DDM (Data Definition Module)
   - Understand the logical structure: Beneficiary -> Payment -> Audit
   - Note data types, field sizes, constraints

### Phase 2: Deep Dive into Business Logic (60 mins)

For each major program, identify:

1. **Input**: What data does it read?
2. **Processing**: What calculations or transformations happen?
3. **Output**: What data is produced?
4. **Rules**: What business rules are enforced?

Document as a business rule:

| BR-ID | Program | Rule | Type |
|-------|---------|------|------|
| BR-001 | REGISTBN | Beneficiary CPF must be validated with modulo-11 algorithm | Validation |
| BR-002 | CALCPAY | Discount ceiling is 30% of base payment, except judicial | Calculation |
| BR-003 | CALCPAY | Judicial discounts bypass the 30% ceiling | Exception |
| BR-004 | GENRPT | Reports must include audit trail of all modifications | Audit |

### Phase 3: Dependency Mapping (30 mins)

Create a map showing how programs interact:

```
REGISTBN ──calls──> VALIDATE-CPF
                    REGISTBN ──calls──> UPDATE-BENEFIC (Adabas)

CALCPAY ──calls──> CALCULATE-DISCOUNT
        ──calls──> VALIDATE-PAYMENT
        ──calls──> STORE-AUDIT (Adabas)

GENRPT ──calls──> READ-AUDIT (Adabas)
       ──calls──> FORMAT-REPORT
       ──calls──> EXPORT-PDF
```

---

## 🧰 Discovery Tools

### Tool 1: Copilot Chat (Analyze Legacy Code)

**Prompt**: "I have this Natural program [paste code]. What business rules does it enforce?"

**Expected output**: Extracted rules, decision logic, edge cases.

### Tool 2: Glossary Builder

Create a glossary mapping legacy terms to modern equivalents:

| Legacy Term | Natural/Adabas | Modern Equivalent | Definition |
|---|---|---|---|
| BENEFIC | DDM field | Beneficiary | Person receiving benefit |
| CPMF | Discount type | Social contribution deduction | Mandatory payroll tax |
| DESIF | Discount type | Judicial deduction | Court-ordered payment |
| PAGSTAT | Status code | PaymentStatus | Enum (PENDING, APPROVED, PAID, REJECTED) |

### Tool 3: Mysteries Checklist

List unknowns and questions:

- [ ] What happens if CPF validation fails? (silent reject or error?)
- [ ] Is there a way to cancel a payment after approval?
- [ ] How are judicial discounts marked differently in the code?
- [ ] What's the maximum number of beneficiaries the system can handle?
- [ ] Are there any scheduled batch jobs or cron tasks?

---

## ✅ Mysteries Checklist

Use this file to track open questions discovered during archaeology:

**Location**: `01-arqueologia/mysteries-checklist.md`

Format:

```markdown
# Open Mysteries - SIFAP Legacy

## Critical (blocks Stage 2)
- [ ] M-001: How are old payment records archived? (impacts data migration)
- [ ] M-002: What is the approval workflow for judicial discounts?

## Important (should clarify)
- [ ] M-003: Are there any compensating transactions for erroneous payments?
- [ ] M-004: How is the 13th-month bonus calculated differently than regular?

## Nice to know (can defer)
- [ ] M-005: Why was the 3270 interface chosen over X client?
- [ ] M-006: Have there been performance issues with large beneficiary counts?
```

---

## 📊 Output Artifacts

### Artifact 1: Business Rules Catalog

**File**: `01-arqueologia/business-rules-catalog.md`

```markdown
# Business Rules Catalog - SIFAP Legacy

## Beneficiary Rules

### BR-BEN-001: CPF Validation
**Source**: Program REGISTBN, lines 45-67
**Rule**: Beneficiary CPF must pass modulo-11 algorithm
**Impact**: If invalid, registration is rejected
**Test case**: CPF "123.456.789-10" should pass; "000.000.000-00" should fail

### BR-BEN-002: Unique CPF
**Source**: Program REGISTBN, Adabas unique index on BENEFIC.CPF
**Rule**: CPF must be unique across all active beneficiaries
**Impact**: Prevents duplicate registrations

## Payment Rules

### BR-PAY-001: Discount Ceiling
**Source**: Program CALCDSCT.NSN, lines 101-105
**Rule**: Total non-judicial discounts cannot exceed 30% of payment base
**Formula**: IF discount_total > base_amount * 0.30 THEN discount_total = base_amount * 0.30
**Exception**: Judicial discounts (type 'J') bypass this rule
**Test case**: Discount 35% -> truncated to 30%; Judicial 50% -> accepted

### BR-PAY-002: Minimum Payment
**Source**: Program CALCPAY.NSN, line 88
**Rule**: Net payment after discounts must be positive
**Impact**: If net <= 0, payment is rejected
```

### Artifact 2: Dependency Map

**File**: `01-arqueologia/dependency-map.md`

```markdown
# Program Dependency Map - SIFAP Legacy

## Call Graph

```
Entry Points:
├─ REGISTBN (Register Beneficiary)
│  ├─ VALIDATE-CPF
│  └─ UPDATE-BENEFIC (Adabas)
│
├─ CALCPAY (Calculate Payment)
│  ├─ GET-BENEFIC (Adabas)
│  ├─ CALCULATE-DISCOUNT
│  │  └─ GET-DISCOUNTS (Adabas)
│  ├─ VALIDATE-PAYMENT
│  └─ STORE-AUDIT (Adabas)
│
└─ GENRPT (Generate Reports)
   ├─ READ-AUDIT (Adabas)
   ├─ FORMAT-REPORT
   └─ EXPORT-PDF

## Data Flow

Beneficiary [REGISTBN] -> Adabas BENEFIC.DDM
Beneficiary + Cycle [CALCPAY] -> Adabas PAYMENT.DDM
Payment [GENRPT] -> PDF Report
```

### Artifact 3: Glossary

**File**: `01-arqueologia/glossary.md`

```markdown
# SIFAP Domain Glossary

## Entities

### Beneficiary
- **Definition**: Person receiving government benefit
- **Legacy DDM**: BENEFIC
- **Key fields**: ID (PIC 9(8)), CPF (PIC X(11)), Name (PIC X(100)), Status (X(20))
- **Modern equivalent**: `Beneficiary` JPA entity

### Payment
- **Definition**: Individual payment record to a beneficiary
- **Legacy DDM**: PAYMENT
- **Key fields**: ID (PIC 9(10)), BENEFIC_ID, Amount, Date, Status
- **Modern equivalent**: `Payment` JPA entity

## Terms

### CPMF (Contribuição Previdenciária sobre a Folha de Pagamentos)
- **English**: Social contribution deduction
- **Type**: Mandatory discount
- **Rate**: 7.5% - 8.0%
- **Modern mapping**: `DeductionType.SOCIAL_CONTRIBUTION`

### DESIF (Desconto Judicial)
- **English**: Judicial deduction / court-ordered garnishment
- **Type**: Discount with special handling
- **Rules**: Bypasses 30% discount ceiling; priority over other discounts
- **Modern mapping**: `DeductionType.JUDICIAL`

### Ciclo de Pagamento
- **English**: Payment cycle / payroll cycle
- **Definition**: Monthly period during which beneficiaries are paid
- **Modern equivalent**: `PaymentCycle` value object
```

### Artifact 4: Discovery Report

**File**: `01-arqueologia/discovery-report.md`

Comprehensive summary of all findings.

---

## ✅ Definition of Done

At the end of Stage 1, you must deliver:

- [ ] **Business Rules Catalog** (`01-arqueologia/business-rules-catalog.md`) with at least 10 business rules
  - Each rule includes: ID, source program/lines, rule description, impact, test cases
  
- [ ] **Dependency Map** (`01-arqueologia/dependency-map.md`) showing:
  - All major programs and their interactions
  - Data flows (program -> DDM -> program)
  - Entry points vs. utility programs

- [ ] **Glossary** (`01-arqueologia/glossary.md`) with:
  - All domain entities (Beneficiary, Payment, Discount, Audit)
  - All business terms in Portuguese with English translations
  - Mappings to modern equivalents

- [ ] **Mysteries Checklist** (`01-arqueologia/mysteries-checklist.md`) with:
  - Critical unknowns (blocks Stage 2)
  - Important questions (should clarify)
  - Nice-to-know (can defer)

- [ ] **Discovery Report** (`01-arqueologia/discovery-report.md`) summarizing:
  - Legacy system overview and history
  - Architecture and data flow
  - Key business logic and rules
  - Risks and recommendations for modernization

---

## 💡 Pro Tips

1. **Pair with a business analyst**: They know WHY rules exist, code only shows HOW
2. **Use GitHub Copilot Chat**: Paste Natural code and ask "Explain this business logic in plain English"
3. **Document everything**: Even "obvious" rules need to be written down
4. **Take screenshots**: Visual documentation of SIFAP menus or reports helps Stage 2
5. **Ask questions**: If you don't understand a rule, add it to Mysteries Checklist

---

## Navigation

| Home | Next |
|---|---|
| [Kit README](../README.md) | [Stage 2: Modern Spec](../02-spec-moderna/GUIDE.md) |

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Stage Home](README.md) | [Kit Home](../README.md) | [Glossary →](glossary.md) |
