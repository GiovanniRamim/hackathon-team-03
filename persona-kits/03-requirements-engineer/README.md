---
title: "Requirements Engineer — GitHub Copilot Persona Kit"
description: "Crafting precise, testable requirements using EARS notation and ensuring full traceability across the SDD pipeline."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 📝 Requirements Engineer - GitHub Copilot Primitives Kit

> EARS notation, spec drift detection, contradiction analysis

## 🔄 SDLC Phase
Requirements, Specification

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/requirements-engineer.agent.md` | Agent | Requirements analysis |
| `.github/prompts/spec-sync.prompt.md` | Prompt | /spec-sync |
| `.github/prompts/contradiction-check.prompt.md` | Prompt | /contradiction-check |
| `.github/prompts/ears-convert.prompt.md` | Prompt | /ears-convert |
| `.github/instructions/requirements.instructions.md` | Instructions | Req doc conventions |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Use EARS patterns exclusively. 'The system shall be fast' is not a requirement, 'WHEN a user submits a form THE system SHALL respond within 300ms' is.
- Every REQ-ID must be unique, immutable, and traceable to at least one test and one task.
- Contradiction detection beats new requirements. Run a contradiction pass before accepting new specs.
- Ambiguity is the enemy. Words like 'appropriate', 'reasonable', 'user-friendly' must be quantified or removed.

## 📚 References
- [EARS Notation - Alistair Mavin](https://alistairmavin.com/ears/)
- [IEEE 29148 - Requirements Engineering](https://www.iso.org/standard/72089.html)
- [ISO/IEC 25010 - Quality Model](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010)
- [Writing Good Requirements - INCOSE](https://www.incose.org/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Business Manager](../02-business-manager/README.md) | [Kit Root](../../README.md) | [Enterprise Architect](../04-enterprise-architect/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
