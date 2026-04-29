---
name: Secure SDLC
description: "Use when embedding security into the SDLC, mapping to NIST SSDF, or defining security gates. Triggers on 'secure SDLC', 'SSDF', 'security gates', 'shift left', 'paved road', 'security checkpoints'."
---

# Secure SDLC

## When to invoke
- Standing up an AppSec program from scratch.
- Mapping current controls to NIST SSDF / ISO 27034 / PCI requirements.
- Defining which security checks must pass before release.

## Principles
- **Shift left, but also shift *smart*** - run fast checks early, expensive checks where value is highest.
- **Paved road beats policing** - give developers templates and defaults that are secure by construction; audit, don't gatekeep.
- **Every control has an owner** - if nobody owns the alert, nothing gets fixed.
- **Automate evidence** - audits should be a query, not a scramble.

## Gates by phase
| Phase | Control | Gate |
|-------|---------|------|
| Plan / design | Threat model on material changes | Design review sign-off |
| Code | Pre-commit hooks (secret scan, linter) | Blocks commit |
| PR | SAST, SCA, IaC scan | Required status check |
| Build | SBOM, container scan, signing | Fails build on Critical |
| Pre-prod | DAST on deployed env, config review | Release gate |
| Release | Signed artifact + provenance verified on deploy | Deploy-time policy |
| Run | Runtime monitoring, WAF, anomaly detection | 24/7 on-call |
| Respond | IR runbook, disclosure process | Tested quarterly |

## NIST SSDF mapping (condensed)
- **PO - Prepare the Organization**: security policy, roles, training, toolchain.
- **PS - Protect Software**: integrity of source and releases (signing, branch protection).
- **PW - Produce Well-Secured Software**: secure design, secure coding standards, review, test.
- **RV - Respond to Vulnerabilities**: disclosure process, triage SLA, patching.

Every control in your SDLC should trace to one of these.

## Paved road examples
- **Service template** with auth, logging, secrets management, and baseline SAST config preconfigured.
- **Pipeline template** with OIDC, signing, SBOM, and scans wired in.
- **Terraform module library** pre-hardened (encryption, private networking, least-privilege IAM).
- **Approved libraries list** with maintained versions.

Developers choosing the paved road get gates mostly for free. Off-road requires additional review.

## Anti-patterns
- Security bolted on at the end (pentest two weeks before launch).
- 100 "required" checks that everyone bypasses with exceptions.
- Findings without owners, SLAs, or expiries.
- One-size-fits-all controls - a prototype doesn't need PCI evidence.

## References
- [NIST SSDF (SP 800-218)](https://csrc.nist.gov/Projects/ssdf)
- [OWASP SAMM](https://owaspsamm.org/)
- [BSIMM](https://www.bsimm.com/)
- [Netflix - Paved Paths](https://netflixtechblog.com/how-we-build-code-at-netflix-c5d9bd727f15)
