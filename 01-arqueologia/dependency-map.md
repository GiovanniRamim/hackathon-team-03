---
title: "Program Dependency Map"
description: "Call graph and data flow for SIFAP legacy Natural programs"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
status: "approved"
tags: ["stage-1", "dependencies", "call-graph", "data-flow"]
---

# 🗺️ Program Dependency Map — SIFAP Legacy

> Visual and textual mapping of program dependencies, call hierarchies, and data flows in legacy SIFAP.

---

## 📑 Table of Contents

1. [📊 Program Call Hierarchy](#program-call-hierarchy)
2. [🔄 Data Flow Diagram](#data-flow-diagram)
3. [📦 Data Entities and DDMs](#data-entities-and-ddms)
4. [📋 Program Matrix: Dependencies](#program-matrix-dependencies)
5. [🔗 External System Integrations](#external-system-integrations)
6. [⏱️ Call Frequency and Performance Notes](#call-frequency-and-performance-notes)
7. [🛤️ Critical Paths for Modernization](#critical-paths-for-modernization)

---

---

## 📊 Program Call Hierarchy

### Entry Point Programs (User-Facing)

```
┌─ REGISTBN (Register Beneficiary)
│  ├─ VALIDATE-CPF (utility)
│  ├─ CHECK-DUPLICATE (utility)
│  └─ UPDATE-BENEFIC (Adabas persist)
│
├─ CALCPAY (Calculate Payment)
│  ├─ GET-BENEFIC (Adabas read)
│  ├─ CALCULATE-DISCOUNT (utility)
│  │  └─ GET-DISCOUNTS (Adabas read)
│  ├─ VALIDATE-PAYMENT (utility)
│  ├─ STORE-AUDIT (Adabas write)
│  └─ PERSIST-PAYMENT (Adabas write)
│
└─ GENRPT (Generate Reports)
   ├─ READ-AUDIT (Adabas read)
   ├─ READ-PAYMENTS (Adabas read)
   ├─ FORMAT-REPORT (utility)
   └─ EXPORT-PDF (utility)
```

### Batch Job Entry Points

```
┌─ NIGHTLY-BATCH (Scheduled)
│  ├─ PROCESS-CYCLE (utility)
│  │  └─ CALCPAY (calls main calculation)
│  └─ SEND-NOTIFICATIONS (utility)
│
└─ MONTHLY-CLOSING (Month-end)
   └─ GENERATE-JOURNAL (accounting integration)
```

---

## 🔄 Data Flow Diagram

### Beneficiary Registration Flow

```
USER INPUT
   |
   v
REGISTBN
   |
   +---> VALIDATE-CPF -----> [CPF valid?] --NO--> REJECT
   |                              |
   |                            YES
   +---> CHECK-DUPLICATE -----> [CPF exists?] --YES--> REJECT
   |                              |
   |                             NO
   +---> UPDATE-BENEFIC
         |
         v
      Adabas DDM: BENEFIC
         |
         v
      [Status = ACTIVE]
         |
         v
      ACCEPT
         |
         v
      USER OUTPUT
```

### Payment Calculation Flow

```
ENTRY: CALCPAY (Beneficiary ID, Cycle)
   |
   v
GET-BENEFIC from Adabas BENEFIC.DDM
   |
   v
   +---> [Status = ACTIVE?] --NO--> REJECT
   |           |
   |         YES
   +---> CALCULATE-DISCOUNT
         |
         +---> GET-DISCOUNTS from Adabas DISCOUNT.DDM
         |
         v
         [Apply 30% ceiling for non-judicial]
         [Judicial discounts bypass ceiling]
         |
         v
      RETURN total_discount
         |
         v
   +---> VALIDATE-PAYMENT
   |     |
   |     v
   |     [Net amount > 0?] --NO--> REJECT
   |     [Payment date in cycle?] --NO--> REJECT
   |     [All business rules pass?] --NO--> REJECT
   |
   +---> PERSIST-PAYMENT to Adabas PAYMENT.DDM
   |     |
   |     v
   |     [Create record with Status = APPROVED]
   |
   +---> STORE-AUDIT to Adabas AUDIT.DDM
         |
         v
         [Record: operation=CREATE, entity=PAYMENT, timestamp=UTC]
         |
         v
      ACCEPT
         |
         v
      RETURN payment_id
```

### Report Generation Flow

```
ENTRY: GENRPT (Report Type, Date Range)
   |
   v
   +---> READ-AUDIT from Adabas AUDIT.DDM
   |     [Filter by date range]
   |
   +---> READ-PAYMENTS from Adabas PAYMENT.DDM
   |     [Join with BENEFIC]
   |
   v
FORMAT-REPORT
   |
   v
   +---> Aggregate and calculate totals
   |
   +---> Sort by date, beneficiary
   |
   v
EXPORT-PDF
   |
   v
[PDF file]
   |
   v
USER DOWNLOAD
```

---

## 📦 Data Entities and DDMs

### DDM: BENEFIC (Beneficiary Master)

```
BENEFIC (Adabas DDM)
├─ ID (PIC 9(8), key)
├─ CPF (PIC X(11), unique index)
├─ Name (PIC X(100))
├─ Status (PIC X(20), indexed)
│  └─ Values: ACTIVE, SUSPENDED, CANCELLED
├─ Email (PIC X(100))
├─ Phone (PIC X(20))
├─ BenefitType (PIC X(3))
│  └─ Values: R (Regular), E (Extended), S (Special)
├─ CreatedAt (PIC X(19), formatted YYYY-MM-DD HH:MM:SS)
├─ ModifiedAt (PIC X(19), formatted YYYY-MM-DD HH:MM:SS)
└─ ModifiedBy (PIC X(20), user ID)
```

### DDM: PAYMENT

```
PAYMENT (Adabas DDM)
├─ ID (PIC 9(10), key)
├─ BeneficID (PIC 9(8), foreign key to BENEFIC)
├─ CycleDate (PIC X(7), YYYY-MM format)
├─ BaseAmount (DEC(13,2))
├─ DiscountTotal (DEC(13,2))
├─ NetAmount (DEC(13,2))
├─ Status (PIC X(20), indexed)
│  └─ Values: APPROVED, PAID, REJECTED, CANCELLED
├─ PaymentDate (PIC X(10), YYYY-MM-DD)
├─ CreatedAt (PIC X(19), UTC)
├─ CreatedBy (PIC X(20), user ID)
└─ ModifiedAt (PIC X(19), UTC)
```

### DDM: DISCOUNT

```
DISCOUNT (Adabas DDM)
├─ ID (PIC 9(10), key)
├─ BeneficID (PIC 9(8), foreign key to BENEFIC)
├─ Type (PIC X(3), indexed)
│  └─ Values: J (Judicial), C (CPMF), I (Income Tax), etc.
├─ Amount (DEC(13,2))
├─ EffectiveFrom (PIC X(10), YYYY-MM-DD)
├─ EffectiveTo (PIC X(10), YYYY-MM-DD)
├─ Reason (PIC X(500))
├─ CreatedAt (PIC X(19), UTC)
└─ CreatedBy (PIC X(20))
```

### DDM: AUDIT

```
AUDIT (Adabas DDM)
├─ ID (PIC 9(12), auto-increment)
├─ EntityType (PIC X(20))
│  └─ Values: BENEFICIARY, PAYMENT, DISCOUNT
├─ EntityID (PIC 9(10))
├─ Operation (PIC X(10))
│  └─ Values: CREATE, UPDATE, DELETE
├─ OldValue (PIC X(4000))
├─ NewValue (PIC X(4000))
├─ Timestamp (PIC X(26), UTC ISO 8601)
├─ UserID (PIC X(20))
├─ SourceProgram (PIC X(20))
└─ IPAddress (PIC X(15))
```

---

## 📋 Program Matrix: Dependencies

| Program | Calls | Called By | Purpose |
|---------|-------|-----------|---------|
| REGISTBN | VALIDATE-CPF, CHECK-DUPLICATE, UPDATE-BENEFIC | User | Register new beneficiary |
| VALIDATE-CPF | (none) | REGISTBN | Validate CPF with modulo-11 |
| CHECK-DUPLICATE | (none) | REGISTBN | Check if CPF already exists |
| CALCPAY | GET-BENEFIC, CALCULATE-DISCOUNT, VALIDATE-PAYMENT, PERSIST-PAYMENT, STORE-AUDIT | NIGHTLY-BATCH | Calculate payment amount |
| CALCULATE-DISCOUNT | GET-DISCOUNTS | CALCPAY | Sum and apply discount rules |
| VALIDATE-PAYMENT | (none) | CALCPAY | Validate business rules |
| GENRPT | READ-AUDIT, READ-PAYMENTS, FORMAT-REPORT, EXPORT-PDF | User | Generate report PDF |
| NIGHTLY-BATCH | PROCESS-CYCLE, SEND-NOTIFICATIONS | Scheduler | Nightly job (triggers CALCPAY for each beneficiary) |
| PROCESS-CYCLE | CALCPAY | NIGHTLY-BATCH | Process payment cycle |

---

## 🔗 External System Integrations

```
SIFAP
├─ Adabas (Database)
│  ├─ BENEFIC.DDM
│  ├─ PAYMENT.DDM
│  ├─ DISCOUNT.DDM
│  └─ AUDIT.DDM
│
├─ Central Government Systems
│  ├─ CPF Validation Service (external API, if available)
│  └─ Judicial System (receives garnishment notifications)
│
└─ PDF Export Library
   └─ PDF generation utility
```

---

## ⏱️ Call Frequency and Performance Notes

| Program | Daily Calls | Peak Time | Avg Duration |
|---------|-------------|-----------|--------------|
| REGISTBN | < 50 | Morning | < 1 sec |
| CALCPAY | 10,000+ | Night (nightly batch) | 50 msec (per record) |
| GENRPT | 10-20 | End of month | 2-5 minutes (full report) |
| NIGHTLY-BATCH | 1 | 02:00 AM | 30-45 minutes (entire cycle) |

---

## 🛤️ Critical Paths for Modernization

### Path 1: Beneficiary Management
REGISTBN -> VALIDATE-CPF -> UPDATE-BENEFIC

**Modern equivalent**: BeneficiaryController.register() -> BeneficiaryService.register() -> BeneficiaryRepository.save()

### Path 2: Payment Calculation
NIGHTLY-BATCH -> CALCPAY -> CALCULATE-DISCOUNT -> PERSIST-PAYMENT -> STORE-AUDIT

**Modern equivalent**: PaymentProcessingScheduler -> PaymentService.calculateForCycle() -> DiscountService.calculateTotal() -> PaymentRepository.save() + AuditService.record()

### Path 3: Reporting
GENRPT -> READ-AUDIT/READ-PAYMENTS -> FORMAT-REPORT -> EXPORT-PDF

**Modern equivalent**: ReportController.generate() -> AuditRepository.findByDateRange() -> ReportService.generate() -> PdfExporter.export()

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Business Rules](business-rules-catalog.md) | [Kit Home](../README.md) | [Discovery Report →](discovery-report.md) |
