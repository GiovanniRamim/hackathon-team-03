---
title: "Data Engineer — GitHub Copilot Persona Kit"
description: "Building reliable data pipelines, ETL workflows, and migration strategies from legacy to modern data platforms."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 📊 Data Engineer - GitHub Copilot Primitives Kit

> Data pipelines, quality testing, schema management

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/data-engineer.agent.md` | Agent | Data pipelines, quality testing, schema management |
| `.github/prompts/data-pipeline.prompt.md` | Prompt | /data-pipeline |
| `.github/prompts/data-quality.prompt.md` | Prompt | /data-quality |
| `.github/instructions/data-pipelines.instructions.md` | Instructions | Data Conventions |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Schema on write beats schema on read for analytical workloads. Pay the cost at ingest, not at query.
- Data contracts are SLAs between producers and consumers. Break one and you break every downstream dashboard.
- Idempotent pipelines beat exactly-once guarantees. Rerun-safe is the only safe kind.
- Data quality is a Day-0 feature, not a Day-90 cleanup project. Build validation into the pipeline, not around it.

## 📚 References
- [Designing Data-Intensive Applications - Martin Kleppmann](https://dataintensive.net/)
- [dbt - Data Build Tool](https://www.getdbt.com/)
- [Great Expectations - Data Validation](https://greatexpectations.io/)
- [Azure Data Factory Patterns](https://learn.microsoft.com/azure/data-factory/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [UAT Analyst](../14-uat-analyst/README.md) | [Kit Root](../../README.md) | [ML/AI Engineer](../16-ml-ai-engineer/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
