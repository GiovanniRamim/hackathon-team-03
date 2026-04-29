---
title: "Scope Decisions"
description: "What is in, what is out, and what is evolved for SIFAP 2.0 modernization"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
status: "approved"
tags: ["stage-2", "scope", "decisions", "migration"]
---

# 🎯 Scope Decisions — SIFAP 2.0 Modernization

> Defines the scope of SIFAP 2.0: features being migrated, discarded, and evolved.

---

## 📌 Overview

This document defines the scope of SIFAP 2.0 (modernized version). It specifies what features from legacy SIFAP are being migrated, what's being discarded, and what's being evolved with new capabilities.

**Principle**: If it's not listed here, it's out of scope.

---

## 📑 Table of Contents

1. [What's Being Migrated](#-whats-being-migrated-priority-order)
2. [What's Being Discarded](#-whats-being-discarded)
3. [What's Being Evolved](#-whats-being-evolved)
4. [Out of Scope for Modernization](#-out-of-scope-for-modernization)
5. [Phase Plan](#-phase-plan)
6. [Risk Mitigations](#-risk-mitigations)

---

## ✅ What's Being Migrated (Priority Order)

### Priority 1: Core Payment Processing (Critical Path)

#### Feature: Beneficiary Registration (REGISTBN)

**Scope**: 
- Register new beneficiary with CPF, name, contact info
- Validate CPF using modulo-11 algorithm
- Prevent duplicate registrations
- Set initial status = ACTIVE
- Create audit record

**Implementation**: Java service `BeneficiaryService.register()`

**Data source**: Legacy BENEFIC.DDM -> PostgreSQL `beneficiary` table

**Migration technique**: Direct migration script (Beneficiaries table is small, ~500K records)

**Acceptance criterion**: Every beneficiary record from legacy successfully migrated, audit trail preserved

---

#### Feature: Payment Calculation (CALCPAY)

**Scope**:
- Calculate payment for beneficiary in given cycle
- Apply all discount rules (CPMF, Income Tax, Judicial, etc.)
- Enforce 30% discount ceiling (non-judicial only)
- Generate payment record with APPROVED status
- Create audit entry

**Implementation**: Java service `PaymentService.calculatePayment()`

**Data source**: Legacy BENEFIC.DDM + PAYMENT.DDM + DISCOUNT.DDM -> PostgreSQL

**Migration technique**: Batch job at go-live to calculate outstanding payments

**Acceptance criterion**: Payment calculations match legacy system within 0.01% (rounding tolerance)

---

#### Feature: Audit Trail (AUDIT.DDM)

**Scope**:
- Immutable audit trail of all CREATE/UPDATE operations
- Store old values and new values for UPDATE
- Retention: 7 years minimum
- Compliance: Cannot be deleted (database trigger enforces)

**Implementation**: Spring Data JPA with database-level immutability

**Data source**: Legacy AUDIT.DDM -> PostgreSQL `audit_log` table (append-only)

**Migration technique**: Direct migration of all 7 years of audit history

**Acceptance criterion**: Every legacy audit record successfully migrated, no data loss

---

### Priority 2: Discount and Deduction Management

#### Feature: Configure Discounts (DISCOUNT.DDM)

**Scope**:
- Define discount types (CPMF, Income Tax, Judicial, Union Dues, Other)
- Set effective dates and amounts
- Apply per beneficiary
- Support dynamic changes (new judicial orders each month)

**Implementation**: 
- Backend: `DeductionService` with CRUD operations
- Frontend: Deduction management page
- Data: PostgreSQL `deduction` table

**Migration technique**: Direct migration of all deduction records

**Acceptance criterion**: All active deductions migrated; support for new deductions via UI

---

### Priority 3: Reporting

#### Feature: Payment Reports

**Scope**:
- Generate payment summary by cycle
- Export to PDF or CSV
- Include audit trail for compliance
- Support date range filtering

**Implementation**: 
- Backend: `ReportService` with PDF/CSV export
- Frontend: Report generation page
- Data: Query from PostgreSQL

**Acceptance criterion**: Reports match legacy system output; faster generation than legacy batch

---

### Priority 4: User Interface (Web)

#### Feature: Beneficiary Management Page

**Scope**:
- Register new beneficiary
- View beneficiary list with search/filter
- Update beneficiary info
- Suspend/cancel beneficiary
- View beneficiary audit trail

**Implementation**: Next.js frontend with TypeScript/React

**User experience improvements**:
- Mobile-responsive design
- Real-time search (vs. legacy batch search)
- Inline editing (vs. legacy multi-screen navigation)

**Acceptance criterion**: All beneficiary operations faster and more intuitive than 3270 terminal

---

#### Feature: Payment Management Page

**Scope**:
- View pending payments for beneficiary
- View paid payments history
- Manual payment adjustment/correction (NEW)
- Export payment data

**Acceptance criterion**: All payment operations accessible via web; faster than manual reports

---

### Priority 5: API Integration

#### Feature: REST API for Beneficiary and Payment Operations

**Scope**:
- GET /api/beneficiaries (list all, with filtering)
- GET /api/beneficiaries/{id} (fetch single)
- POST /api/beneficiaries (create)
- PUT /api/beneficiaries/{id} (update)
- POST /api/beneficiaries/{id}/suspend (state change)
- GET /api/payments (list, with filtering)
- GET /api/payments/{id}
- POST /api/payments/calculate (trigger calculation for beneficiary)
- GET /api/reports (list available reports)

**Implementation**: Spring Boot REST controllers with OpenAPI documentation

**Authentication**: OAuth2 with Entra ID (Microsoft identity platform)

**Acceptance criterion**: All APIs documented and tested; integration tests pass

---

## ❌ What's Being Discarded

### Feature: 3270 Terminal Interface

**Rationale**: Obsolete technology; web UI is more user-friendly and accessible

**Impact**: Operators must be trained on web interface

**Mitigation**: Provide training materials and side-by-side screenshots (3270 vs. web)

---

### Feature: Natural/Adabas Implementation

**Rationale**: End-of-life technology; expensive maintenance; Java/PostgreSQL is industry standard

**Impact**: 
- Legacy code will not be maintained
- Support for Natural/Adabas will be discontinued

**Timeline**: Parallel run (both systems active) for 1 month validation; then legacy deprecation

---

### Feature: Batch-Only Report Generation

**Rationale**: Modern system supports real-time dashboard; batch reports are slower

**Impact**: No more monthly manual report generation; reports available on-demand

**Benefit**: Reduced operational overhead

---

### Feature: Manual Payment Adjustments via CICS

**Rationale**: Legacy requires manual terminal commands; modern system has UI-based workflow

**Impact**: Operators adjust payments through web UI instead of command line

---

## 🔄 What's Being Evolved

### Feature: Payment Calculation - Enhanced Error Handling

**Current (Legacy)**: If validation fails, transaction is rejected silently; operator must check logs

**Evolved**: Error details are shown in UI; operator can correct and retry

**Implementation**: 
- Structured error responses with actionable messages
- Payment status = VALIDATION_ERROR (vs. just REJECTED)
- Retry mechanism in UI

**Benefit**: Faster error resolution, fewer payment processing delays

---

### Feature: Audit Trail - Real-Time Dashboard

**Current (Legacy)**: Audit log accessible only via batch report; generated monthly

**Evolved**: Real-time audit dashboard showing recent operations

**Implementation**: 
- PostgreSQL queries for recent audit entries
- Real-time API endpoint
- Web dashboard showing last 100 operations

**Benefit**: Faster compliance investigations, reduced audit time

---

### Feature: Discount Deductions - Self-Service Beneficiary Portal

**Current (Legacy)**: Only operators can view deductions; beneficiaries have no visibility

**Evolved**: Beneficiaries can log in and view their deductions and payments (privacy-respecting)

**Implementation**: 
- OAuth2 authentication with personal identity
- Filtered view (beneficiary sees only their data)
- PDF export of payment statement

**Benefit**: Self-service reduces support load

---

### Feature: Payment Cycle - Flexible Scheduling

**Current (Legacy)**: Nightly batch always runs at 02:00 AM; no flexibility

**Evolved**: Configurable payment cycle dates and batch frequency

**Implementation**: 
- Admin panel for cycle configuration
- Multiple payment cycles per year (if needed)
- Scheduled job with configurable trigger time

**Benefit**: Supports seasonal payment adjustments or emergency payments

---

### Feature: Security - OAuth2 / Entra ID Integration

**Current (Legacy)**: Basic username/password in mainframe security database

**Evolved**: Enterprise single sign-on (SSO) with Microsoft Entra ID

**Implementation**: 
- OAuth2 client configuration in Spring Security
- Entra ID application registration in Azure
- Role-based access control (RBAC) via Entra ID groups

**Benefit**: 
- Centralized identity management
- MFA support
- Audit trail of authentication events

---

### Feature: Monitoring and Observability

**Current (Legacy)**: Limited logging; errors are hard to diagnose

**Evolved**: Comprehensive application monitoring with Application Insights

**Implementation**: 
- Application Insights SDK integration
- Distributed tracing for payment calculations
- Real-time alerts for errors and performance issues

**Benefit**: Faster mean time to resolution (MTTR) for issues

---

## 🚫 Out of Scope for Modernization

### Feature: Integration with External CPF Validation Service

**Reason**: Legacy system uses only local modulo-11 validation; no external API calls

**Decision**: Modern system will also use local validation for compatibility

**Future**: Can be added in Evolution phase if required

---

### Feature: Mobile App

**Reason**: Out of scope for SIFAP 2.0 initial release

**Decision**: Web app is responsive and mobile-friendly

**Future**: Native mobile app (iOS/Android) can be built from REST APIs in Phase 2

---

### Feature: Machine Learning for Fraud Detection

**Reason**: Legacy system has no fraud detection; not required for modernization

**Decision**: Manual audit controls only (for now)

**Future**: Can be added as enhancement if fraud patterns emerge

---

### Feature: Multi-Currency Support

**Reason**: Legacy system handles only Brazilian Real; SIFAP is domestic only

**Decision**: No multi-currency support

---

### Feature: Blockchain or Distributed Ledger Integration

**Reason**: Not required for compliance; would add complexity without benefit

**Decision**: Centralized PostgreSQL database with audit trail is sufficient

---

## 📅 Phase Plan

### Phase 1: Foundation (Weeks 1-2)

**What**: Core backend services + basic UI + audit trail

**Includes**:
- Java backend (BeneficiaryService, PaymentService)
- PostgreSQL with audit logging
- Basic web UI (beneficiary registration, payment view)
- API endpoints
- Authentication (Entra ID)

**Go/No-Go gate**: 
- All Phase 1 requirements tested
- Performance acceptable (< 500ms response time)
- Zero data loss in test migration

---

### Phase 2: Dashboard and Reporting (Weeks 3-4)

**What**: Enhanced UI + reporting + real-time audit dashboard

**Includes**:
- Payment management UI (view, adjust, export)
- Report generation (PDF/CSV)
- Real-time audit dashboard
- Error handling improvements

**Go/No-Go gate**:
- All reports match legacy system output
- Dashboard performance acceptable
- User acceptance testing complete

---

### Phase 3: Migration and Cutover (Week 5)

**What**: Data migration + parallel run validation + cutover

**Includes**:
- Full data migration (beneficiaries, payments, audit trail, deductions)
- Parallel run validation (legacy vs. modern side-by-side)
- Reconciliation reports
- Operator training

**Go/No-Go gate**:
- Payment calculations match within 0.01%
- All audit records migrated
- Operator sign-off on training

---

### Phase 4: Evolution (Weeks 6+)

**What**: Enhanced features and optimizations

**Includes**:
- Self-service beneficiary portal
- Real-time dashboard improvements
- Performance optimization
- Bug fixes based on feedback

---

## ⚠️ Risk Mitigations

### Risk 1: Data Loss During Migration

**Severity**: HIGH

**Mitigation**:
- Full backup of legacy system before migration starts
- Parallel run for 1 month with reconciliation
- Reconciliation report comparing payment totals

---

### Risk 2: Business Rule Loss

**Severity**: HIGH

**Mitigation**:
- All 13+ business rules documented and traced to code
- Test cases for every business rule
- Manual testing by business users before cutover

---

### Risk 3: Performance Degradation

**Severity**: MEDIUM

**Mitigation**:
- Load testing with 10,000+ payment records
- Database query optimization before go-live
- PostgreSQL monitoring and alerting

---

### Risk 4: Operator Training

**Severity**: MEDIUM

**Mitigation**:
- Training materials with side-by-side screenshots
- Practice environment for hands-on training
- 24/7 support during cutover week

---

## ✍️ Sign-Off

| Role | Name | Date | Approval |
|------|------|------|----------|
| Product Owner | [Name] | 28/04/2026 | [ ] |
| Tech Lead | [Name] | 28/04/2026 | [ ] |
| Architect | [Name] | 28/04/2026 | [ ] |
| Operations | [Name] | 28/04/2026 | [ ] |

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← ADR Template](ADR-TEMPLATE.md) | [Kit Home](../README.md) | [Stage 3 Home →](../03-implementacao/README.md) |
