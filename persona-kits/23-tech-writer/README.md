---
title: "Tech Writer — GitHub Copilot Persona Kit"
description: "Creating clear documentation, API references, and tutorials that make the modernized system accessible to all stakeholders."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# ✍️ Tech Writer - GitHub Copilot Primitives Kit

> API docs, README, CODEMAP.md, changelog, drift detection

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/tech-writer.agent.md` | Agent | API docs, README, CODEMAP.md, changelog, drift det |
| `.github/prompts/generate-docs.prompt.md` | Prompt | /generate-docs |
| `.github/prompts/update-codemap.prompt.md` | Prompt | /update-codemap |
| `.github/prompts/doc-drift.prompt.md` | Prompt | /doc-drift |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Documentation is a feature. Ship it with the code, version it with the code, review it with the code.
- Write for the reader who has 30 seconds. Lead with the answer, follow with the context.
- Diagrams compress 1000 words of explanation into one image. Use Mermaid, version it, keep it fresh.
- Stale docs are worse than no docs. Build a drift check into CI, fix the drift the same sprint.

## 📚 References
- [Diátaxis Framework](https://diataxis.fr/)
- [Google Developer Documentation Style Guide](https://developers.google.com/style)
- [Write the Docs](https://www.writethedocs.org/)
- [Mermaid - Diagramming as Code](https://mermaid.js.org/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Developer](../22-developer/README.md) | [Kit Root](../../README.md) | [DevRel](../24-devrel/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
