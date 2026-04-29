---
title: "SIFAP Domain Glossary"
description: "Portuguese-to-English domain terms and entity mappings for SIFAP legacy system"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
status: "approved"
tags: ["stage-1", "glossary", "domain", "legacy", "terminology"]
---

# 📖 SIFAP Domain Glossary

> Comprehensive glossary mapping legacy SIFAP domain terms to modern equivalents.

---

## 📑 Table of Contents

1. [📦 Entities](#entities)
2. [💰 Benefit Types](#benefit-types)
3. [🏷️ Discount Types (Desconto Types)](#discount-types-desconto-types)
4. [🔄 Status Codes](#status-codes)
5. [⏰ Cycles and Time Concepts](#cycles-and-time-concepts)
6. [⚙️ Operational Terms](#operational-terms)
7. [✅ Validation Concepts](#validation-concepts)
8. [🗄️ Archival and Retention](#archival-and-retention)
9. [📊 Summary Table: Portuguese to English Mapping](#summary-table-portuguese-to-english-mapping)

---

---

## 📦 Entities

### Beneficiary (Beneficiário)

**Definition**: A person eligible to receive government benefit payments under SIFAP.

**Legacy DDM**: BENEFIC.DDM

**Key fields**:
- ID (PIC 9(8)): Unique identifier
- CPF (PIC X(11)): Tax registration number (Cadastro de Pessoa Física)
- Name (PIC X(100)): Full legal name
- Status (PIC X(20)): ACTIVE | SUSPENDED | CANCELLED
- BenefitType (PIC X(3)): R | E | S (Regular, Extended, Special)

**Modern equivalent**: `Beneficiary` (JPA entity)

**Usage**: Core entity; every payment relates to one beneficiary.

---

### Payment (Pagamento)

**Definition**: Individual payment transaction issued to a beneficiary in a given cycle.

**Legacy DDM**: PAYMENT.DDM

**Key fields**:
- ID (PIC 9(10)): Unique payment ID
- BeneficiaryID (PIC 9(8)): Foreign key to BENEFIC
- CycleDate (PIC X(7)): Payment cycle (YYYY-MM format)
- BaseAmount (DEC(13,2)): Gross benefit amount before discounts
- DiscountTotal (DEC(13,2)): Sum of all discounts applied
- NetAmount (DEC(13,2)): Final amount = BaseAmount - DiscountTotal
- Status (PIC X(20)): APPROVED | PAID | REJECTED | CANCELLED

**Modern equivalent**: `Payment` (JPA entity)

**Usage**: Created monthly for each ACTIVE beneficiary during payment cycle.

---

### Discount (Desconto)

**Definition**: Deduction applied to a beneficiary's payment (tax, social contributions, court order, etc.)

**Legacy DDM**: DISCOUNT.DDM

**Key fields**:
- ID (PIC 9(10)): Unique discount ID
- BeneficiaryID (PIC 9(8)): Foreign key to BENEFIC
- Type (PIC X(3)): J | C | I | [others] (see discount types below)
- Amount (DEC(13,2)): Discount value
- EffectiveFrom (PIC X(10)): Start date (YYYY-MM-DD)
- EffectiveTo (PIC X(10)): End date (YYYY-MM-DD)

**Modern equivalent**: `Deduction` (JPA entity)

**Usage**: Dynamically applied during payment calculation; can change month-to-month.

---

### Audit (Auditoria)

**Definition**: Immutable record of every change to SIFAP data (create, update, delete attempts).

**Legacy DDM**: AUDIT.DDM

**Key fields**:
- ID (PIC 9(12)): Auto-incrementing audit ID
- EntityType (PIC X(20)): BENEFICIARY | PAYMENT | DISCOUNT
- EntityID (PIC 9(10)): ID of entity being modified
- Operation (PIC X(10)): CREATE | UPDATE | DELETE
- OldValue (PIC X(4000)): Previous value (for UPDATE)
- NewValue (PIC X(4000)): New value (for UPDATE)
- Timestamp (PIC X(26)): UTC ISO 8601 timestamp
- UserID (PIC X(20)): Employee ID who performed operation

**Modern equivalent**: `AuditLog` (JPA entity with immutable persistence)

**Usage**: Permanent record; cannot be deleted; required for compliance.

---

## 💰 Benefit Types

### Type: R (Regular Benefit / Benefício Regular)

**Code**: R
**Multiplier**: 1.0x (no multiplier)
**Base calculation**: Flat amount or formula defined per program
**Usage**: Most common; standard government benefit

**Modern mapping**: `BenefitType.REGULAR`

---

### Type: E (Extended Benefit / Benefício Estendido)

**Code**: E
**Multiplier**: 1.5x (50% bonus)
**Base calculation**: Regular amount × 1.5
**Usage**: Beneficiaries with extended eligibility (age, family size, etc.)
**Example**: Regular benefit 1000 -> Extended benefit 1500

**Modern mapping**: `BenefitType.EXTENDED`

---

### Type: S (Special Circumstance / Situação Especial)

**Code**: S
**Multiplier**: 2.0x (double)
**Base calculation**: Regular amount × 2.0
**Usage**: Rare; special government programs (disaster relief, etc.)
**Example**: Regular benefit 1000 -> Special benefit 2000

**Modern mapping**: `BenefitType.SPECIAL`

---

## 🏷️ Discount Types (Desconto Types)

### Type: C (CPMF / Contribuição Previdenciária)

**Full name (Portuguese)**: Contribuição Previdenciária sobre a Folha de Pagamentos

**English**: Social Contribution Deduction / Social Security Contribution

**Description**: Mandatory deduction for social security/pension contributions.

**Rate**: 7.5% to 8.0% (varies by program)

**Ceiling**: Subject to 30% ceiling rule

**Modern mapping**: `DeductionType.SOCIAL_CONTRIBUTION`

**Example**: Payment 1000 + CPMF 80 (8%) = Discount 80

---

### Type: I (IRPF / Income Tax)

**Full name (Portuguese)**: Imposto de Renda da Pessoa Física

**English**: Personal Income Tax Withholding

**Description**: Tax withholding calculated based on tax brackets.

**Rate**: Progressive (0% to 27.5% depending on income)

**Ceiling**: Subject to 30% ceiling rule

**Modern mapping**: `DeductionType.INCOME_TAX`

**Example**: Payment 2000 + IRPF 300 (15% effective rate) = Discount 300

---

### Type: J (DESIF / Judicial Deduction)

**Full name (Portuguese)**: Desconto Judicial / Desconto Judicial

**English**: Judicial Deduction / Court-Ordered Garnishment

**Description**: Court-ordered payment deduction (alimony, debt collection, etc.).

**Rate**: Varies; set by court order

**Ceiling**: None - bypasses 30% ceiling (see BR-PAY-002)

**Priority**: Often has priority over other discounts

**Modern mapping**: `DeductionType.JUDICIAL`

**Example**: Payment 1000 + Judicial discount 600 = Total discount 600 (no ceiling applied)

---

### Type: S (Sindical / Union Dues)

**Full name (Portuguese)**: Desconto Sindical

**English**: Union Dues / Labor Union Membership Fee

**Description**: Voluntary deduction for union membership (where applicable).

**Rate**: Fixed percentage or amount per union

**Ceiling**: Subject to 30% ceiling rule

**Modern mapping**: `DeductionType.UNION_DUES`

---

### Type: O (Other / Outros)

**English**: Other Deductions

**Description**: Miscellaneous deductions not categorized above.

**Rate**: Variable

**Ceiling**: Subject to 30% ceiling rule

**Modern mapping**: `DeductionType.OTHER`

---

## 🔄 Status Codes

### Beneficiary Status

| Code | Portuguese | English | Can receive payments? | Can register discounts? | Transitions |
|------|---|---|---|---|---|
| ACTIVE | Ativo | Active | Yes | Yes | SUSPENDED, CANCELLED |
| SUSPENDED | Suspenso | Suspended | No | No | ACTIVE, CANCELLED |
| CANCELLED | Cancelado | Cancelled | No | No | (No transitions - terminal state) |

---

### Payment Status

| Code | Portuguese | English | Meaning |
|------|---|---|---|
| APPROVED | Aprovado | Approved | Calculation complete, awaiting dispatch |
| PAID | Pago | Paid | Successfully sent to beneficiary |
| REJECTED | Rejeitado | Rejected | Failed validation; not processed |
| CANCELLED | Cancelado | Cancelled | Previously approved payment was reversed |

---

## ⏰ Cycles and Time Concepts

### Ciclo de Pagamento (Payment Cycle)

**Definition**: Monthly period during which beneficiary payments are calculated and processed.

**Format**: YYYY-MM (e.g., 2026-04 for April 2026)

**Schedule**: 1st of each month (trigger) through end of month (completion)

**Modern mapping**: `PaymentCycle` (value object or entity)

**Example**: Cycle 2026-04 includes all April payments.

---

### 13º Salário (13th Month Bonus / Year-End Bonus)

**Definition**: Additional payment issued in December equal to one month's average benefit.

**Trigger**: December payment cycle only

**Calculation**: Average of last 12 months × 1.0

**Formula**: 
```
IF month(cycle_date) = 12:
  bonus = sum(last_12_months_payments) / 12
  total_payment = regular_payment + bonus
END
```

**Modern mapping**: `calculateYearEndBonus()` method in PaymentService

**Example**: December cycle with regular payment 2000 and 12-month average 2000 = Total 4000 (regular + bonus)

---

## ⚙️ Operational Terms

### Operador (Operator / Operador de Pagamento)

**Definition**: SIFAP user who registers beneficiaries and processes payments.

**Permissions**: Read/Write on beneficiaries and payments; cannot delete; can view audit logs.

**Modern role**: Operator (Spring Security role)

---

### Auditor

**Definition**: User who monitors SIFAP operations and generates compliance reports.

**Permissions**: Read-only on all data; can generate audit and payment reports.

**Modern role**: Auditor (Spring Security role)

---

### Gestor Administrativo (Administrator)

**Definition**: System administrator responsible for configuration, user management, system updates.

**Permissions**: Full system access; can configure discounts, holidays, payment dates.

**Modern role**: Admin (Spring Security role)

---

## ✅ Validation Concepts

### Validação de CPF (CPF Validation)

**Definition**: Verification that CPF (Cadastro de Pessoa Física - Brazilian tax ID) is valid using modulo-11 checksum algorithm.

**Algorithm**: 
1. Multiply first 9 digits by weights 10-2
2. Calculate modulo 11; subtract from 11 (if result >= 10, use 0)
3. First check digit determined; repeat for second check digit with weights 11-2
4. Compare calculated check digits to provided check digits

**Invalid CPFs**: 000.000.000-00, 111.111.111-11, etc. (all same digit)

**Modern mapping**: `CpfValidator.validate(String cpf)` service

---

### Ciclo Ativo (Active Cycle)

**Definition**: Current month's payment processing cycle that is actively being used.

**Status**: Only one active cycle at a time.

**Modern mapping**: Configuration property or entity flag

---

## 🗄️ Archival and Retention

### Arquivamento de Dados (Data Archival)

**Retention requirement**: Payment records > 7 years old are archived to separate storage.

**Compliance**: Required by government audit requirements.

**Modern approach**: PostgreSQL archive tables or S3-based cold storage

---

## 📊 Summary Table: Portuguese to English Mapping

| Portuguese | English | Category | Modern Equivalent |
|---|---|---|---|
| Beneficiário | Beneficiary | Entity | `Beneficiary` |
| Pagamento | Payment | Entity | `Payment` |
| Desconto | Discount/Deduction | Entity | `Deduction` |
| Auditoria | Audit | Entity | `AuditLog` |
| CPF | CPF / Tax ID | Identifier | `String cpf` |
| Ciclo de Pagamento | Payment Cycle | Concept | `PaymentCycle` |
| 13º Salário | 13th Month Bonus | Concept | `calculateYearEndBonus()` |
| CPMF | Social Contribution | Discount type | `DeductionType.SOCIAL_CONTRIBUTION` |
| DESIF | Judicial Deduction | Discount type | `DeductionType.JUDICIAL` |
| Ativo | Active | Status | `BeneficiaryStatus.ACTIVE` |
| Suspenso | Suspended | Status | `BeneficiaryStatus.SUSPENDED` |
| Cancelado | Cancelled | Status | `BeneficiaryStatus.CANCELLED` |
| Operador | Operator | Role | `ROLE_OPERATOR` |
| Auditor | Auditor | Role | `ROLE_AUDITOR` |
| Gestor | Administrator | Role | `ROLE_ADMIN` |

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Stage Guide](GUIDE.md) | [Kit Home](../README.md) | [Business Rules →](business-rules-catalog.md) |
