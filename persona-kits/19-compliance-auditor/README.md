---
title: "Compliance Auditor — GitHub Copilot Persona Kit"
description: "Verifying regulatory controls, collecting audit evidence, and ensuring compliance throughout the modernization lifecycle."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.0.0"
status: "approved"
---

# 📜 Compliance Auditor - GitHub Copilot Primitives Kit

> Regulatory evidence, control validation, audit reporting

## 🔄 SDLC Phase
See analysis document

## 📦 Kit Contents

| File | Type | Purpose |
|------|------|---------|
| `.github/agents/compliance-auditor.agent.md` | Agent | Regulatory evidence, control validation, audit rep |
| `.github/prompts/audit-evidence.prompt.md` | Prompt | /audit-evidence |
| `.github/prompts/regulatory-map.prompt.md` | Prompt | /regulatory-map |

## ⚙️ Installation
```bash
cp -r .github/* /path/to/your-repo/.github/
[ -f hooks.json ] && cp hooks.json /path/to/your-repo/
[ -f mcp.json ] && cp mcp.json /path/to/your-repo/.vscode/
```

## 💡 Best Practices
- Evidence beats attestation. A screenshot in a folder is worth more than a signature on a form.
- Map controls to regulations once, reuse across audits. ISO 27001, SOC 2, and LGPD share 80% of controls.
- Audit trail integrity is non-negotiable. If logs can be edited, the audit is theater.
- Compliance and security are not the same. A compliant system can be insecure, an insecure system is never truly compliant.

## 📚 References
- [ISO/IEC 27001](https://www.iso.org/isoiec-27001-information-security.html)
- [SOC 2 Trust Services Criteria](https://www.aicpa-cima.com/resources/landing/system-and-organization-controls-soc-suite-of-services)
- [LGPD - Lei Geral de Proteção de Dados](https://www.gov.br/anpd/pt-br)
- [NIST 800-53](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final)

---

## 🧭 Navigation

| Previous | Home | Next |
|----------|------|------|
| ← [InfoSec Officer](../18-infosec-officer/README.md) | [Kit Root](../../README.md) | [SRE](../20-sre/README.md) → |

> **Author:** Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft
