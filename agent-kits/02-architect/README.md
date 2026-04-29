---
title: "Architect Agent Kit"
description: "Stage 2 agent for modern specification — bounded contexts, EARS requirements, ADRs, Modular Monolith design"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-29"
version: "1.0.0"
status: "approved"
tags: ["agent", "architect", "specification", "ears", "adr", "stage-2"]
---

# @architect-agent — Stage 2: Modern Spec

> An architect does not start with blueprints — they start with the land survey. Your Stage 1 discoveries are the survey. Now you draw the blueprints: bounded contexts, EARS requirements, and a Modular Monolith that turns legacy spaghetti into clean geometry.

## What This Agent Does

- **Carves bounded contexts** — guides the team to identify domain boundaries from the legacy data map, grouping related entities and operations
- **Writes EARS requirements** — helps draft requirements in EARS notation (Ubiquitous, Event-driven, State-driven, Optional, Unwanted, Complex), each with a `REQ-NNN` ID and acceptance criteria
- **Generates ADRs** — facilitates Architecture Decision Records for key choices: database mapping strategy, module boundaries, authentication, error handling
- **Designs the Modular Monolith** — produces C4 diagrams (System Context, Containers, Components) and validates that the design maps to a single deployable unit
- **Plans Strangler Fig coexistence** — when needed, outlines how modern and legacy systems can coexist during migration

## Who Uses This Agent

| Persona | Role in This Stage |
|---------|-------------------|
| **Software Architect** | **PROTAGONIST** — drives bounded context design, C4 diagrams, and module structure |
| Requirements Engineer | Secondary — writes EARS requirements, ensures traceability to Stage 1 discoveries |
| Enterprise Architect | Secondary — validates system context, integration patterns, and security architecture |
| Product Owner | Secondary — prioritizes requirements, validates scope decisions |
| Technical Lead | Observer — begins planning implementation approach for Stage 3 |
| All others | Observer — follow along, contribute domain knowledge when asked |

## When to Invoke

- **Stage**: 2 — Modern Spec
- **Time window**: Minutes 90-135 of the hackathon (after Stage 1 ends)
- **Prerequisite**: Stage 1 deliverables (glossary, program catalog, data map, call graph, mystery log, business rules draft)

## How to Activate

1. Open the VS Code Chat panel
2. Select the **architect** chatmode
3. Paste your opening prompt:
   ```
   I'm starting Stage 2 — Modern Spec. Here are our Stage 1 deliverables:
   [paste or reference your glossary, data map, and business rules].
   Help me identify bounded contexts and start writing EARS requirements.
   ```
4. Work through bounded contexts, then requirements, then ADRs

## Definition of Done

Your team exits Stage 2 when you have:

- [ ] **SPECIFICATION.md** with at least 10 EARS requirements, each with `REQ-NNN` IDs and acceptance criteria
- [ ] A **bounded context map** (Mermaid diagram) showing 2-4 contexts with relationships
- [ ] **C4 diagrams** at Level 1 (System Context) and Level 2 (Containers) minimum
- [ ] At least **3 ADRs** documenting key architectural decisions
- [ ] A **data model draft** showing how legacy structures map to JPA entities
- [ ] An **API contract outline** with at least 3 REST endpoints defined

## Anti-Patterns We Refuse

| Anti-pattern | What happens instead |
|---|---|
| "Give me the bounded contexts" | The agent asks: "Show me your data map. Which entities change together?" |
| Requirements without `REQ-NNN` IDs | The agent assigns an ID and validates the EARS pattern |
| Microservices proposals | The agent redirects to Modular Monolith and explains why |
| Skipping EARS validation | Every requirement is checked against the 6 EARS patterns |
| Fabricating metrics or benchmarks | The agent states assumptions explicitly or marks `<!-- TODO: confirm -->` |

## Chatmode File

[`.github/chatmodes/architect.chatmode.md`](../../.github/chatmodes/architect.chatmode.md)

---

| Previous | Home | Next |
|----------|------|------|
| [Archaeologist Agent](../01-archaeologist/README.md) | [Team Kit Home](../../README.md) | [Builder Agent](../03-builder/README.md) |
