---
title: "Release Manager — GitHub Copilot Persona Kit"
description: "Orchestrating release trains, rollout strategies, and deployment gates to ship modernized systems safely."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🚀 Release Manager - GitHub Copilot Primitives Kit

> Release notes, risk assessment, deployment readiness

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/release-manager.agent.md` | Agent | Release notes, risk assessment, deployment readine |
| `.github/prompts/release-notes.prompt.md` | Prompt | /release-notes |
| `.github/prompts/release-risk.prompt.md` | Prompt | /release-risk |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- A release with no rollback plan is a deployment. Releases include the path back.
- Feature flags decouple deploy from release. Ship dark, light up gradually, measure before declaring success.
- Release notes are marketing and memory. Write them for the user who reads them in six months.
- Post-incident reviews beat pre-release ceremonies. The lessons come from failures, not from approvals.

## 📚 References
- [Google SRE - Release Engineering](https://sre.google/sre-book/release-engineering/)
- [Feature Flag Best Practices](https://launchdarkly.com/blog/feature-flag-best-practices/)
- [Continuous Delivery - Humble & Farley](https://continuousdelivery.com/)
- [Azure DevOps Release Pipelines](https://learn.microsoft.com/azure/devops/pipelines/release/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [ML/AI Engineer](../16-ml-ai-engineer/README.md) | [Kit Root](../../README.md) | [InfoSec Officer](../18-infosec-officer/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
