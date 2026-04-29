---
title: "Developer — GitHub Copilot Persona Kit"
description: "Implementing features, writing clean code, and leveraging Copilot for accelerated development in the modernization sprint."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 💻 Developer - GitHub Copilot Primitives Kit

> Implementation, TDD, bug fixing (understand-reproduce-fix-verify)

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/implementer.agent.md` | Agent | Implementation, TDD, bug fixing (understand-reprod |
| `.github/prompts/implement.prompt.md` | Prompt | /implement |
| `.github/prompts/fix-bug.prompt.md` | Prompt | /fix-bug |
| `.github/prompts/tdd.prompt.md` | Prompt | /tdd |
| `.github/prompts/refactor.prompt.md` | Prompt | /refactor |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Write the test first when the design is clear, write the test after when you are exploring. Always commit with tests.
- A pull request should tell a story: one concern, <400 lines changed, reviewable in 20 minutes.
- Refactor in a separate commit from the behavior change. Mixing them hides bugs from the reviewer.
- Comments explain why, code explains what. If the code needs a 'what' comment, rename the variable.

## 📚 References
- [Clean Code - Robert C. Martin](https://www.oreilly.com/library/view/clean-code-a/9780136083238/)
- [Refactoring - Martin Fowler](https://refactoring.com/)
- [Test-Driven Development - Kent Beck](https://www.oreilly.com/library/view/test-driven-development/0321146530/)
- [GitHub Copilot Best Practices](https://docs.github.com/en/copilot)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [DBA](../21-dba/README.md) | [Kit Root](../../README.md) | [Tech Writer](../23-tech-writer/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
