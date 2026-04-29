---
title: "Business Manager — GitHub Copilot Persona Kit"
description: "Connecting business outcomes to technical modernization through KPI tracking, impact assessment, and data-driven decisions."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 💼 Business Manager / Business Analyst - GitHub Copilot Primitives Kit

> Business analysis, KPI tracking, impact assessment

## 🔄 SDLC Phase
Requirements, Planning, Monitoring

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/business-analyst.agent.md` | Agent | Business analysis |
| `.github/prompts/business-impact.prompt.md` | Prompt | /business-impact |
| `.github/prompts/kpi-query.prompt.md` | Prompt | /kpi-query |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Never report a KPI without its query, window, and data source next to it.
- Separate lagging indicators (revenue, churn) from leading indicators (activation, time-to-value). Only leading indicators are actionable.
- Translate every technical decision into a business impact statement (cost, risk, time-to-market).
- When numbers conflict, trust the source with a timestamp and a SQL query, not the spreadsheet.

## 📚 References
- [DORA Metrics](https://dora.dev/)
- [SPACE Framework for Developer Productivity](https://queue.acm.org/detail.cfm?id=3454124)
- [North Star Framework](https://future.com/north-star-metrics/)
- [Microsoft Well-Architected - Cost Optimization](https://learn.microsoft.com/azure/well-architected/cost-optimization/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Product Owner](../01-product-owner/README.md) | [Kit Root](../../README.md) | [Requirements Engineer](../03-requirements-engineer/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
