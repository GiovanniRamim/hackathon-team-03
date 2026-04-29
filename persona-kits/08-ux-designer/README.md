---
title: "UX Designer — GitHub Copilot Persona Kit"
description: "Designing intuitive user experiences through research-driven wireframes, design systems, and accessibility-first principles."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🎨 Ux Designer - GitHub Copilot Primitives Kit

> Accessible components, design system, WCAG 2.1 AA

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/ux-designer.agent.md` | Agent | Accessible components, design system, WCAG 2.1 AA |
| `.github/prompts/component-scaffold.prompt.md` | Prompt | /component-scaffold |
| `.github/prompts/accessibility-check.prompt.md` | Prompt | /accessibility-check |
| `.github/instructions/frontend-design.instructions.md` | Instructions | Frontend Design |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- WCAG 2.2 AA is the floor, not the ceiling. Color contrast 4.5:1, keyboard-only path, focus visible.
- Design tokens beat style props. Ship a token set once, every component inherits it.
- User testing with 5 users catches 85% of usability issues. Stop over-testing and start shipping.
- Every component needs a loading, empty, error, and success state. Missing states are silent bugs.

## 📚 References
- [WCAG 2.2 Guidelines](https://www.w3.org/WAI/WCAG22/quickref/)
- [Nielsen Norman Group - UX Research](https://www.nngroup.com/)
- [Material Design](https://m3.material.io/)
- [Microsoft Fluent UI](https://fluent2.microsoft.design/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Engineering Manager](../07-engineering-manager/README.md) | [Kit Root](../../README.md) | [Scrum Master](../09-scrum-master/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
