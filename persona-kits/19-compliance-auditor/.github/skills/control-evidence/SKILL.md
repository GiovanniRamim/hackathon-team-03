---
name: Control Evidence Collection
description: "Use when collecting evidence for a compliance audit (SOC 2, ISO 27001, PCI-DSS, LGPD), responding to an auditor request, or building a continuous-compliance stream. Triggers on "audit", "evidence", "SOC 2", "ISO 27001", "PCI", "LGPD", "control", "compliance"."
---

# Control Evidence Collection

## When to invoke
- "Collect evidence for SOC 2 CC6.1 for last quarter."
- "Build an evidence package for the ISO 27001 renewal audit."
- "Automate continuous evidence collection for access review controls."

## Evidence hierarchy (strongest first)

1. **Automated export from source of truth** (e.g., IAM policy dump from AWS IAM, CI run log from GitHub Actions).
2. **Signed / timestamped ticket or PR** with approval trail.
3. **Monitoring alert showing the control fired**.
4. **Screenshot with timestamp and URL visible** (weak; use only as supplement).
5. **Verbal confirmation** (never acceptable alone).

## Per-control evidence template

```markdown
### Control: <SOC 2 CC6.1 | ISO A.9.2.5 | PCI 8.1.5>
**Intent**: <one sentence what the control requires>
**Period**: <date range>

**Population**: <e.g., all privileged access changes in Q3 2026 - 42 events>
**Sample size**: <e.g., 15 per AICPA guidance for population 26-50>
**Selection method**: <random sample with seed | 100% if small population>

**Evidence**:
1. <File/URL> - what it shows
2. <File/URL> - what it shows

**Result**: PASS | PASS with exceptions | FAIL
**Exceptions**: <list each with context and compensating control>
**Tester**: <name>
**Reviewer**: <name>
**Date tested**: <date>
```

## Common control areas and typical evidence

### Access control (SOC 2 CC6.1, ISO A.9)
- Automated IAM policy exports.
- Quarterly access review with signed attestation.
- Termination log correlated with HR system.

### Change management (SOC 2 CC8.1)
- PR list with required approvals enforced via branch protection.
- Deployment pipeline logs showing approval gates.
- Segregation of duties: author != approver != deployer.

### Incident response (SOC 2 CC7.4)
- Incident ticket trail with timeline.
- Post-incident review document.
- Evidence of detection (alert fire).
- Customer notification (where required).

### Vulnerability management (SOC 2 CC7.1, PCI 6.1)
- Scan output (dated, signed).
- Ticket tracking for every finding above severity threshold.
- Mean time to remediation report.

### Logging and monitoring (SOC 2 CC7.2)
- Log ingestion dashboards (retention period visible).
- Alert test records (monthly drill).
- Sample investigation that used logs.

## Steps for continuous compliance
1. **Map every control to a source of truth** (system, API, log).
2. **Automate daily/weekly collection**: cron + storage in evidence bucket with write-once retention.
3. **Version evidence**: hash + timestamp per file.
4. **Tag population and sample**: auditors will ask.
5. **Build exception log**: every failure documented with compensating control.

## Anti-patterns
- Collecting evidence 2 weeks before the audit (gaps in period coverage).
- Screenshots as sole evidence.
- No documented sample selection.
- Exceptions buried or hidden.
- Mutable evidence storage (auditor will ask about integrity).

## Quality gate
Every control must have: population defined, sample documented, evidence linked, tester and reviewer signed, exceptions listed.
