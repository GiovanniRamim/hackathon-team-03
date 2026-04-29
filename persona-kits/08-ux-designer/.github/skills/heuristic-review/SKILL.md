---
name: Heuristic Review
description: "Use when reviewing a UI for usability defects, running a Nielsen heuristic evaluation, or auditing accessibility. Triggers on "UX review", "heuristic", "usability", "Nielsen", "WCAG", "a11y", "accessibility audit"."
---

# Heuristic Review

## When to invoke
- "Review this dashboard screen for usability issues."
- "Run a heuristic evaluation on the onboarding flow."
- "Check if this form meets WCAG 2.2 AA."

## Nielsen heuristics (checklist)
1. **Visibility of system status**: user always knows what is happening.
2. **Match system and real world**: language matches the user's vocabulary.
3. **User control and freedom**: undo, redo, cancel are always available.
4. **Consistency and standards**: same pattern = same meaning.
5. **Error prevention**: confirmation on destructive actions.
6. **Recognition over recall**: options visible, not memorised.
7. **Flexibility and efficiency**: shortcuts for experts, clarity for novices.
8. **Aesthetic and minimalist design**: no visual noise.
9. **Help users recognise, diagnose, recover from errors**: plain language, actionable.
10. **Help and documentation**: discoverable, task-oriented.

## WCAG 2.2 AA quick checks
- [ ] Colour contrast 4.5:1 text, 3:1 UI components.
- [ ] All interactive elements reachable by keyboard.
- [ ] Focus visible on every element.
- [ ] Alt text on meaningful images; empty alt on decorative.
- [ ] Form fields have associated labels.
- [ ] No auto-playing audio/video over 3 seconds.
- [ ] Error messages identify the field and suggest a fix.
- [ ] Touch targets at least 24x24 CSS px.

## Review process
1. **Walk 3 primary flows** as a first-time user. Note every friction point.
2. **Score each defect**: severity 1 (cosmetic) - 4 (blocker), frequency 1-4.
3. **Cluster by heuristic**. Look for systemic issues, not one-offs.
4. **Recommend the smallest fix** that removes the defect.

## Output template
```markdown
## Heuristic Review - <Screen/Flow>

### Summary
- Screens reviewed: 7
- Defects found: 23 (4 blockers, 9 major, 10 minor)
- Heuristics most violated: #3 (user control), #5 (error prevention)

### Defects (top 10)
| ID | Severity | Heuristic | Location | Issue | Fix |
|----|----------|-----------|----------|-------|-----|
| 001 | 4 | H9 | Checkout error | "Err 500" shown to user | Replace with plain-language copy and retry action |
```

## Quality gate
Every defect must cite a heuristic or WCAG criterion. Subjective opinions do not belong in a review.
