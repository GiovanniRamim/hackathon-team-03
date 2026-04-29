---
title: "Enterprise Architect — GitHub Copilot Persona Kit"
description: "Governing cross-system architecture decisions with ADRs, C4 models, and Azure Well-Architected alignment."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🏗️ Enterprise / Solution Architect - GitHub Copilot Primitives Kit

> Governing cross-system architecture decisions with ADRs, C4 models, and Azure Well-Architected alignment.

## 🔄 SDLC Phase
Architecture, Design, Security

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/enterprise-architect.agent.md` | Agent | Architecture and security |
| `.github/prompts/create-constitution.prompt.md` | Prompt | /create-constitution |
| `.github/prompts/create-adr.prompt.md` | Prompt | /create-adr |
| `.github/prompts/architecture-review.prompt.md` | Prompt | /architecture-review |
| `.github/instructions/security.instructions.md` | Instructions | Security conventions |
| `.github/instructions/infrastructure.instructions.md` | Instructions | IaC conventions |
| `hooks.json` | Hooks | Block CONSTITUTION.md edits |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Model at C4 Level 1-2 for executives, Level 3-4 for implementers. Mixing levels in one diagram hides both.
- Every architectural decision needs an ADR with Context, Decision, Consequences. No ADR, no decision.
- Design for boring. Novel architecture in production is technical debt with a launch party.
- Apply the Azure Well-Architected pillars (Reliability, Security, Cost, Operational Excellence, Performance) as review gates, not as checklists at the end.

## 📚 References
- [C4 Model - Simon Brown](https://c4model.com/)
- [Microsoft Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
- [ADR - Architecture Decision Records](https://adr.github.io/)
- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Requirements Engineer](../03-requirements-engineer/README.md) | [Kit Root](../../README.md) | [Software Architect](../05-software-architect/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
