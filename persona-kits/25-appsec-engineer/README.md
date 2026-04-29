---
title: "AppSec Engineer — GitHub Copilot Persona Kit"
description: "Embedding security into the SDLC through threat modeling, secure code review, SAST/DAST, and OWASP compliance."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 🛡️ AppSec Engineer - GitHub Copilot Primitives Kit

> Threat modeling, secure code review, SAST triage, OWASP Top 10, and secure-SDLC enablement

## 🔄 SDLC Phase
Design → Implementation → Review → Release

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/appsec-engineer.agent.md` | Agent | AppSec / Secure Coding Specialist (read-only by default) |
| `.github/prompts/threat-model.prompt.md` | Prompt | `/threat-model` - STRIDE threat model for a feature or service |
| `.github/prompts/secure-code-review.prompt.md` | Prompt | `/secure-code-review` - OWASP-focused code review |
| `.github/prompts/sast-triage.prompt.md` | Prompt | `/sast-triage` - triage SAST findings (TP / FP / investigate) |
| `.github/instructions/secure-coding.instructions.md` | Instructions | `applyTo`-scoped secure-coding rules for source files |
| `mcp.json` | MCP | GitHub Advanced Security + Semgrep + Microsoft Defender |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Shift left, but not shift only. Scan at commit, at build, at deploy, and at runtime.
- SAST finds patterns, DAST finds behavior, IAST finds both. Pick one as minimum, aim for all three.
- Dependency vulnerabilities outnumber your own. Treat SBOM as a product artifact, not a compliance checkbox.
- Security reviews that are not repeatable are not reviews, they are opinions. Automate the boring parts.

## 📚 References
- [OWASP Application Security Verification Standard (ASVS)](https://owasp.org/www-project-application-security-verification-standard/)
- [OWASP SAMM](https://owasp.org/www-project-samm/)
- [NIST Secure Software Development Framework](https://csrc.nist.gov/Projects/ssdf)
- [Microsoft SDL Practices](https://www.microsoft.com/sdl/practices)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [DevRel](../24-devrel/README.md) | [Kit Root](../../README.md) | [Plugins](../../plugins/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
