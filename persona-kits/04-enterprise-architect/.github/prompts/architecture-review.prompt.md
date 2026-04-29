---
mode: ask
model: claude-opus-4-6
description: "Review a DESIGN.md against Well-Architected pillars"
---

# /architecture-review

## Task
Review DESIGN.md (or a proposed architecture change) against the Microsoft Azure Well-Architected pillars and produce a prioritized findings list.

## Steps
1. Load DESIGN.md and any relevant ADRs.
2. Score the design against each pillar with concrete evidence:
   - Reliability: SLO, redundancy, failure modes, retry policies
   - Security: identity, network, data, secrets, threat model
   - Cost: right-sizing, reserved capacity, idle resources
   - Operational Excellence: IaC, observability, runbooks
   - Performance Efficiency: scaling, caching, data access patterns
3. Classify each finding as: Critical (blocks go-live), Major (must fix before GA), Minor (backlog).
4. Reference the specific architecture decision or diagram that triggers the finding.
5. Propose a concrete remediation per finding, with effort estimate (S/M/L).

## Output
- Scorecard table: `Pillar | Score (1-5) | Top Finding | Remediation`
- Prioritized findings list grouped by severity
- Three alternative options for the single most critical finding

## Quality Gate
- [ ] Every pillar reviewed, none skipped
- [ ] Every finding cites a specific artifact (diagram, ADR, paragraph)
- [ ] Remediations are specific, not generic best-practice statements
- [ ] At least one cost-optimization finding identified (or noted as "already optimal")
