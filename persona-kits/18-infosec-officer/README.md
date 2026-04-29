---
title: "InfoSec Officer — GitHub Copilot Persona Kit"
description: "Establishing security policies, threat models, and governance frameworks that protect the modernized system."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🔐 Infosec Officer - GitHub Copilot Primitives Kit

> CONSTITUTION enforcement, OWASP, vulnerability triage (READ-ONLY)

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/security-reviewer.agent.md` | Agent | CONSTITUTION enforcement, OWASP, vulnerability tri |
| `.github/prompts/security-review.prompt.md` | Prompt | /security-review |
| `.github/prompts/vuln-triage.prompt.md` | Prompt | /vuln-triage |
| `.github/prompts/compliance-check.prompt.md` | Prompt | /compliance-check |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Threat model at design time. Threat modeling after deploy is called a penetration test.
- Defense in depth assumes every layer will eventually fail. Plan for the failure, not the prevention.
- OWASP Top 10 is the floor. If you have not mitigated injection, broken auth, and SSRF, stop reading and fix that first.
- Least privilege is a daily practice, not a one-time audit. Permissions grow silently.

## 📚 References
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [Microsoft SDL](https://www.microsoft.com/sdl)
- [STRIDE Threat Model](https://learn.microsoft.com/azure/security/develop/threat-modeling-tool-threats)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [Release Manager](../17-release-manager/README.md) | [Kit Root](../../README.md) | [Compliance Auditor](../19-compliance-auditor/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
