---
title: "DBA — GitHub Copilot Persona Kit"
description: "Managing database performance, schema migrations, and data integrity during the Adabas-to-PostgreSQL transition."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🗄️ Dba - GitHub Copilot Primitives Kit

> Migrations, query optimization, SQL injection audit

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/dba.agent.md` | Agent | Migrations, query optimization, SQL injection audi |
| `.github/prompts/migration.prompt.md` | Prompt | /migration |
| `.github/prompts/query-audit.prompt.md` | Prompt | /query-audit |
| `.github/instructions/database.instructions.md` | Instructions | Database Conventions |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Indexes speed up reads and slow down writes. Every new index is a trade-off, measure both sides.
- Migrations must be backward compatible across at least two deploys (expand, then contract). Otherwise you cannot roll back.
- N+1 queries are the #1 performance bug in production. Log them, alert on them, fix them before they reach staging.
- Backups that have never been restored are not backups. Test recovery monthly.

## 📚 References
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Use the Index, Luke - Markus Winand](https://use-the-index-luke.com/)
- [High Performance MySQL / PostgreSQL - Schwartz et al.](https://www.oreilly.com/)
- [Azure Database for PostgreSQL Best Practices](https://learn.microsoft.com/azure/postgresql/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [SRE](../20-sre/README.md) | [Kit Root](../../README.md) | [Developer](../22-developer/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
