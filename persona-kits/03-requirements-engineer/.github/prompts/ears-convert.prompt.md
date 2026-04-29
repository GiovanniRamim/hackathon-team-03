---
mode: ask
model: claude-sonnet-4-6
description: "Convert informal requirements to EARS notation"
---

# /ears-convert

## Task
Convert a list of informal requirements into EARS notation, classify each by pattern, and flag anything that cannot be expressed in EARS.

## Steps
1. For each input statement, identify the pattern: Ubiquitous, Event-driven, State-driven, Optional, Unwanted, or Complex.
2. Rewrite the statement using the correct EARS template:
   - Ubiquitous: `The system shall ...`
   - Event-driven: `WHEN <trigger> the system shall ...`
   - State-driven: `WHILE <state> the system shall ...`
   - Optional: `WHERE <feature> is included the system shall ...`
   - Unwanted: `IF <undesired> THEN the system shall ...`
   - Complex: combine the above with `AND / OR` inside the trigger clause.
3. Assign a REQ-ID in the format `REQ-<DOMAIN>-NNN`.
4. If a requirement cannot be made testable (vague, contradictory, or metric-free), flag it as `NEEDS-CLARIFICATION` with the specific ambiguity.

## Output
Markdown table: `REQ-ID | Pattern | EARS Statement | Original | Notes`.

## Quality Gate
- [ ] 100% of input statements processed
- [ ] No EARS statement contains words like "appropriate", "reasonable", "fast" without a metric
- [ ] Every REQ-ID is unique
- [ ] `NEEDS-CLARIFICATION` items have a specific question attached
