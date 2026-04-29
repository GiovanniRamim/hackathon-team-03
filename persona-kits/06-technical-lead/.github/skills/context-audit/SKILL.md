---
name: Context Audit
description: "Use when a new engineer joins the team, when onboarding to an unfamiliar codebase, or when auditing whether the team has shared understanding. Triggers on "onboard", "context", "knowledge gap", "bus factor", "team understanding"."
---

# Context Audit

## When to invoke
- "New dev joins Monday - what must they know in week 1?"
- "Audit: does the team actually understand why we chose X?"
- "Our bus factor is 1 on the billing module. Fix it."

## Goal

Measure shared team understanding, surface single-person knowledge, create a week-1 runway for new joiners.

## Audit questions (ask each team member privately)
1. Can you draw the system architecture on a whiteboard in 5 minutes?
2. What are the 3 most important invariants this system must preserve?
3. Where is the riskiest code? Who knows it best?
4. What would you never change without senior review? Why?
5. Which parts do you personally avoid touching? Why?

If answers diverge significantly, you have a context gap.

## Outputs

### 1. Shared architecture map (1 page)
- Mermaid diagram of services and data flow
- List of external integrations and who owns them
- List of invariants (business rules that must hold)

### 2. Risk heat map
```
|  Module  | Criticality | Bus factor | Last refactor | Owner |
|----------|-------------|------------|----------------|-------|
| billing  | high        | 1 (Alex)   | 2y ago         | Alex  |
| auth     | high        | 3          | 6mo ago        | team  |
```
Any row with bus factor 1 on a high-criticality module is a P0 action.

### 3. Week-1 runbook for new joiner
- Day 1: read these 5 ADRs, run the stack locally.
- Day 2: pair with Alex on billing, ship a doc improvement.
- Day 3: shadow on-call rotation.
- Day 4: take a "starter" ticket with paired review.
- Day 5: retro with tech lead. What is still unclear?

## Anti-patterns
- "Onboarding is just our READMEs." (Insufficient - READMEs miss tacit knowledge.)
- Week-1 plan with no coding or system operation.
- Zero mention of invariants or failure modes.
- Knowledge only in senior engineers' heads with no documentation trail.

## Quality gate
A new engineer should be able to ship a low-risk change by end of week 1 with paired review. If not, the audit failed.
