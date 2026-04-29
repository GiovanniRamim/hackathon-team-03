---
title: "ML/AI Engineer — GitHub Copilot Persona Kit"
description: "Integrating machine learning models, evaluation frameworks, and MLOps practices into the modernization workflow."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🤖 Ml Ai Engineer - GitHub Copilot Primitives Kit

> Training pipelines, MLOps, AI security

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/ml-engineer.agent.md` | Agent | Training pipelines, MLOps, AI security |
| `.github/prompts/train-pipeline.prompt.md` | Prompt | /train-pipeline |
| `.github/prompts/model-eval.prompt.md` | Prompt | /model-eval |
| `.github/instructions/ml-code.instructions.md` | Instructions | ML Conventions |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Offline evaluation is a hypothesis. Online evaluation is a fact. A/B test before you promote.
- Model cards > model weights. If you cannot explain what it was trained on, do not deploy it.
- RAG beats fine-tuning for factual recall. Fine-tune for style, retrieve for facts.
- Measure cost per inference, not just accuracy. A 2% accuracy gain at 10x cost is a regression.

## 📚 References
- [Model Cards - Google](https://modelcards.withgoogle.com/)
- [MLOps Principles](https://ml-ops.org/)
- [Anthropic's RAG Guide](https://docs.anthropic.com/claude/docs/retrieval-augmented-generation)
- [Azure AI Foundry](https://learn.microsoft.com/azure/ai-foundry/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Data Engineer](../15-data-engineer/README.md) | [Kit Root](../../README.md) | [Release Manager](../17-release-manager/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
