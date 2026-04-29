---
title: "Cheat Sheet - Claude Model Routing in Copilot"
description: "One page. When to use Claude Haiku 4.5, Sonnet 4.6, or Opus 4.6 in GitHub Copilot. Simple rules, typical cases."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
tags: ["cheat-sheet", "copilot", "claude", "model-routing", "hackathon", "DATACORP"]
---

# 🧠 Claude Model Routing — Cheat Sheet

> Bigger model = more capable and slower. Use the smallest one that solves your problem. Save Opus for decisions, not batch production.

---

## 📑 Table of Contents

1. [The Three Models](#-the-three-models)
2. [Typical Cases by Persona](#-typical-cases-by-persona)
3. [Signs You're Using the Wrong Model](#-signs-youre-using-the-wrong-model)
4. [Paula's Tip](#-paulas-tip)

---

## 🔀 The Three Models

| Model | When to Use | Relative Cost | Speed |
|---|---|---|---|
| **Haiku 4.5** | Mechanical task, simple transformation, small context | Low | Fast |
| **Sonnet 4.6** | Daily standard. Code, tests, refactor, explanation | Medium | Medium |
| **Opus 4.6** | Architectural decision, impact analysis, trade-off discussion | High | Slow |

---

## 👥 Typical Cases by Persona

### Product Owner / Requirements Engineer
- Write user story → **Sonnet**.
- Refine already-written EARS → **Haiku**.
- Discuss if a requirement should be v1 or v2 → **Opus** (once, decide, move on).

### Architects (Enterprise + Software)
- Draw C4 with Mermaid → **Sonnet**.
- Decide between two patterns (hexagonal vs layered) → **Opus**.
- Generate syntactic variation of existing diagram → **Haiku**.

### Technical Lead
- Review medium-size PR → **Sonnet**.
- Decide global project pattern (transaction style, etc.) → **Opus** at start; **Sonnet** after to apply.
- Answer "does this code compile?" → **Haiku**.

### Developer
- Generate service implementation → **Sonnet**.
- Write simple unit test → **Haiku**.
- Debate class structure before writing → **Opus**.

### DBA
- Translate Adabas DDM to SQL → **Sonnet** (with Opus for edge cases).
- Generate repetitive DDL → **Haiku**.
- Decide `payment` partitioning strategy → **Opus**.

### QA Engineer
- Generate JUnit 5 skeleton → **Haiku**.
- Write non-trivial integration test → **Sonnet**.
- Decide if scenario warrants Testcontainers vs mock → **Opus**.

### DevOps Engineer
- Generate standard GitHub Actions YAML → **Sonnet**.
- Adjust trivial workflow commands → **Haiku**.
- Decide Azure topology → **Opus**.

### Tech Writer
- Review README style → **Haiku**.
- Draft ADR → **Sonnet**.
- Decide overall documentation structure → **Opus**, once.

---

## ⚠️ Signs You're Using the Wrong Model

- **Waiting 30s for a trivial answer** → go to smaller model.
- **Answer came shallow on critical decision** → go to Opus.
- **Answer is perfectly correct but you wanted discussion** → go to Opus.
- **You're stacking prompts for Opus to generate 400 files** → drop to Sonnet or Haiku.

---

## 💡 Paula's Tip

Don't treat Opus as "the good one" and Haiku as "the bad one". Opus on a mechanical task is wasteful; Haiku on a decision is risky. The right model is the cheapest one that doesn't leave you stranded.

— Paula

---

## 🧭 Navigation

| Previous | Home | Next |
|---|---|---|
| ← [Copilot Modes](./copilot-3-modes.md) | [Kit Root](../README.md) | [Specky Workflow](./specky-workflow.md) → |

> Author: Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft.
