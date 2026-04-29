---
title: "Persona Card - Requirements Engineer"
description: "What the Requirements Engineer does inside the team of 10 during Day 2 of Hackathon DATACORP 2026."
author: "Paula Silva, Americas Software GBB, Microsoft"
date: "2026-04-18"
version: "1.0.0"
persona_id: "02"
tags: ["persona", "requirements-engineer", "hackathon", "DATACORP", "EARS"]
---

# Persona - Requirements Engineer

## Who this person is

The one who takes loose conversation and turns it into a testable requirement. Alongside the PO, the one who keeps the team from writing code for a poorly framed problem. In a legacy system like SIFAP, this role is critical: the rules are tacitly encoded in Natural and nobody articulates them anymore.

## Mission in the hackathon

Convert what was discovered in Stage 1 into formal, testable requirements in Stage 2. Make sure requirements are written in EARS, that they are numbered, and that each one has a verification criterion.

## Your role in the Agentic Legacy Modernization framework

This hackathon applies the **Agentic Legacy Modernization** framework — an approach to legacy system modernization using AI agents specialized in each phase. The full pipeline is described in the **Hackathon Blueprint** (provided separately by the facilitators). Your persona maps to the pipeline as follows:

- **Relevant agents**: Analysis Agent (S1-S2), Spec Engineer (S2)
- **Framework phase**: Application Carving → Translation
- **Your role in the pipeline**: Convert extracted rules into formal EARS requirements to guide the translation

## Where you show up by stage

| Stage | You do this | Deliverable that depends on you |
|---|---|---|
| 1. Archaeology | Extract candidate rules from the Naturals. Classify them: business rule, validation, calculation, integration. | Rule catalog (table) |
| 2. Greenfield Spec | Convert the catalog into EARS requirements. Maintain legacy → requirement traceability. Structure the spec with the PO. | "Functional Requirements" section in EARS notation |
| 3. Reconstruction | Answer requirement questions during coding. Adjust wording when real ambiguity emerges. | Living spec, not frozen |
| 4. Evolution with Agent | Review whether the two issues cover a new requirement or an adjustment to an existing one. | Coherence between issues and spec |

## Tools and primitives

- **Specky** - phase 2 (Requirements) is your territory. The plugin generates the EARS skeleton for you to refine.
- **Copilot Chat** to validate coherence between requirements. Typical prompt: "analyze whether these 5 requirements are mutually consistent."
- **MCP/filesystem** of the repository to navigate the legacy `.NSN` files and correlate with requirements.
- Templates from `25-personas-primitives` - skills for rule extraction and conversion to EARS.

## Cheat sheets you use

- `cheat-sheets/specky-workflow.md` - phase 2 with EARS examples.
- `cheat-sheets/model-routing.md` - to decide when to use Claude Sonnet 4.6 instead of Opus 4.6 (requirements call for both).

## How you do well

- Your requirements use active verbs and are testable.
- Every legacy rule has explicit traceability to the modern requirement.
- You say "this is ambiguous, we need a decision" before code is written.
- You use the five EARS patterns without confusion (ubiquitous, event-driven, state-driven, unwanted behavior, optional).

## How you get lost

- Write requirements as paragraphs instead of EARS.
- Duplicate in text what is already in an ADR.
- Leave legacy rules without a counterpart.
- Confuse requirement with design ("the system must use Redis" is not a requirement).

## If you took on two personas

- **RE + Product Owner** is the natural pair (PO says "why"; RE says "how to verify it was done").
- **RE + QA Engineer** also strong - you write the requirement and you are the one who tests it.

## 3 Example prompts

1. **(Chat)** "Read this rule from legacy SIFAP and convert it to EARS notation: [paste the rule]. Identify which of the 6 EARS patterns applies and explain why."
2. **(Chat)** "Analyze these 5 EARS requirements and find: (a) ambiguities that need a decision from the PO, (b) dependencies between them, (c) requirements that conflict."
3. **(Edits)** "In SPECIFICATION.md, add EARS requirements for the audit module based on rules BR-008 to BR-012 from the catalog. Use the Event and Unwanted Behavior patterns."

## If you get stuck (emergency defaults)

- **Don't know EARS?** Open `02-spec-moderna/GUIDE.md` section "EARS Notation" - 3 patterns with examples.
- **Ambiguous requirement?** Write two interpretations and ask the PO which is correct.
- **Many rules, little time?** Focus on CALCULATION and VALIDATION rules (those are the most critical for payment).
- **Specky not working?** Write EARS manually in SPECIFICATION.md - the format is plain text.

## Dependencies - Who depends on you

| Persona | Relationship | Artifact |
|---------|---------|----------|
| Product Owner | YOU depend on them | Rule prioritization |
| Developer | Depends on YOU | Clear requirements to implement |
| QA Engineer | Depends on YOU | Testable requirements with verification criteria |
| Software Architect | Depends on YOU | Requirements to design bounded contexts |

## How you are evaluated

- **Rubric A2 (Spec Coherence):** requirements in EARS, numbered, traceable to the legacy.
- **Rubric A1 (Archaeology):** rule catalog with classification.
- Criterion: "Every requirement has an active verb and is testable."

- Paula
