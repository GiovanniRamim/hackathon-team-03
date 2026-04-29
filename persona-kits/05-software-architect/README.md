---
title: "Software Architect — GitHub Copilot Persona Kit"
description: "Designing resilient system architecture with ADRs, domain decomposition, and Copilot-assisted design reviews."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🔧 Software Architect - GitHub Copilot Primitives Kit

> CODEMAP.md, module design, API contracts, implementation planning

## 🔄 SDLC Phase
Design, Implementation Oversight

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/software-architect.agent.md` | Agent | Architecture |
| `.github/prompts/codemap.prompt.md` | Prompt | /codemap |
| `.github/prompts/impl-plan.prompt.md` | Prompt | /impl-plan |
| `.github/prompts/api-validate.prompt.md` | Prompt | /api-validate |
| `.github/instructions/backend.instructions.md` | Instructions | Backend conventions |
| `.github/instructions/frontend.instructions.md` | Instructions | Frontend conventions |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Favor composition over inheritance, favor boundaries over abstractions, favor data over code.
- API contracts are law. Break them at the cost of a major version bump and a migration guide.
- Keep business logic out of the database and out of the framework. Domain code should be testable with zero infrastructure.
- When you see a 'util' folder growing, it is a missing bounded context. Refactor before it metastasizes.

## 📚 References
- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Domain-Driven Design - Eric Evans](https://www.domainlanguage.com/ddd/)
- [Hexagonal Architecture - Alistair Cockburn](https://alistair.cockburn.us/hexagonal-architecture/)
- [Microsoft .NET Architecture Guides](https://learn.microsoft.com/dotnet/architecture/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Enterprise Architect](../04-enterprise-architect/README.md) | [Kit Root](../../README.md) | [Technical Lead](../06-technical-lead/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
