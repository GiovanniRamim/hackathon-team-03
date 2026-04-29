---
title: "Persona Card - Technical Lead"
description: "What the Technical Lead does inside the team of 10 during Day 2 of Hackathon DATACORP 2026."
author: "Paula Silva, Americas Software GBB, Microsoft"
date: "2026-04-18"
version: "1.0.0"
persona_id: "05"
tags: ["persona", "technical-lead", "hackathon", "DATACORP"]
---

# Persona - Technical Lead

## Who this person is

The link between architecture and day-to-day code. Decides implementation patterns (code conventions, test style, module structure), unblocks the team when someone gets stuck on a technical detail, and is responsible for making sure that at the end of Stage 3 the application actually starts with `docker compose up`.

## Mission in the hackathon

Maintain execution velocity in Stage 3. Pick technical battles that are worth fighting. Unblock quickly. Review PRs with rigor but without obstruction.

## Your role in the Agentic Legacy Modernization framework

This hackathon applies the **Agentic Legacy Modernization** framework — an approach to legacy system modernization using AI agents specialized in each phase. The full pipeline is described in the **Hackathon Blueprint** (provided separately by the facilitators). Your persona maps to the pipeline as follows:

- **Relevant agents**: Review Agent (S3), Test Gen Agent (S3)
- **Framework phase**: Translation and Test Generation
- **Your role in the pipeline**: Ensure translation quality and coordinate parallel implementation

## Where you show up by stage

| Stage | You do this | Deliverable that depends on you |
|---|---|---|
| 1. Archaeology | Participate in legacy analysis prioritizing critical programs. Estimate complexity. | Effort-based prioritization |
| 2. Greenfield Spec | Validate that the spec is realistic in the 3 hours of Stage 3. Flag "this won't fit". | Scope calibration |
| 3. Reconstruction | Unblock. Decide patterns (test style, transactions, error handling). Review every PR. | Application running end-to-end |
| 4. Evolution with Agent | Review the Agent's PR line by line before merging. | PR at production quality |

## Tools and primitives

- **Copilot Edits** for batch refactoring.
- **Copilot Chat** as a pair for local design decisions.
- **Specky** - support in phases 5 (Implementation Plan) and 6 (Task Breakdown).
- **Git MCP** for PR review.

## Cheat sheets you use

- All three cheat sheets. You are the most versatile.
- `cheat-sheets/copilot-3-modes.md` especially - you switch between all three constantly.

## How you do well

- Answer a technical question in under 5 minutes. Don't leave anyone stuck.
- Reviews that move the PR forward, not reviews that block it.
- Pick two key patterns at the start of Stage 3 and defend them without negotiation (e.g., "everything transactional via `@Transactional` in the service layer").
- Keep `main` green at all times.

## How you get lost

- Try to write half the code yourself.
- Blocking review over aesthetic details.
- Change patterns in the middle of Stage 3.
- Don't spot a bottleneck and `docker compose up` doesn't start at the end.

## If you took on two personas

- **TL + Developer** is the natural pair - you lead and you keep writing code.
- **TL + Software Architect** if the team has someone covering dev.
- Avoid **TL + QA** in the same brain: the role of the person asking "did you cover the test?" is stronger when held by a different person.

## 3 Example prompts

1. **(Chat)** "Review this PR: check whether it follows the 3 layers (domain/application/infrastructure), whether the test covers happy path + error, and whether there's any import crossing a bounded context."
2. **(Chat)** "We have 3 devs and 3 hours. Pending features: [list]. Create a plan distributing them across devs considering dependencies and complexity."
3. **(Chat)** "`docker compose up` fails with this error: [paste]. Diagnose the root cause and propose a fix."

## If you get stuck (emergency defaults)

- **Docker won't start?** Check: port 5432 occupied? Does `docker ps` show old containers? `docker compose down && docker compose up -d`.
- **Team slow?** Stop, redistribute: "Dev A does the endpoint, Dev B does the migration, QA does the test. Merge in 45 min."
- **Conflicting PR?** `git pull --rebase` and resolve. Don't let a branch diverge for more than 2 hours.
- **Don't know how to decide a pattern?** Pick what the prototype already uses. Copy the style of `BeneficiaryService.java`.

## Dependencies - Who depends on you

| Persona | Relationship | Artifact |
|---------|---------|----------|
| Software Architect | YOU depend on them | Defined package structure |
| Product Owner | YOU depend on them | Calibrated scope |
| Developer | Depends on YOU | Patterns and reviews |
| QA Engineer | Depends on YOU | Green pipeline to run tests |
| DevOps Engineer | Depends on YOU | Stable build for the pipeline |

## How you are evaluated

- **Rubric A3 (Technical Integrity):** the application starts with `docker compose up`.
- **Rubric A6 (Collaboration):** nobody stuck for more than 20 minutes.
- Criterion: "`main` green at all times, PRs reviewed in under 15 minutes."

- Paula
