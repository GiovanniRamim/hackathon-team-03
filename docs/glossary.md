---
title: "Domain Glossary — SIFAP 2.0"
description: "Authoritative team glossary. Populated during Stage 1 (Archaeology) by the Tech Writer + Requirements Engineer."
author: "Tech Writer (your team)"
date: "2026-04-29"
version: "0.1.0"
status: "draft"
tags: ["glossary", "domain", "sifap", "stage-1"]
---

# Domain Glossary

> Single source of truth for domain terms. Every new term goes here BEFORE it appears in code, specs, or tickets. The Tech Writer owns this file.

## How to add a term

1. Use this format:

   ```markdown
   ### Term
   - **Source:** Natural program or DDM where the term originates (e.g., `CADBENEF.NSN:42`)
   - **Definition:** Short definition (1–2 sentences)
   - **English equivalent:** If the legacy term is in Portuguese
   - **Used in:** REQ-IDs, files, modules
   ```

2. Keep terms in alphabetical order within each section.
3. If two team members disagree on a definition, log it as a decision and ping the Requirements Engineer.

---

## A

### Adabas
- **Source:** Legacy data store
- **Definition:** Multi-value NoSQL-style mainframe database used by the legacy SIFAP system. Adabas DDMs (Data Definition Modules) describe records.
- **Used in:** all `.NSN` programs in `legacy/natural-programs/`

## B

### Beneficiário (Beneficiary)
- **Source:** `BENEFICIARIO.ddm`
- **Definition:** A person who receives social benefit payments through SIFAP.
- **English equivalent:** Beneficiary
- **Used in:** REQ-BEN-*, `BeneficiaryEntity.java`

## C

### Ciclo (Cycle)
- **Source:** `BATCHPGT.NSN`
- **Definition:** A monthly payment generation run that produces payment records for all eligible beneficiaries.
- **English equivalent:** Payment cycle
- **Used in:** REQ-PAY-*, `PaymentCycleService.java`

### CPF
- **Source:** Brazilian Federal tax ID
- **Definition:** 11-digit national taxpayer ID used as the primary identifier for beneficiaries. Validated using the modulo-11 algorithm.
- **Used in:** all beneficiary identification logic

## D

### DDM (Data Definition Module)
- **Source:** Adabas
- **Definition:** A schema definition for an Adabas record. SIFAP uses 4 DDMs: Beneficiary, Payment, Social Program, Audit.
- **Used in:** archaeology + schema mapping

---

## How facilitators use this file

The facilitator (blue-cord) checks this glossary at every stage transition. A glossary with fewer than 30 terms by end of Stage 1 is a signal the team didn't dig deep enough.
