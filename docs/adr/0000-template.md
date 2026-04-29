---
title: "ADR Template"
description: "Template for Architecture Decision Records"
status: "template"
---

# ADR-NNNN: <Short, decisive title>

> Replace `NNNN` with the next sequential number (e.g., `0007`).
> Replace this entire blockquote with a 1-line summary of the decision.

| Field | Value |
|-------|-------|
| Status | proposed \| accepted \| deprecated \| superseded |
| Date | YYYY-MM-DD |
| Authors | <Persona — Name> |
| Supersedes | ADR-NNNN \| N/A |

## Context

What is the issue we're seeing that motivates this decision? Reference the
business goal, the legacy constraint, or the stakeholder need.

Be specific. Cite REQ-IDs or `legacy/` programs when relevant.

## Decision

The change we are proposing or have agreed to make. Use one or two paragraphs.

State the decision in active voice: "We will adopt …", "We will not migrate …".

## Alternatives considered

List at least 2 alternatives. For each, explain why it was rejected.

| Alternative | Why rejected |
|-------------|--------------|
| Option A | … |
| Option B | … |

## Consequences

What becomes easier? What becomes harder? Any new risks?

- **Easier:** …
- **Harder:** …
- **Risks:** …
- **Mitigations:** …

## Related

- REQ-IDs: …
- ADRs: …
- Source files: …

## References

- Cite docs, RFCs, or research that informed the decision.
