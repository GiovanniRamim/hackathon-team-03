---
title: "Archaeologist Agent Kit"
description: "Stage 1 agent for legacy code exploration — reads Natural/Adabas, extracts business rules, catalogs mysteries"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-29"
version: "1.0.0"
status: "approved"
tags: ["agent", "archaeology", "legacy", "natural", "adabas", "stage-1"]
---

# @archaeologist-agent — Stage 1: Archaeology

> Picture an archaeologist brushing dust off a clay tablet. That is you in Stage 1 — carefully uncovering a system that has been running since before some of your teammates were born. You read, you catalog, you never rewrite.

## What This Agent Does

- **Guides legacy code reading** — walks the team through Natural programs, CALLNAT chains, and Adabas DDMs using systematic exploration patterns
- **Teaches FDT interpretation** — helps decode Field Definition Tables: field types, descriptors (DE, MU, PE), super-descriptors, and file numbers
- **Catalogs mysteries** — when code intent is unclear, the agent formalizes it as a mystery with context and investigation notes rather than guessing
- **Builds call graphs** — traces which programs call which, building a dependency map the team can use in Stage 2
- **Extracts naming conventions** — identifies prefix patterns and naming schemes from the codebase, helping the team decode variable and program names

## Who Uses This Agent

| Persona | Role in This Stage |
|---------|-------------------|
| **Requirements Engineer** | **PROTAGONIST** — drives discovery, captures business rules as draft requirements |
| Tech Writer | Secondary — builds the domain glossary from discoveries |
| Enterprise Architect | Secondary — identifies system boundaries and external integrations |
| DBA | Secondary — focuses on data structures, field types, and relationships |
| Product Owner | Observer — validates domain understanding, confirms business context |
| All others | Observer — follow along, ready to help when their expertise is needed |

## When to Invoke

- **Stage**: 1 — Archaeology
- **Time window**: First 60 minutes of the hackathon (after the 30-minute opening)
- **Prerequisite**: The `legacy/` folder must be available in the team's workspace (symlinked by `scripts/setup.sh`)

## How to Activate

1. Open the VS Code Chat panel (`Ctrl+Shift+I` or `Cmd+Shift+I`)
2. Click the chatmode selector at the top of the chat panel
3. Select **archaeologist**
4. Paste your opening prompt:
   ```
   I'm starting Stage 1 — Archaeology. I have a legacy Natural/Adabas codebase
   in the legacy/ folder. Help me explore it systematically. What should I look
   at first?
   ```
5. Follow the agent's guidance to explore programs, DDMs, and call chains

## Definition of Done

Your team exits Stage 1 when you have:

- [ ] A **domain glossary** with at least 15 terms extracted from the legacy code
- [ ] A **program catalog** listing every Natural program with a 1-line purpose hypothesis
- [ ] A **data map** documenting every DDM file with key fields and relationships
- [ ] A **call graph** showing which programs call which (Mermaid or text diagram)
- [ ] A **mystery log** with at least 3 identified mysteries and investigation notes
- [ ] A **business rule draft** with at least 5 rules stated in plain English, traced to source code

## Anti-Patterns We Refuse

| Anti-pattern | What happens instead |
|---|---|
| "Just tell me what the system does" | The agent opens the first file and reads it *with* you |
| Skipping programs or DDMs | The agent insists on systematic coverage before moving on |
| Fabricating explanations for unclear code | The agent catalogs it as a mystery and moves on |
| Modifying legacy files | The agent has no edit tools — `legacy/` is a museum |
| Jumping to architecture design | The agent redirects to Stage 2 and `@architect-agent` |

## Chatmode File

[`.github/chatmodes/archaeologist.chatmode.md`](../../.github/chatmodes/archaeologist.chatmode.md)

---

| Previous | Home | Next |
|----------|------|------|
| [Agent Kits Overview](../README.md) | [Team Kit Home](../../README.md) | [Architect Agent](../02-architect/README.md) |
