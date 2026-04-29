---
mode: ask
model: claude-sonnet-4-6
description: "Create IMPLEMENTATION_PLAN.md with phased tasks"
---

# /impl-plan

## Task
Produce IMPLEMENTATION_PLAN.md that sequences tasks into phases, marks parallelizable tasks, selects a model per task, and defines exit criteria.

## Steps
1. Read SPECIFICATION.md, DESIGN.md, and TASKS.md.
2. Group tasks into phases based on dependency order (foundation → features → hardening).
3. Within each phase, mark tasks as `[P]` parallelizable if they touch disjoint files and have no runtime dependency.
4. Assign a model per task: Opus (architectural), Sonnet (implementation), Haiku (mechanical).
5. Define a Definition of Done per phase: tests passing, docs updated, code review complete.

## Output
A file IMPLEMENTATION_PLAN.md with:
- Phase headings, each with goal, duration estimate, exit criteria
- Task table per phase: `Task ID | Title | [P] | Model | Est. Effort | Traces To (REQ-ID)`
- Global risks section with mitigations

## Quality Gate
- [ ] Every task traces to at least one REQ-ID
- [ ] `[P]` tasks actually touch independent files (verified by grep)
- [ ] Phase exit criteria are measurable
- [ ] No task is larger than 1 day of effort without a breakdown
