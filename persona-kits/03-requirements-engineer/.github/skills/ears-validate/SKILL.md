---
name: EARS Validation
description: "Use when validating requirements against EARS notation patterns. Triggers on "EARS", "requirement review", "requirement quality", "shall statement", "REQ-ID"."
---

# EARS Validation

## When to invoke
- "Review these requirements for EARS compliance."
- "Is this requirement testable?"
- "Classify this requirement by EARS pattern."

## EARS patterns

| Pattern | Template |
|---|---|
| Ubiquitous | `The <system> shall <response>.` |
| Event-driven | `When <trigger>, the <system> shall <response>.` |
| State-driven | `While <state>, the <system> shall <response>.` |
| Optional | `Where <feature is included>, the <system> shall <response>.` |
| Unwanted | `If <unwanted condition>, then the <system> shall <mitigation>.` |
| Complex | `While <state>, when <trigger>, the <system> shall <response>.` |

## Validation checklist
- [ ] Exactly one pattern per requirement.
- [ ] Subject is unambiguous ("the system", not "it").
- [ ] Response is observable and testable.
- [ ] No hidden "and" that masks two requirements in one.
- [ ] No implementation details ("use Redis") - only behaviour.
- [ ] Has a REQ-ID in format `REQ-NNN`.
- [ ] Has at least one acceptance criterion.

## Common defects
| Defect | Example | Fix |
|---|---|---|
| Ambiguous | "The system should be fast." | "When a user submits a form, the system shall respond within 500ms." |
| Compound | "Login and send email." | Split into two requirements. |
| Untestable | "The system shall be user-friendly." | Replace with measurable UX metric. |
| Passive | "Login shall be supported." | "The system shall accept username/password authentication." |

## Output template
```markdown
### REQ-NNN (<pattern>)
<EARS statement>

**Acceptance criteria**
- <criterion 1>
- <criterion 2>

**Traces from**: US-NNN, ADR-NNN
**Priority**: P0 / P1 / P2
**Status**: proposed / approved / implemented / verified
```

## Quality gate
Reject any requirement missing REQ-ID, pattern classification, or acceptance criteria.
