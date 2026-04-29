---
name: Capacity Model
description: "Use when forecasting team capacity, planning quarterly work, or deciding what to cut. Triggers on "capacity", "forecast", "roadmap", "can we ship it", "headcount", "planning"."
---

# Capacity Model

## When to invoke
- "Can we fit these 14 features into Q3?"
- "What does our real capacity look like after PTO and on-call?"
- "We need to cut scope. What stays?"

## Formula

**Available capacity** = headcount x working days x focus factor

Typical focus factors:
- Senior IC: 0.60 (meetings, reviews, support)
- Mid IC: 0.70
- Tech lead: 0.40 (leadership overhead)
- On-call rotation: -20% during on-call week
- New hire: 0.20 in month 1, 0.50 in month 2, full by month 3

Subtract: PTO, public holidays, known leaves, training.

## Steps
1. **Headcount snapshot**: list every person, role, start date, planned leave.
2. **Compute raw working days** per person for the planning window.
3. **Apply focus factors**.
4. **Subtract fixed overhead**: on-call, interviews (allow 1 day/week for teams in hiring mode), mandatory training.
5. **Compare demand to supply**: sum of t-shirt estimates vs. available capacity. Rule of thumb: plan to 80% of raw capacity; reserve 20% for unknowns.

## Example (10-person team, 13-week quarter)

```
10 people x 65 working days = 650 person-days
- 12 days PTO average per person = -120 days
- On-call overhead (2 people/week x 13 weeks x 1 day) = -26 days
- Hiring interviews (2 loads x 8 panellists x 2h) = -4 days
= 500 raw days
x 0.65 average focus factor = 325 focused person-days

Reserve 20% for unknowns = 260 planned person-days
```

## Output template
```markdown
## Q<N> Capacity Plan

| Metric | Value |
|---|---|
| Raw person-days | 650 |
| After leave/overhead | 500 |
| Focused (x0.65) | 325 |
| Planned (x0.80) | 260 |

**Demand**: 290 person-days estimated
**Gap**: -30 person-days -> cut or defer

### Cut list
1. Feature X (P2, 40d) -> defer to Q<N+1>
2. Tech debt initiative Y (80d) -> reduce to first phase only (30d)
```

## Anti-patterns
- Planning to 100% of raw capacity.
- Ignoring on-call burden.
- Counting a new hire at 100% from day 1.
- Pretending meetings do not happen.

## Quality gate
Every quarterly plan must show demand, supply, and gap - never only a feature list.
