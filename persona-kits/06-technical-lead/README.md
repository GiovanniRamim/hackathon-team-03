---
title: "Technical Lead — GitHub Copilot Persona Kit"
description: "Driving team delivery, code quality gates, and technical decision-making across the modernization lifecycle."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🧠 Technical Lead - GitHub Copilot Primitives Kit

> Context engineering, model routing, quality gates, orchestration

## 🔄 SDLC Phase
All phases (oversight)

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/tech-lead.agent.md` | Agent | Governance |
| `.github/prompts/setup-project.prompt.md` | Prompt | /setup-project |
| `.github/prompts/routing-table.prompt.md` | Prompt | /routing-table |
| `.github/prompts/audit-context.prompt.md` | Prompt | /audit-context |
| `hooks.json` | Hooks | Scope + lint + test |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- A tech lead blocks bad changes, not people. Review the PR, protect the reviewer's time.
- CODEMAP.md is the team's working memory. If it is stale, the team is flying blind.
- Model routing matters: Opus for discovery, Sonnet for implementation, Haiku for mechanical transforms. One model for everything burns money.
- Cost per feature is a first-class metric. Track it like you track coverage.

## 📚 References
- [Staff Engineer - Will Larson](https://staffeng.com/)
- [The Manager's Path - Camille Fournier](https://www.oreilly.com/library/view/the-managers-path/9781491973882/)
- [Accelerate - Forsgren, Humble, Kim](https://itrevolution.com/product/accelerate/)
- [GitHub Copilot Best Practices](https://docs.github.com/en/copilot)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Software Architect](../05-software-architect/README.md) | [Kit Root](../../README.md) | [Engineering Manager](../07-engineering-manager/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
