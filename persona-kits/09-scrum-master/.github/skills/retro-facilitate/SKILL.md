---
name: Retro Facilitation
description: "Use when designing or running a sprint retrospective, when the same retros keep producing no change, or when team morale needs attention. Triggers on "retro", "retrospective", "sprint review", "team health", "sailboat", "start stop continue"."
---

# Retro Facilitation

## When to invoke
- "Design a retro for our 8th sprint - people are bored."
- "Our retros produce action items nobody does. Fix it."
- "Facilitate a blameless retro after an outage."

## Core principles
- **Blameless**. Focus on systems, not people.
- **Time-boxed**. 90 minutes max. Longer = cognitive fatigue.
- **Action-oriented**. End with 2-3 actions with owners and dates. No orphan actions.
- **Varied format**. Same format every sprint = autopilot answers.

## Standard arc (90 min)
1. **Set the stage** (5 min): principles reminder, today's goal.
2. **Gather data** (20 min): choose a format below.
3. **Generate insight** (25 min): cluster themes, ask "why?" 5 times on the top cluster.
4. **Decide what to do** (25 min): vote on 1-3 actions. Assign owner + due date.
5. **Close** (10 min): recap, one-word check-out.

## Format rotation (pick one per retro)

### Sailboat
- **Wind**: what propels us forward?
- **Anchors**: what holds us back?
- **Rocks**: what risks are ahead?
- **Island**: what is our destination?

### Start / Stop / Continue
Simple, good for new teams. Gets stale after 3 uses.

### 4 Ls
- Liked, Learned, Lacked, Longed for.

### Timeline retro
Sketch the sprint on a timeline. Mark highs, lows, surprises. Good after an outage or a tough sprint.

### Glad / Sad / Mad
Emotional check-in. Use when morale is an issue.

### Speed car
- **Engine**: what gives us speed?
- **Parachute**: what slows us?
- **Cliff**: risks ahead?
- **Bridge**: improvements we can build?

## Anti-patterns
- Same format every sprint.
- Actions with no owner or due date.
- Actions that require someone outside the team (those are "requests", not actions).
- Retro becomes a complaint session with no synthesis.
- Manager dominates the conversation.

## Output template
```markdown
## Retro - Sprint <N> - <Date>

### Format
Sailboat

### Themes (top 3)
1. <Theme> - <why>
2. <Theme> - <why>
3. <Theme> - <why>

### Actions
- [ ] <Action> - Owner: <name> - Due: <date>
- [ ] <Action> - Owner: <name> - Due: <date>
- [ ] <Action> - Owner: <name> - Due: <date>

### Check-out
<one-word from each team member>
```

## Quality gate
If retro ends without 2-3 actions each with an owner and a due date, the retro failed.
