---
mode: ask
model: claude-sonnet-4-6
description: "Triage SAST / code scanning findings: true positive vs false positive, with remediation"
---

# /sast-triage

## Task
Triage a batch of SAST / GitHub code scanning findings and produce a prioritized action list.

## Steps
1. Group findings by rule + file to deduplicate.
2. For each group, open the cited source and judge: **True Positive**, **False Positive**, or **Needs Investigation**.
3. Assign severity using exploitability × impact (not just tool default).
4. Recommend remediation: code fix, config change, suppression with justification, or compensating control.
5. Output table: `Rule | File:Line | Verdict | Severity | Recommendation`.

## Quality Gate
- [ ] Every "False Positive" has a one-line justification
- [ ] Every suppression includes CWE + reason
- [ ] Top 5 items have concrete remediation steps
- [ ] CONSTITUTION.md constraints respected
