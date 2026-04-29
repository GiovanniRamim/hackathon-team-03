---
title: "DevOps Engineer — GitHub Copilot Persona Kit"
description: "Building and maintaining CI/CD pipelines, infrastructure as code, and deployment automation for cloud-native delivery."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🛠️ Devops Engineer - GitHub Copilot Primitives Kit

> CI/CD pipelines, IaC, monitoring, incident response

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/devops-engineer.agent.md` | Agent | CI/CD pipelines, IaC, monitoring, incident respons |
| `.github/prompts/pipeline.prompt.md` | Prompt | /pipeline |
| `.github/prompts/iac-module.prompt.md` | Prompt | /iac-module |
| `.github/prompts/incident-rca.prompt.md` | Prompt | /incident-rca |
| `.github/instructions/cicd.instructions.md` | Instructions | CI/CD Conventions |
| `.github/instructions/infrastructure.instructions.md` | Instructions | Infrastructure Conventions |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Everything as code: infrastructure, configuration, policy, and runbooks. If it is not in Git, it does not exist.
- A pipeline that takes more than 10 minutes is a pipeline developers work around. Parallelize or cut steps.
- Secrets live in a vault, not in .env files, not in CI variables, and definitely not in source code.
- Blue/green and canary are not the same. Pick based on rollback cost and state assumptions.

## 📚 References
- [Terraform Best Practices](https://developer.hashicorp.com/terraform/language/style)
- [GitHub Actions Hardening](https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [The DevOps Handbook - Gene Kim et al.](https://itrevolution.com/product/the-devops-handbook-second-edition/)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Project Manager](../10-project-manager/README.md) | [Kit Root](../../README.md) | [Platform Architect](../12-platform-architect/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
