---
name: Vulnerability Triage
description: "Use when triaging CVEs, prioritizing vulnerabilities, or setting remediation SLAs. Triggers on 'CVE', 'vulnerability triage', 'CVSS', 'EPSS', 'SLA for patching', 'reachability'."
---

# Vulnerability Triage

## When to invoke
- Scanner (SCA, SAST, container scan) dropped a batch of findings.
- A newly disclosed CVE affects a dependency we use.
- Defining or auditing the org's patching SLA.

## Prioritization model
Don't triage by CVSS alone. Combine three signals:

1. **Severity** - CVSS v3.1/v4 base score (intrinsic badness).
2. **Exploitability** - EPSS score (probability of exploitation in the next 30 days) + presence in CISA KEV (known exploited).
3. **Reachability** - is the vulnerable code actually executed? Is the exposed interface network-reachable? Is authentication required?

**High priority** = High/Critical CVSS **AND** (KEV OR EPSS > 0.1) **AND** reachable.

A Critical CVSS in a dev-only dependency not on the runtime path is lower priority than a Medium CVSS in an internet-facing service.

## SLA template
| Severity | Internet-facing | Internal | Dev-only |
|----------|-----------------|----------|----------|
| Critical / KEV | 7 days | 14 days | 30 days |
| High | 30 days | 60 days | 90 days |
| Medium | 90 days | 90 days | Next release |
| Low | Next release | Next release | Backlog |

Clock starts at **disclosure** (or vendor patch), not at scan detection.

## Workflow
1. **Dedupe & group** - one vulnerability in a transitive dep may show 50 times; fix once.
2. **Verify reachability** - call-graph tools (Snyk Reachability, Semgrep, Endor) or manual inspection of the vulnerable function.
3. **Fix hierarchy**:
   a. Upgrade to a patched version (preferred).
   b. Apply vendor workaround / config mitigation.
   c. Compensating control (WAF rule, network segmentation).
   d. Accept with expiry - documented, owned, time-boxed (≤ 90 days, re-review).
4. **Close the loop** - scanner must re-verify; don't trust "fixed in PR #123" without a clean scan.
5. **Track exceptions** in a single registry with owner, justification, expiry, compensating control.

## Anti-patterns
- Treating every Critical as page-worthy - alert fatigue, real issues drown.
- No reachability analysis - you'll chase phantom risks and miss real ones.
- Exception with no expiry - becomes permanent.
- "Fixed" means "PR merged" instead of "confirmed by rescan in the deployed environment."

## References
- [FIRST - EPSS](https://www.first.org/epss/)
- [CISA KEV Catalog](https://www.cisa.gov/known-exploited-vulnerabilities-catalog)
- [CVSS v4.0](https://www.first.org/cvss/v4-0/)
- [SSVC - Stakeholder-Specific Vulnerability Categorization](https://www.cisa.gov/stakeholder-specific-vulnerability-categorization-ssvc)
