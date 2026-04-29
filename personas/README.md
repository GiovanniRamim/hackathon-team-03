---
title: "Personas - Team Kit"
description: "AI persona definitions for each hackathon team role, used to configure Copilot agent behavior"
author: "Paula Silva, Americas Software GBB, Microsoft"
date: "2026-04-23"
version: "1.0.0"
status: "approved"
tags: ["personas", "copilot", "roles", "hackathon", "team-kit"]
---

# Personas

> Role-specific persona cards for each team member. These define domain expertise, responsibilities, and Copilot agent behavior for the hackathon.

## How to use these cards (beginners)

1. **Pick a role.** Your team lead assigns one of the 10 personas to each member.
2. **Read your card top to bottom** (~10 minutes). It tells you:
   - What you produce in each of the 4 stages
   - Which Copilot mode (Chat / Edits / Agent) is your default
   - Which other personas you depend on, and who depends on you
   - 3 ready-to-paste prompts to start with
   - What to do if you get stuck (the "emergency defaults" section)
3. **Install your matching Copilot kit** from `../persona-kits/` — see [SETUP.md §8](../SETUP.md#-step-8--install-your-personas-copilot-kit-everyone) for the exact commands.
4. **During the day**, keep your card open in a tab. Re-read your section for the current stage.

> 💡 **The card answers "what is my role doing right now?"** The kit gives you the **Copilot tools** to do it.

## Contents

| File | Role | Copilot kit (in `../persona-kits/`) |
|------|------|-------------------------------------|
| `01-product-owner.md` | Product Owner — backlog prioritization and stakeholder alignment | `01-product-owner/` |
| `02-requirements-engineer.md` | Requirements Engineer — EARS notation and spec writing | `03-requirements-engineer/` |
| `03-enterprise-architect.md` | Enterprise Architect — system-level design decisions | `04-enterprise-architect/` |
| `04-software-architect.md` | Software Architect — component-level architecture | `05-software-architect/` |
| `05-technical-lead.md` | Technical Lead — code standards and team coordination | `06-technical-lead/` |
| `06-developer.md` | Developer — implementation and testing | `22-developer/` |
| `07-dba.md` | DBA — database design and migrations | `21-dba/` |
| `08-qa-engineer.md` | QA Engineer — test strategy and coverage | `13-qa-engineer/` |
| `09-devops-engineer.md` | DevOps Engineer — CI/CD, IaC, and deployment | `11-devops-engineer/` |
| `10-tech-writer.md` | Tech Writer — documentation and ADRs | `23-tech-writer/` |

## Two persona pools

- **The 10 cards in this folder** are the canonical roles teams use during the hackathon.
- **The 25 kits in `../persona-kits/`** include 15 specialized roles (Business Manager, UX Designer, SRE, AppSec, ...) you can pull in if your team has the headcount or specialized work.

## Navigation

| Parent | Home |
|----------|------|
| [Team Kit](../README.md) | [Repository Root](../README.md) |
