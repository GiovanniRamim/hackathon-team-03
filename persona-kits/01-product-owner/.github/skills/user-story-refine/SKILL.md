---
name: User Story Refinement
description: "Use when refining backlog items, splitting epics, or validating INVEST criteria. Triggers on "refine story", "split epic", "acceptance criteria", "user story", "INVEST"."
---

# User Story Refinement

## When to invoke
- "This story is too big. Help me split it."
- "Turn this feature description into user stories with acceptance criteria."
- "Check if these stories are INVEST-compliant."

## Inputs you need
- Feature description or epic
- Persona / user type
- Business goal the feature serves
- Any known constraints (regulatory, technical, UX)

## Refinement steps
1. **Confirm the outcome**. Every story must answer: which persona, what outcome, why it matters.
2. **Apply INVEST** (Independent, Negotiable, Valuable, Estimable, Small, Testable) to each draft.
3. **Split vertically**, never horizontally. Prefer splits by: workflow step, data variation, CRUD operation, happy vs. edge path, business rule, acceptance criterion.
4. **Write acceptance criteria in Given/When/Then**. Include one happy path, one edge case, one failure case.
5. **Trace to REQ-ID**. Every story links to at least one requirement.

## Output template
```markdown
### US-NNN: <short title>
**As a** <persona>
**I want** <capability>
**So that** <business outcome>

**Acceptance criteria**
- Given <context>, when <action>, then <result>
- Given <edge>, when <action>, then <result>

**Traces to**: REQ-001, REQ-042
**Effort**: S / M / L
**Dependencies**: US-NNN (if any)
```

## Anti-patterns
- Stories worded as tasks ("Add a button").
- Acceptance criteria that describe UI instead of behaviour.
- Horizontal splits ("backend story" + "frontend story" for the same feature).
- Missing REQ-ID link.

## Quality gate
Reject any story that fails INVEST or lacks Given/When/Then acceptance criteria.
