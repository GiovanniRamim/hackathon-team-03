---
mode: ask
model: claude-opus-4-6
description: "Produce a STRIDE threat model for a feature or service"
---

# /threat-model

## Task
Produce a STRIDE threat model for the selected feature, service, or architectural change.

## Steps
1. Identify assets, trust boundaries, and data flows from `SPECIFICATION.md` and code.
2. Enumerate threats using STRIDE (Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation of privilege).
3. Map each threat to OWASP Top 10 / CWE IDs and rate Likelihood × Impact.
4. Propose mitigations ranked by cost vs. risk reduction.
5. Output a table: `Asset | Threat | STRIDE | CWE | Likelihood | Impact | Mitigation`.

## Quality Gate
- [ ] Every data flow crossing a trust boundary has at least one threat entry
- [ ] Every high-severity threat has a proposed mitigation
- [ ] Assumptions are explicit
- [ ] CONSTITUTION.md constraints respected
