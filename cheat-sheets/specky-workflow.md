---
title: "Cheat Sheet - Specky SDD v3.4"
description: "One page. SDD pipeline, 6 EARS patterns, Specky v3.4 agents and commands."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "2.1.0"
tags: ["cheat-sheet", "specky", "SDD", "EARS", "hackathon", "DATACORP"]
---

# 📋 Specky SDD v3.4 — Cheat Sheet

> Spec-Driven Development engine. 13 agents, 57 MCP tools, 16 hooks. The pipeline is enforced — no skipping phases.

> Repo: https://github.com/paulasilvatech/specky | Install: `npm install -g specky-sdd@latest`

---

## 📑 Table of Contents

1. [Quick Setup](#-quick-setup)
2. [The 6 EARS Patterns](#-the-6-ears-patterns)
3. [Pipeline — 10 Phases](#-pipeline--10-phases)
4. [Slash Commands](#-slash-commands)
5. [Most-Used MCP Tools](#-most-used-mcp-tools)
6. [Hooks That Will Trigger](#-hooks-that-will-trigger)
7. [Hackathon Flow](#-hackathon-flow)
8. [Tips](#-tips)

---

## ⚙️ Quick Setup

```bash
specky install --ide=copilot   # VS Code + Copilot
specky install --ide=claude    # Claude Code
specky doctor                  # Validate installation
```

---

## 📐 The 6 EARS Patterns

| # | Pattern | Template | SIFAP Example |
|---|---------|----------|---------------|
| 1 | **Ubiquitous** | The system shall [action] | SIFAP shall record audit on every change |
| 2 | **Event-driven** | When [X], the system shall [action] | When cycle is generated, create payments for ACTIVE |
| 3 | **State-driven** | While [X], the system shall [action] | While PENDING, allow cancellation |
| 4 | **Optional** | Where [condition], the system shall [action] | Where exporting, generate UTF-8 CSV |
| 5 | **Unwanted** | If [X], the system shall not [action] | Do not allow DELETE on audit records |
| 6 | **Complex** | While [X], when [Y], where [Z], shall [action] | In December, for ACTIVE, calculate 13th month |

Validate: `sdd_validate_ears` (MCP tool) or `@spec-engineer` (agent)

---

## 🔟 Pipeline — 10 Phases

| # | Phase | Agent | Deliverable | Owner Persona | Stage |
|---|-------|-------|-------------|---------------|-------|
| 0 | Init | `@sdd-init` | CONSTITUTION.md | TL | 2 |
| 1 | Discover | `@research-analyst` | RESEARCH.md | RE + EA | 2 |
| 2 | Specify | `@spec-engineer` | SPECIFICATION.md (EARS) | RE | 2 |
| 3 | Clarify | `@sdd-clarify` | CLARIFICATION-LOG.md | RE + PO | 2 |
| 4 | Design | `@design-architect` | DESIGN.md + C4 + ADRs | SA + EA | 2 |
| 5 | Tasks | `@task-planner` | TASKS.md + CHECKLIST.md | TL | 3 |
| 6 | Analyze | `@quality-reviewer` | ANALYSIS.md | QA | 3 |
| 7 | Implement | `@implementer` | Code | Dev | 3 |
| 8 | Verify | `@test-verifier` | Tests + coverage | QA | 3 |
| 9 | Release | `@release-engineer` | PR + deploy | DevOps | 4 |

LGTM gates: after Specify, Design, and Tasks. Review before advancing.

---

## 🔧 Slash Commands

| Command | When to Use |
|---------|-------------|
| `/specky-migration` | **MAIN** — SIFAP modernization |
| `/specky-specify` | Write EARS requirements |
| `/specky-design` | Generate architecture + diagrams |
| `/specky-tasks` | Break design into tasks |
| `/specky-verify` | Validate tests vs spec |
| `/specky-release` | Create final PR |

---

## 🛠️ Most-Used MCP Tools

| Tool | What It Does |
|------|-------------|
| `sdd_init` | Creates `.specs/NNN-feature/` |
| `sdd_write_spec` | Generates SPECIFICATION.md |
| `sdd_validate_ears` | Validates 6 EARS patterns |
| `sdd_generate_diagram` | Generates C4 in Mermaid |
| `sdd_write_design` | Generates DESIGN.md + ADRs |
| `sdd_write_tasks` | Generates sequenced TASKS.md |
| `sdd_check_sync` | Detects drift spec vs code |

---

## 🪝 Hooks That Will Trigger

- **no-code-without-spec**: blocks PR without spec reference
- **EARS-linter**: complains about requirement outside 6 patterns
- **ADR-completeness**: requires "path not chosen"
- **traceability-check**: ties requirement to test

When a hook blocks: **read the message**. Fix the artifact, don't force override.

---

## 🏃 Hackathon Flow

```
Stage 2 (2h):
  @specky-orchestrator -> Init -> Discover -> Specify -> Clarify -> Design
  
Stage 3 (3h):
  @task-planner -> Tasks -> @implementer -> Code -> @test-verifier -> Verify

Stage 4 (1h30):
  @release-engineer -> Release -> PR
```

---

## 💡 Tips

- Don't skip to Code without going through Specify + Design
- `specky doctor` should be all green before starting
- If Specky is unavailable: write EARS manually — the format is plain text
- Use `@specky-orchestrator` to let the pipeline guide you

— Paula

---

## 🧭 Navigation

| Previous | Home | Next |
|---|---|---|
| ← [Model Routing](./model-routing.md) | [Kit Root](../README.md) | [Persona Kits](../persona-kits/README.md) → |

> Author: Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft.
