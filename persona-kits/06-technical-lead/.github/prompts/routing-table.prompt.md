---
mode: ask
model: claude-sonnet-4-6
description: "Generate a task to model routing table"
---

# /routing-table

## Task
Produce a routing table that maps SDLC tasks to the correct Copilot model (Opus / Sonnet / Haiku) and explains the cost/quality tradeoff.

## Steps
1. Read TASKS.md (or the backlog) and categorize each task as: Discovery, Design, Implementation, Refactor, Review, Mechanical.
2. For each category, recommend a model using these defaults:
   - Discovery / ambiguous design: Opus
   - Implementation / code review: Sonnet
   - Mechanical edits / bulk renames / reformatting: Haiku
3. For each task, estimate token cost (rough order of magnitude) and justify the model choice in one sentence.
4. Flag any task where Sonnet can replace Opus with acceptable quality loss for cost savings.

## Output
Markdown table: `Task ID | Category | Recommended Model | Rationale | Est. Cost Tier`.

## Quality Gate
- [ ] Every task has a model and rationale
- [ ] At least one Haiku candidate identified (or noted as "none applicable")
- [ ] Cost tiers are consistent (same category rarely uses different tiers)
- [ ] Rationale references the task content, not generic language
