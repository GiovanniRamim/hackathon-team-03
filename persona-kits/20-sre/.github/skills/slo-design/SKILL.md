---
name: SLO Design
description: "Use when defining Service Level Objectives, error budgets, or SLIs for a service. Triggers on 'SLO', 'SLI', 'error budget', 'availability target', 'latency target'."
---

# SLO Design

## When to invoke
- "Define SLOs for this service."
- "What's a reasonable error budget?"
- "Review our availability targets."

## Workflow
1. **Identify the user journey** - the actual thing a user does (login, search, checkout). Not "the API is up."
2. **Pick SLIs** (Service Level Indicators) that measure that journey:
   - **Availability** - successful requests / total requests
   - **Latency** - p95 / p99 response time
   - **Quality** - % of requests returning correct data
   - **Freshness** (for data pipelines) - time from event to queryable
3. **Set the SLO** - a target for the SLI over a window (e.g., "99.9% of checkout requests succeed over 28 days").
4. **Derive the error budget** - 100% − SLO target. 99.9% monthly = 43 min 50 sec of allowed downtime.
5. **Define burn-rate alerts**: page at 2% budget burn in 1h (fast-burn), warn at 10% in 6h (slow-burn). Not at threshold crossing.
6. **Document the policy**: what happens when the budget is exhausted (freeze releases, pair shipping with reliability work).

## Heuristics
- Start lower than you think (99.5% not 99.99%). Raise later if you can actually sustain it.
- More 9s cost exponentially more. 99.99% means 4.3 min/month - a single full deploy can burn it.
- SLOs measured internally ≠ what users experience. Measure from the edge.
- Never set SLO = 100%. You need budget to ship.

## Common mistakes
- Measuring uptime of the server instead of user-success.
- Averaging latency (use percentiles).
- Alerting on every SLO breach (alert on burn rate).
- SLO > actual customer expectation (wastes engineering).

## References
- [Google SRE Workbook - Implementing SLOs](https://sre.google/workbook/implementing-slos/)
- [Alex Hidalgo - Implementing Service Level Objectives](https://www.oreilly.com/library/view/implementing-service-level/9781492076803/)
