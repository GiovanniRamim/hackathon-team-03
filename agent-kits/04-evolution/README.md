---
title: "Evolution Agent Kit"
description: "Stage 4 agent for operationalization — GitHub Issues for Copilot Agent, PR review, CI/CD, Terraform IaC"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-29"
version: "1.0.0"
status: "approved"
tags: ["agent", "evolution", "devops", "terraform", "cicd", "stage-4"]
---

# @evolution-agent — Stage 4: Evolution

> A mission controller does not fly the spacecraft — they write the flight plan, dispatch the commands, and monitor the telemetry. That is you in Stage 4: writing the issues that AI agents will execute, reviewing what comes back, and wiring up the infrastructure that turns a prototype into a deployable system.

## What This Agent Does

- **Writes GitHub Issues for Copilot Agent** — crafts well-structured issues with clear titles, acceptance criteria, file path hints, and `REQ-NNN` traces so that Copilot Agent (cloud) can execute them autonomously
- **Reviews AI-generated PRs** — walks the team through a systematic review checklist: compilation, tests, requirement alignment, security, and error handling
- **Generates CI/CD pipelines** — produces GitHub Actions workflows with lint, build, test, and deploy stages, including caching and secret management
- **Creates Terraform modules** — generates IaC for Azure resources (App Service, PostgreSQL Flexible Server, Key Vault, Application Insights) with proper tagging
- **Prepares demo readiness** — helps the team prioritize what must work for the 3-minute presentation

## Who Uses This Agent

| Persona | Role in This Stage |
|---------|-------------------|
| **Technical Lead** | **PROTAGONIST** — dispatches issues, reviews PRs, owns integration decisions |
| DevOps Engineer | Secondary — writes Terraform modules, configures GitHub Actions |
| QA Engineer | Secondary — validates quality gates in the CI pipeline |
| Developer | Secondary — reviews AI-generated code for correctness |
| Tech Writer | Secondary — polishes READMEs and demo script for presentation |
| All others | Observer — contribute review feedback when tagged |

## When to Invoke

- **Stage**: 4 — Evolution
- **Time window**: Minutes 255-300 of the hackathon (final 45 minutes before presentations)
- **Prerequisite**: Stage 3 deliverables (working backend, frontend, tests, green build)

## How to Activate

1. Open the VS Code Chat panel
2. Select the **evolution** chatmode
3. Paste your opening prompt:
   ```
   I'm starting Stage 4 — Evolution. We have a working prototype with [N]
   endpoints and [N]% test coverage. Help me write GitHub Issues for Copilot
   Agent to handle remaining tasks, and set up our CI/CD pipeline.
   ```
4. Work through issues → Terraform → CI/CD → PR review → demo prep

## Definition of Done

Your team exits Stage 4 when you have:

- [ ] At least **3 GitHub Issues** created for Copilot Agent with acceptance criteria and `REQ-NNN` traces
- [ ] At least **1 AI-generated PR** reviewed (merged or feedback provided)
- [ ] A **GitHub Actions workflow** that runs lint + build + test on push
- [ ] At least **1 Terraform module** with proper Azure resource tags
- [ ] A **3-minute demo script** documenting what to show and in what order
- [ ] **Retrospective notes** capturing what worked, what surprised the team, and what to change

## Anti-Patterns We Refuse

| Anti-pattern | What happens instead |
|---|---|
| Vague issues ("Fix the backend") | The agent rewrites with specific files, criteria, and requirement traces |
| Blind-merging AI PRs | The agent walks the team through a review checklist before merge |
| Manual Azure portal setup | The agent generates Terraform — every resource is code |
| Secrets in source or logs | Hardcoded credentials are flagged immediately |
| Scope creep (new features) | New ideas go to a backlog issue; Stage 4 operationalizes what exists |

## Chatmode File

[`.github/chatmodes/evolution.chatmode.md`](../../.github/chatmodes/evolution.chatmode.md)

---

| Previous | Home | Next |
|----------|------|------|
| [Builder Agent](../03-builder/README.md) | [Team Kit Home](../../README.md) | [Agent Kits Overview](../README.md) |
