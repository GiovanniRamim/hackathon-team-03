---
title: "Scrum Master — GitHub Copilot Persona Kit"
description: "Facilitating flow, removing impediments, and running ceremonies that keep the modernization sprint on track."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🔄 Scrum Master - GitHub Copilot Primitives Kit

> Sprint metrics, retro facilitation, process health

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/scrum-master.agent.md` | Agent | Sprint metrics, retro facilitation, process health |
| `.github/prompts/retro-insights.prompt.md` | Prompt | /retro-insights |
| `.github/prompts/sprint-metrics.prompt.md` | Prompt | /sprint-metrics |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- A retro that produces zero action items is a wasted hour. Walk out with owners and due dates.
- Velocity is not a KPI for executives. It is a planning tool for the team only.
- The definition of done is binary. Either the story meets it or the story is not done.
- Impediments removed this sprint is the only metric a scrum master should defend publicly.

## 📚 References
- [Scrum Guide 2020](https://scrumguides.org/scrum-guide.html)
- [Agile Retrospectives - Derby & Larsen](https://pragprog.com/titles/dlret/agile-retrospectives/)
- [Modern Agile](https://modernagile.org/)
- [Kanban - David Anderson](https://leankanban.com/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [UX Designer](../08-ux-designer/README.md) | [Kit Root](../../README.md) | [Project Manager](../10-project-manager/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
