---
title: "payment-cycle-generation — Constitution"
feature_id: "001-payment-cycle-generation"
version: "1.0.0"
date: "2026-04-29"
author: "SDD Pipeline"
status: "Draft"
---
<!-- markdownlint-disable -->
# payment-cycle-generation — Constitution

> The foundational charter for the **payment-cycle-generation** project, establishing principles, constraints, and success criteria.

---

## Article 1: Project Identity

- **Name:** payment-cycle-generation
- **Description:** Foundational charter for payment-cycle-generation
- **Creator:** SDD Pipeline
- **License:** MIT

---

## Article 2: Principles


- Modernization from Natural/Adabas to Java 21 + Spring Boot 3.3 + PostgreSQL 16 + Next.js 15

- RESTful APIs follow /api/v1/{resource} convention

- Never expose sensitive data (CPF, benefit amounts) in logs

- Unit tests mandatory for business logic

- Use Java 21 features (records, sealed classes, pattern matching)

- Legacy behavior preservation — payment calculations must match SIFAP Natural/Adabas outputs


---

## Article 3: Constraints


- Target stack: Java 21, Spring Boot 3.3, JPA/Hibernate, PostgreSQL 16, Next.js 15 (App Router), TypeScript, Tailwind CSS, shadcn/ui

- Docker + Docker Compose for containerization

- Terraform for Azure IaC

- GitHub Actions for CI/CD

- Stage 1 archaeology docs available in 01-arqueologia/

- Legacy reference code in reference/sifap-legacy/

- Must produce bank-compatible payment batch output

- Monthly payment cycle for active beneficiaries with benefit rules and deductions


---

## Article 4: Success Criteria

| ID | Criterion | Measure |
|----|-----------|---------|
| SC-001 | Project compiles without errors | `npm run build` exits 0 |
| SC-002 | All requirements traceable | Every REQ has design + task mapping |
| SC-003 | Quality gates pass | Analysis gate returns APPROVE |

---

## Article 5: Scope

### In Scope
- Core project features

### Out of Scope
- Future enhancements not in initial scope

---

## Amendment Log

| # | Date | Author | Rationale | Articles Affected |
|---|------|--------|-----------|-------------------|
| — | — | — | Initial version | All |
