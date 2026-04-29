---
title: "Builder Agent Kit"
description: "Stage 3 agent for implementation — Java 21 backend, JPA entities, REST API, Next.js frontend, equivalence tests"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-29"
version: "1.0.0"
status: "approved"
tags: ["agent", "builder", "implementation", "java", "nextjs", "stage-3"]
---

# @builder-agent — Stage 3: Implementation

> A builder does not lay bricks at random — they follow the architect's blueprints. Your Stage 2 specification is the blueprint. Now you build: Java services, JPA entities, REST endpoints, Next.js pages, and the tests that prove they work.

## What This Agent Does

- **Translates legacy patterns to Java 21** — converts Natural program logic to modern Java using records, sealed interfaces, Optional, and virtual threads
- **Generates JPA entities from FDT mappings** — turns Adabas field types into proper JPA annotations, handling MU fields (JSONB / @ElementCollection) and PE groups (@OneToMany)
- **Builds REST controllers** — creates Spring Boot endpoints with OpenAPI annotations, validation, and proper error handling (RFC 7807 ProblemDetail)
- **Creates Next.js pages** — generates App Router pages with Server Components, client interactivity where needed, and shadcn/ui components
- **Writes equivalence tests** — produces JUnit 5 and Vitest tests that verify the modern system produces equivalent business outcomes to the legacy system

## Who Uses This Agent

| Persona | Role in This Stage |
|---------|-------------------|
| **Developer** | **PROTAGONIST** — writes and reviews implementation code across backend and frontend |
| DBA | Secondary — validates schema design, migrations, and data integrity |
| QA Engineer | Secondary — writes tests, validates acceptance criteria, monitors coverage |
| Technical Lead | Secondary — reviews code quality, ensures standards compliance |
| Software Architect | Secondary — validates implementation matches the Stage 2 design |
| All others | Observer — available when domain knowledge is needed |

## When to Invoke

- **Stage**: 3 — Implementation
- **Time window**: Minutes 135-255 of the hackathon (the longest stage at 120 minutes)
- **Prerequisite**: Stage 2 deliverables (SPECIFICATION.md, bounded context map, C4 diagrams, ADRs, data model draft, API contracts)

## How to Activate

1. Open the VS Code Chat panel
2. Select the **builder** chatmode
3. Paste your opening prompt:
   ```
   I'm starting Stage 3 — Implementation. Our SPECIFICATION.md has [N] EARS
   requirements and we've defined [N] bounded contexts. Here is our API contract:
   [paste or reference]. Help me start with the domain entities for the first
   bounded context.
   ```
4. Work through entities → services → controllers → tests → frontend pages

## Definition of Done

Your team exits Stage 3 when you have:

- [ ] **JPA entities** for each bounded context with proper relationships and annotations
- [ ] At least **one service** per bounded context with business logic
- [ ] At least **3 REST endpoints** working with OpenAPI annotations
- [ ] **Database migrations** (Flyway or Liquibase) creating the schema
- [ ] At least **60% line coverage** with JUnit 5 backend tests
- [ ] At least **2 Next.js pages** consuming the REST API
- [ ] At least **3 Vitest** component tests
- [ ] **Green build**: `mvn verify` and `npm run build` both pass

## Anti-Patterns We Refuse

| Anti-pattern | What happens instead |
|---|---|
| Code without a `REQ-NNN` trace | The agent asks: "Which requirement does this fulfill?" |
| Services without tests | The agent generates the test file alongside the service |
| Line-by-line Natural porting | The agent builds *equivalent behavior* using Java 21 idioms |
| Guessing at business logic | The agent asks the team to clarify ambiguous requirements |
| Microservices creep | All code stays in the Modular Monolith; new deployables are refused |
| Skipping validation | Controllers always use `@Valid`; services validate preconditions |

## Chatmode File

[`.github/chatmodes/builder.chatmode.md`](../../.github/chatmodes/builder.chatmode.md)

---

| Previous | Home | Next |
|----------|------|------|
| [Architect Agent](../02-architect/README.md) | [Team Kit Home](../../README.md) | [Evolution Agent](../04-evolution/README.md) |
