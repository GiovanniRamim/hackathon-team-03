---
name: Threat Modeling
description: "Use when designing a new system, onboarding a feature to security review, or running STRIDE. Triggers on 'threat model', 'STRIDE', 'attack tree', 'trust boundary', 'data flow diagram', 'DFD'."
---

# Threat Modeling

## When to invoke
- Before significant architecture changes or new external integrations.
- When a feature crosses a trust boundary (new auth path, new tenant model, new data export).
- Before a pentest, to scope it.

## The four questions (Shostack)
1. **What are we working on?** - draw a DFD with trust boundaries.
2. **What can go wrong?** - apply STRIDE per element.
3. **What are we going to do about it?** - mitigate, accept, transfer, eliminate.
4. **Did we do a good job?** - review with engineering + security.

## STRIDE cheat sheet
| Letter | Threat | Property violated | Typical mitigations |
|--------|--------|-------------------|---------------------|
| S | Spoofing | Authentication | MFA, mTLS, signed tokens |
| T | Tampering | Integrity | Input validation, signatures, WORM storage |
| R | Repudiation | Non-repudiation | Audit log, signed events |
| I | Information disclosure | Confidentiality | Encryption, least privilege, redaction |
| D | Denial of service | Availability | Rate limits, quotas, autoscale, circuit breakers |
| E | Elevation of privilege | Authorization | AuthZ checks per call, tenant isolation |

## Workflow
1. **Draw the DFD** - processes (circles), data stores (cylinders), external entities (rectangles), data flows (arrows). Mark **trust boundaries** (auth, network, tenant, OS).
2. **Enumerate per element** - each process/store gets a STRIDE pass. Note the *asset* protected and the *attacker* profile (external, tenant, insider, supply chain).
3. **Rate & prioritize** - DREAD or simple H/M/L (likelihood × impact). Top N items become tickets with owners.
4. **Decide response** per threat: Mitigate / Accept (with expiry) / Transfer / Eliminate.
5. **Record assumptions** - "we assume the cloud provider's KMS is trusted." Assumptions that change invalidate the model.
6. **Reassess** when the DFD changes: new dependency, new data class, new user role, new environment.

## Anti-patterns
- Threat model lives in someone's head, never shared.
- Only run once, at the start of the project.
- No owner on mitigations - tickets rot.
- Drawing the architecture diagram instead of the *data flow* diagram - missing the trust boundaries.

## References
- [Adam Shostack - Threat Modeling: Designing for Security](https://shostack.org/books/threat-modeling-book)
- [Microsoft - Threat Modeling](https://learn.microsoft.com/en-us/azure/security/develop/threat-modeling-tool)
- [OWASP - Threat Modeling Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html)
