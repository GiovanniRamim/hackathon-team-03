---
name: UAT Plan
description: "Use when designing a User Acceptance Test plan, defining exit criteria, or coordinating business sign-off. Triggers on "UAT", "user acceptance", "business validation", "sign-off", "go/no-go"."
---

# UAT Plan

## When to invoke
- "Design a UAT plan for the release."
- "What are sensible exit criteria for UAT?"
- "Create a UAT schedule with business users."

## UAT vs. other testing

| Testing | Who | Goal |
|---|---|---|
| Unit / integration | Engineers | Code correctness |
| System / E2E | QA | System behaviour |
| UAT | Business users | "Does this solve the real business problem?" |

UAT validates **fit for purpose**, not defects. Defects found here signal failure in earlier gates.

## Steps
1. **Identify business scenarios** (not test cases). Group by workflow, role, frequency. Aim for 20-40 scenarios for a medium release.
2. **Select testers**: real end users, not proxies. Cover each role in scope.
3. **Prepare environment**: UAT-specific env with sanitised prod-like data. Reset between sessions.
4. **Write scenarios in business language**. No IDs, no SQL, no screenshots from test tooling.
5. **Schedule**: 2-4 hour sessions, morning is better, 3-5 scenarios per session per tester.
6. **Capture results**: PASS / PASS with notes / FAIL / BLOCKED. Every FAIL needs a reproduction trace.
7. **Daily triage**: defects classified P1/P2/P3 within 24h.
8. **Exit gate**: meet defined criteria before signing off.

## Exit criteria (example)
- 100% of P0 and P1 scenarios executed.
- 0 open P1 defects.
- P2 defects with mitigation or deferred with business approval.
- Business sponsor signs the UAT report.

## Output template
```markdown
## UAT Plan - <Release>

### Scope
In: <modules>
Out: <modules>

### Scenarios
| ID | Role | Scenario | Priority | Expected outcome | Tester | Result | Notes |
|----|------|----------|----------|------------------|--------|--------|-------|
| UAT-01 | Tax Agent | Assess a taxpayer with penalty | P0 | Penalty calculated per rule R14 | Maria | PASS | |
| UAT-02 | Tax Agent | Reverse an assessment | P0 | Original status restored, audit trail | Maria | FAIL | Audit trail missing user id |

### Schedule
| Date | Session | Testers | Scenarios |
|------|---------|---------|-----------|
| 2026-04-28 AM | 1 | Maria, Joao | UAT-01-05 |

### Exit criteria
- [ ] 100% P0 executed
- [ ] 0 open P1
- [ ] Business sign-off

### Sign-off
<business sponsor>, <date>
```

## Anti-patterns
- Engineers playing UAT tester.
- Scenarios written in QA case format (steps/expected/actual in technical language).
- No environment reset - tests contaminate each other.
- UAT used to discover functional defects (means earlier testing failed).

## Quality gate
Reject UAT kickoff if scenarios are not in business language or testers are not real end users.
