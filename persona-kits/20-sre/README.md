---
title: "SRE — GitHub Copilot Persona Kit"
description: "Ensuring system reliability through SLO definitions, incident response automation, and observability-driven operations."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🔧 Sre - GitHub Copilot Primitives Kit

> SLO management, runbooks, incident response, monitoring

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/sre.agent.md` | Agent | SLO management, runbooks, incident response, monit |
| `.github/prompts/create-runbook.prompt.md` | Prompt | /create-runbook |
| `.github/prompts/slo-define.prompt.md` | Prompt | /slo-define |
| `.github/prompts/incident-response.prompt.md` | Prompt | /incident-response |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- SLOs set the ambition, error budgets set the speed. When the budget is spent, stop shipping features and start fixing reliability.
- Alert on symptoms, not causes. Users do not care that disk is full, they care that checkout is broken.
- Runbooks that only live in someone's head are an outage waiting to happen. Document while calm.
- Toil is debt. Track it, budget against it, automate the top items every quarter.

## 📚 References
- [Google SRE Book](https://sre.google/sre-book/table-of-contents/)
- [The SRE Workbook](https://sre.google/workbook/table-of-contents/)
- [USE Method - Brendan Gregg](https://www.brendangregg.com/usemethod.html)
- [Azure Monitor Best Practices](https://learn.microsoft.com/azure/azure-monitor/best-practices/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Compliance Auditor](../19-compliance-auditor/README.md) | [Kit Root](../../README.md) | [DBA](../21-dba/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
