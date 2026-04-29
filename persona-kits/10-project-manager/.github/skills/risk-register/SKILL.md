---
name: Risk Register
description: "Use when starting a project, running a risk review, or updating mitigations. Triggers on "risk", "risk register", "mitigation", "contingency", "what could go wrong"."
---

# Risk Register

## When to invoke
- "Build a risk register for this project."
- "Review and update our top 10 risks before the steering committee."
- "What are the blind spots in this delivery plan?"

## Risk scoring

**Risk score = Probability x Impact**

Use a 5x5 matrix (1 rare / trivial, 5 near-certain / catastrophic).

| Score | Zone | Action |
|---|---|---|
| 20-25 | Red | Stop work until mitigated. Escalate. |
| 10-19 | Amber | Active mitigation with weekly review. |
| 5-9 | Yellow | Monitor; revisit monthly. |
| 1-4 | Green | Accept; log only. |

## Risk categories to sweep
- **Technical**: unknown stack, integration, performance, scale.
- **Schedule**: dependencies, critical path, vendor delivery.
- **Resource**: key-person risk, hiring, contention.
- **Regulatory / compliance**: audit, data residency, certification window.
- **External**: supplier, customer, market, geopolitical.
- **Organisational**: reorg, budget freeze, stakeholder misalignment.
- **Security**: supply chain, vulnerability disclosure, incident.

## Steps
1. **Brainstorm wide** (category-by-category, don't self-edit). Target 30-50 raw risks.
2. **Deduplicate and sharpen**. Each risk must have: event, cause, impact.
3. **Score P x I**.
4. **Assign owner**. Every amber/red risk needs an accountable person.
5. **Define mitigation + contingency**. Mitigation reduces probability; contingency reduces impact if risk materialises.
6. **Set review cadence**: weekly for red, biweekly for amber.
7. **Trigger thresholds**: when does amber become red? Define in advance.

## Output template
```markdown
| ID | Risk event | Cause | Impact if it happens | P | I | Score | Zone | Owner | Mitigation | Contingency | Trigger | Review |
|----|-----------|-------|----------------------|---|---|-------|------|-------|------------|-------------|---------|--------|
| R01 | PostgreSQL migration fails | Unknown Adabas edge cases | 2-week delay, stakeholder confidence hit | 3 | 4 | 12 | Amber | Jordan | Run 2 full migration dry-runs | Rollback plan documented | >5% data mismatch | Weekly |
```

## Anti-patterns
- Risk wording like "the project might fail" (not actionable).
- No owner assigned.
- Mitigation = "be careful".
- Register written once at kick-off and never updated.
- Green risks padding the list to look thorough.

## Quality gate
Every amber/red risk must have owner, mitigation, contingency, trigger, and review cadence. No exceptions.
