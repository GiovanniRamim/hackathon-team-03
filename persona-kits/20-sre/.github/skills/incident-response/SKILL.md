---
name: Incident Response
description: "Use when responding to a production incident, running a post-incident review, or designing an on-call runbook. Triggers on 'incident', 'outage', 'postmortem', 'runbook', 'page', 'sev1', 'sev2'."
---

# Incident Response

## When to invoke
- A page just fired.
- "Draft a postmortem for…"
- "Write a runbook for…"
- "Classify this incident severity."

## Severity matrix
| Sev | Impact | Response target |
|-----|--------|-----------------|
| Sev1 | Full outage or data loss risk | Page immediately, 15-min ack |
| Sev2 | Major feature degraded | Page during business hours |
| Sev3 | Minor feature or single-tenant issue | Ticket, next business day |

## Active incident workflow (Sev1/Sev2)
1. **Declare** the incident in the incident channel. One-sentence summary.
2. **Assign roles**: Incident Commander (IC), Communications Lead, Ops Lead. IC does not debug.
3. **Stabilize first, understand later**: roll back, failover, scale out, feature-flag off.
4. **Timestamped timeline** in the channel - every action logged.
5. **External comms** every 30 minutes on status page, even if "still investigating."
6. **Resolve** = customer impact ended. Not "we found the bug."
7. **Handoff** to postmortem owner before IC logs off.

## Postmortem (blameless)
Write within 5 business days. Required sections:
- **Summary** - one paragraph, customer-facing language
- **Timeline** - UTC, copy-paste from channel
- **Impact** - users affected, duration, revenue/SLO burn
- **Root cause** - "5 whys"; contributing factors
- **What went well** / **What went poorly**
- **Action items** - each with owner, due date, priority; no "improve monitoring" without specifics

## Runbook template
Every alert must link to a runbook with: symptom, dashboard links, likely causes, verification steps, mitigations (ranked by reversibility), escalation path.

## References
- [Google SRE Book - Managing Incidents](https://sre.google/sre-book/managing-incidents/)
- [PagerDuty Incident Response](https://response.pagerduty.com/)
- [Etsy - Blameless Postmortems](https://www.etsy.com/codeascraft/blameless-postmortems/)
