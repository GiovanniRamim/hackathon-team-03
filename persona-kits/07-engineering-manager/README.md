---
title: "Engineering Manager — GitHub Copilot Persona Kit"
description: "Balancing people, process, and delivery cadence to keep modernization teams productive and healthy."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 👔 Engineering Manager - GitHub Copilot Primitives Kit

> Team metrics and delivery health

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/engineering-manager.agent.md` | Agent | Team metrics and delivery health |
| `.github/prompts/team-health.prompt.md` | Prompt | /team-health |
| `.github/prompts/capacity-plan.prompt.md` | Prompt | /capacity-plan |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Measure the team, not the individuals. DORA metrics move at team scale.
- 1:1s are a leading indicator of retention. Skip them and you lose people before you see the signal.
- Capacity planning is a probability distribution, not a number. Communicate ranges, not dates.
- Protect focus time. The cost of an interrupted engineer is 23 minutes, every time.

## 📚 References
- [DORA Metrics](https://dora.dev/)
- [SPACE Framework](https://queue.acm.org/detail.cfm?id=3454124)
- [Resilient Management - Lara Hogan](https://resilient-management.com/)
- [An Elegant Puzzle - Will Larson](https://lethain.com/elegant-puzzle/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Technical Lead](../06-technical-lead/README.md) | [Kit Root](../../README.md) | [UX Designer](../08-ux-designer/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
