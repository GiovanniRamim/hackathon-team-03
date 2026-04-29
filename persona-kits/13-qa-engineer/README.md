---
title: "QA Engineer — GitHub Copilot Persona Kit"
description: "Designing comprehensive test strategies, ensuring coverage targets, and automating quality gates across the pipeline."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🧪 Qa Engineer - GitHub Copilot Primitives Kit

> Test generation from specs, coverage analysis, quality gates

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/qa-engineer.agent.md` | Agent | Test generation from specs, coverage analysis, qua |
| `.github/prompts/create-tests.prompt.md` | Prompt | /create-tests |
| `.github/prompts/coverage-gaps.prompt.md` | Prompt | /coverage-gaps |
| `.github/prompts/test-strategy.prompt.md` | Prompt | /test-strategy |
| `.github/instructions/tests.instructions.md` | Instructions | Test Conventions |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Test pyramid: 70% unit, 20% integration, 10% end-to-end. Invert it and your CI will take an hour.
- A flaky test is a broken test. Quarantine it the same day, fix it within the week, or delete it.
- Coverage is necessary but not sufficient. A line covered by an assertion-less test is worse than no coverage.
- Traceability: every requirement has at least one test, every test links to at least one requirement.

## 📚 References
- [Google Testing Blog](https://testing.googleblog.com/)
- [xUnit Test Patterns - Gerard Meszaros](http://xunitpatterns.com/)
- [Software Testing ISTQB](https://www.istqb.org/)
- [Property-Based Testing - jqwik/fast-check](https://jqwik.net/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Platform Architect](../12-platform-architect/README.md) | [Kit Root](../../README.md) | [UAT Analyst](../14-uat-analyst/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
