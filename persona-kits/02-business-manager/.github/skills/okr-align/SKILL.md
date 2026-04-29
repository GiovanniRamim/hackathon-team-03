---
name: OKR Alignment
description: "Use when drafting or reviewing OKRs, aligning team work to business outcomes, or translating goals into measurable results. Triggers on "OKR", "key result", "business goal", "outcome", "quarterly planning"."
---

# OKR Alignment

## When to invoke
- "Help me draft OKRs for Q2."
- "Are these key results measurable?"
- "Align this sprint backlog to our business OKRs."

## Framework

**Objective**: qualitative, inspirational, time-bounded.
**Key Result**: quantitative, measurable, outcome-based (not task-based).

Target: 3-5 objectives, 3-5 key results per objective.

## Steps
1. **Start from the business goal**, not the team backlog.
2. **Write the Objective** in one sentence. Test: would a stranger understand the ambition?
3. **Draft Key Results** that are leading indicators, not lagging activity counts.
4. **Check measurability**: every KR must have a number, a baseline, and a target.
5. **Trace work items**: each sprint item maps to exactly one KR.
6. **Set confidence (0.0-1.0)** weekly; below 0.3 is a red flag.

## Good vs. bad KRs
| Good | Bad |
|---|---|
| Reduce mean deployment lead time from 4h to 30min | Implement CI/CD pipeline |
| Grow active monthly users from 12k to 30k | Launch new mobile app |
| Raise CSAT from 72% to 85% | Run customer interviews |

## Output template
```markdown
## Q<N> OKRs - <Team>

### O1: <Objective statement>
- KR1: <metric> from <baseline> to <target> by <date>
- KR2: <metric> from <baseline> to <target> by <date>
- KR3: <metric> from <baseline> to <target> by <date>
Confidence: 0.7
Owner: <name>
```

## Anti-patterns
- KRs that measure activity ("number of meetings held") instead of outcome.
- Binary KRs ("Launch X") with no measurable quality threshold.
- More than 5 objectives per team (focus loss).
- OKRs never reviewed after the kickoff.

## Quality gate
Reject any KR that cannot be answered with a number.
