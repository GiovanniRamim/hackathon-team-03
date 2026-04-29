---
title: "Product Owner — GitHub Copilot Persona Kit"
description: "Translating stakeholder needs into spec-driven requirements with EARS notation and Copilot-assisted backlog management."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 📋 Product Owner - GitHub Copilot Primitives Kit

> Spec writing, backlog refinement, and acceptance validation using EARS notation and the SDD workflow

## 🔄 SDLC Phase
Discovery → Specification → Acceptance

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/product-owner.agent.md` | Agent | Product Owner assistant (spec, backlog, acceptance) |
| `.github/prompts/spec.prompt.md` | Prompt | `/spec` - write SPECIFICATION.md section from user stories (EARS) |
| `.github/prompts/update-spec.prompt.md` | Prompt | `/update-spec` - update SPECIFICATION.md for changed features |
| `.github/prompts/acceptance-check.prompt.md` | Prompt | `/acceptance-check` - verify code matches acceptance criteria |
| `mcp.json` | MCP | Server manifest (GitHub + Azure DevOps work items) |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Write requirements in EARS notation so every statement is testable (ubiquitous / event-driven / state-driven / optional / unwanted / complex).
- Keep user stories tied to a single measurable outcome. If you cannot write a Given/When/Then, the story is not ready.
- Flag assumptions explicitly. An un-flagged assumption is a future production bug.
- Treat CONSTITUTION.md as the source of truth for non-negotiables (security, data residency, SLAs).

## 📚 References
- [EARS Notation - Alistair Mavin](https://alistairmavin.com/ears/)
- [Spec-Driven Development (Spec-Kit)](https://github.com/github/spec-kit)
- [User Story Mapping - Jeff Patton](https://www.jpattonassociates.com/user-story-mapping/)
- [GitHub Copilot for PMs](https://docs.github.com/en/copilot)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Persona Kits](../README.md) | [Kit Root](../../README.md) | [Business Manager](../02-business-manager/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
