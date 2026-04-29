---
title: "Platform Architect — GitHub Copilot Persona Kit"
description: "Designing the internal developer platform that accelerates team delivery with golden paths and self-service infrastructure."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# ☁️ Platform Architect - GitHub Copilot Primitives Kit

> Golden paths, platform governance, developer experience

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/platform-architect.agent.md` | Agent | Golden paths, platform governance, developer exper |
| `.github/prompts/golden-path.prompt.md` | Prompt | /golden-path |
| `.github/prompts/platform-metrics.prompt.md` | Prompt | /platform-metrics |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- The golden path is a service. Build it, version it, deprecate it properly like any other API.
- Developer experience is a product. Measure time-to-first-deploy like you measure page load time.
- Abstract the cloud, not the value. Teams should not write Terraform to get a Postgres instance, but they should choose their schema.
- Platform success is measured in teams adopting it voluntarily, not in teams forced to.

## 📚 References
- [Team Topologies - Skelton & Pais](https://teamtopologies.com/)
- [Platform Engineering - Internal Developer Platform](https://internaldeveloperplatform.org/)
- [Backstage (Spotify)](https://backstage.io/)
- [CNCF Platform Whitepaper](https://tag-app-delivery.cncf.io/whitepapers/platforms/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [DevOps Engineer](../11-devops-engineer/README.md) | [Kit Root](../../README.md) | [QA Engineer](../13-qa-engineer/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
