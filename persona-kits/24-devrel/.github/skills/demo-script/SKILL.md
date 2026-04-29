---
name: Demo Script
description: "Use when preparing a conference talk, customer demo, or workshop, and you need a reliable, reproducible script. Triggers on "demo", "talk", "workshop", "keynote", "prepare presentation", "live coding"."
---

# Demo Script

## When to invoke
- "Prepare a 20-minute demo for a conference talk."
- "Build a reproducible live-code demo that will not break."
- "Turn this feature into a customer workshop."

## Demo principles

1. **Tell a story**. Problem -> tension -> solution -> outcome.
2. **Never live-code from scratch**. Start from a prepared state; add the 1-2 lines that prove the point.
3. **Rehearse 3 times minimum**. Once alone, once recorded (watch it back), once in front of a human.
4. **Have a Plan B** for every network call, every auth, every reveal.
5. **Fail gracefully**. If the demo breaks, explain what was supposed to happen and move on. Do not debug live.
6. **Time yourself**. Each section should fit in a budget. Overrun is a sign of missing rehearsal.

## Story arc (20-minute talk)

| Minute | Section | Content |
|---|---|---|
| 0-2 | Hook | A concrete problem the audience has. One vivid example. |
| 2-4 | Tension | Why current solutions fall short. |
| 4-6 | Setup | Intro the tool/approach. What it is, in 3 sentences. |
| 6-14 | Demo | The meat. 2-3 short "beats", each with a clear takeaway. |
| 14-17 | Outcome | What just happened, why it matters, real metric. |
| 17-19 | Call to action | Where to start. Link. Concrete first step. |
| 19-20 | Q&A setup | Invite questions. Have 3 planted ones ready. |

## Demo beats (inside the demo section)

Each beat = one clear point. Structure:
1. **Before state** (15 s): what is it like without the solution?
2. **The move** (30-60 s): the one action that shows the magic.
3. **After state** (15 s): what changed? Name the metric.

Three beats is the sweet spot. Four is already long.

## Pre-flight checklist
- [ ] Laptop on AC power. Screensaver disabled.
- [ ] Notifications silenced (Do Not Disturb).
- [ ] Terminal font size increased (18pt+).
- [ ] Browser zoom at 125%+.
- [ ] Clean desktop background; no distracting wallpaper.
- [ ] Every demo resource pre-fetched (no live API calls that might fail).
- [ ] Offline fallback (recorded video) ready as Plan B.
- [ ] Timer visible (phone in front, presenter mode).
- [ ] Water within reach.

## Output template
```markdown
## Demo - <Title> - <Duration>

### Core message
One sentence the audience should repeat tomorrow.

### Setup (before start)
- Repo: <url> at tag `demo-v1`
- DB seeded with: <script>
- Browser tabs open: <list>
- Terminals: 2 (one for build, one for curl)

### Script

#### Beat 1: <Title> (3 min)
**Before**: <state>
**Say**: "<exact line>"
**Do**: <exact commands>
**After**: <state>
**Takeaway**: <one sentence>

#### Beat 2: ... etc

### Plan B
- If build fails -> show pre-recorded 30s clip.
- If network dies -> switch to localhost-only demo.
- If time runs short -> skip Beat 3, go to outcome.

### Rehearsal log
- 2026-04-25 solo - 22 min (cut 2 min from intro).
- 2026-04-26 recorded - 19 min, stumble at Beat 2 (memorise line).
- 2026-04-27 live to 2 colleagues - 20 min.
```

## Anti-patterns
- Live-coding from a blank file to prove a point.
- Reading slides verbatim.
- "Let me just fix this error real quick" (never works).
- No rehearsal; "I'll wing it".
- Demo depends on internet, no offline fallback.

## Quality gate
Never take a demo on stage that has not been rehearsed end-to-end at least 3 times.
