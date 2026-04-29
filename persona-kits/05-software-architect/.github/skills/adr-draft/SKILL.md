---
name: ADR Drafting
description: "Use when drafting Architecture Decision Records, evaluating alternatives, or documenting technical trade-offs. Triggers on "ADR", "architecture decision", "trade-off", "pick between", "why did we choose"."
---

# ADR Drafting

## When to invoke
- "Draft an ADR for choosing PostgreSQL over MongoDB."
- "Document our decision to adopt event-driven architecture."
- "Revisit ADR-007 - we need to supersede it."

## When to write an ADR

Write an ADR when a decision:
- Is hard or expensive to reverse.
- Affects more than one team.
- Constrains future choices (technology lock-in).
- Is likely to be questioned in 6 months.

Do not write an ADR for a local refactor or a reversible config tweak.

## Structure

```markdown
# ADR-NNN: <Decision title in imperative>

**Status**: proposed | accepted | superseded by ADR-NNN | deprecated
**Date**: YYYY-MM-DD
**Deciders**: <names>
**Context tags**: security, performance, cost

## Context
2-4 paragraphs. What is the forcing function? What constraints apply?

## Decision
One paragraph. "We will <decision>."

## Alternatives considered
- **Option A**: <summary>. Pros: ... Cons: ...
- **Option B**: <summary>. Pros: ... Cons: ...
- **Option C (chosen)**: <summary>. Pros: ... Cons: ...

## Consequences
### Positive
- ...
### Negative
- ...
### Neutral
- ...

## Follow-ups
- [ ] Update REQ-NNN
- [ ] Migrate <system>
- [ ] Revisit in Q<N>

## References
- Source 1
- Source 2
```

## Writing tips
- Write in the present tense ("We use X").
- Include at least 2 alternatives rejected.
- Name consequences you know will hurt - future you will thank you.
- Supersede, never delete. The history is the value.

## Anti-patterns
- ADRs written after the fact to justify a done deal.
- One ADR that bundles 5 unrelated decisions.
- No alternatives section (signals no trade-off analysis happened).
- Status stuck on "proposed" for months.

## Quality gate
Reject any ADR missing Context, Decision, Alternatives, and Consequences sections.
