---
title: "Agent Kits — 4 SDLC Stage Agents"
description: "Horizontal agent layer organized by SDLC stage, complementing the 25 vertical persona-kits"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-29"
version: "1.0.0"
status: "approved"
tags: ["agents", "sdlc", "chatmodes", "copilot", "hackathon"]
---

# Agent Kits — 4 SDLC Stage Agents

> If the persona-kits are **columns** — one per role — then the agent kits are **rows** — one per stage of the day. Every persona uses every agent, but the spotlight shifts as the clock advances.

The 25 persona-kits tell each person *what they own*. The 4 agent kits tell the team *how to work together in this stage*. They are complementary axes of the same coordinate system.

## The 4 Agents

| Agent | Stage | Mission | Chatmode | Model |
|-------|-------|---------|----------|-------|
| [`@archaeologist-agent`](01-archaeologist/README.md) | 1 — Archaeology | Read legacy code, extract rules, map dependencies, catalog mysteries | [`archaeologist`](../.github/chatmodes/archaeologist.chatmode.md) | Claude Opus 4.7 |
| [`@architect-agent`](02-architect/README.md) | 2 — Modern Spec | Carve bounded contexts, write EARS, generate ADRs, design Modular Monolith | [`architect`](../.github/chatmodes/architect.chatmode.md) | Claude Opus 4.7 |
| [`@builder-agent`](03-builder/README.md) | 3 — Implementation | Translate legacy patterns to Java 21, generate JPA from FDT, write tests, build REST + Next.js | [`builder`](../.github/chatmodes/builder.chatmode.md) | Claude Sonnet 4.6 |
| [`@evolution-agent`](04-evolution/README.md) | 4 — Evolution | Write GitHub Issues for Copilot Agent, review AI-generated PRs, set up CI/CD and IaC | [`evolution`](../.github/chatmodes/evolution.chatmode.md) | Claude Sonnet 4.6 |

## Persona × Agent Matrix

Every persona uses every agent, with varying intensity. **PROTAGONIST** drives the agent during their stage. **Secondary** actively contributes. **Observer** follows along.

| Persona | @archaeologist | @architect | @builder | @evolution |
|---------|---------------|------------|----------|------------|
| Product Owner | Observer | Secondary | Observer | Secondary |
| Requirements Engineer | **PROTAGONIST** | Secondary | Observer | Observer |
| Enterprise Architect | Secondary | Secondary | Observer | Observer |
| Software Architect | Observer | **PROTAGONIST** | Secondary | Observer |
| Technical Lead | Observer | Secondary | Secondary | **PROTAGONIST** |
| Developer | Observer | Observer | **PROTAGONIST** | Secondary |
| DBA | Secondary | Observer | Secondary | Observer |
| QA Engineer | Observer | Observer | Secondary | Secondary |
| DevOps Engineer | Observer | Observer | Secondary | Secondary |
| Tech Writer | Secondary | Observer | Observer | Secondary |

For detailed per-cell guidance, see [`../docs/persona-agent-matrix.md`](../docs/persona-agent-matrix.md).

## How to Activate an Agent

```mermaid
flowchart TD
    A["1. Open VS Code Chat Panel"] --> B["2. Click the chatmode selector\n(top of chat panel)"]
    B --> C["3. Select the agent\nfor your current stage"]
    C --> D{"Which stage?"}
    D -->|"Stage 1"| E["Select: archaeologist"]
    D -->|"Stage 2"| F["Select: architect"]
    D -->|"Stage 3"| G["Select: builder"]
    D -->|"Stage 4"| H["Select: evolution"]
    E --> I["4. Paste your opening prompt\nfrom the stage guide"]
    F --> I
    G --> I
    H --> I
    I --> J["5. Work with the agent\nthrough your stage tasks"]

    style A fill:#0f172a,stroke:#334155,color:#e2e8f0
    style B fill:#0f172a,stroke:#334155,color:#e2e8f0
    style C fill:#0f172a,stroke:#334155,color:#e2e8f0
    style D fill:#0f172a,stroke:#334155,color:#e2e8f0
    style E fill:#0f172a,stroke:#334155,color:#e2e8f0
    style F fill:#0f172a,stroke:#334155,color:#e2e8f0
    style G fill:#0f172a,stroke:#334155,color:#e2e8f0
    style H fill:#0f172a,stroke:#334155,color:#e2e8f0
    style I fill:#0f172a,stroke:#334155,color:#e2e8f0
    style J fill:#0f172a,stroke:#334155,color:#e2e8f0
```

## The No-Silver-Platter Rule

These agents know **how** to modernize Natural/Adabas systems in general. They do **not** know anything about your specific legacy system. The business rules, data structures, and mysteries of your system must emerge from your team's investigation. Agents work **with** you, not **for** you.

---

| Previous | Home | Next |
|----------|------|------|
| [Persona Kits](../persona-kits/) | [Team Kit Home](../README.md) | [Docs](../docs/) |
