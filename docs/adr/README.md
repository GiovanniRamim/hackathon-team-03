---
title: "ADR Index"
description: "Architecture Decision Records for this team's SIFAP 2.0 modernization"
author: "Tech Writer (your team)"
date: "2026-04-29"
version: "1.0.0"
status: "draft"
tags: ["adr", "architecture", "decisions"]
---

# Architecture Decision Records (ADRs)

> Why ADRs? Decisions made under time pressure are forgotten. Future-you will
> rediscover the same options and lose hours. ADRs are 5 minutes of writing now
> that save 50 minutes later.

## When to write an ADR

Write an ADR when:

- A decision will be hard to revisit later (>1 hour to undo).
- Two or more people on the team would land on different defaults.
- A decision affects more than one bounded context or persona.

Don't write an ADR for: variable names, formatter settings, library minor versions.

## Index

| ADR | Title | Status | Date |
|-----|-------|--------|------|
| 0000 | [Template](0000-template.md) | template | 2026-04-29 |

> Add new ADRs above as you create them, with status `proposed` first, then
> `accepted` after team agreement.

## How to add an ADR

1. Open issue using the [ADR issue template](../../.github/ISSUE_TEMPLATE/adr.yml)
2. Copy `0000-template.md` to `NNNN-your-title.md` (next sequential number)
3. Fill in every section
4. Open a PR; require at least 1 architect-persona review
5. Merge with status `accepted`
6. Update this index
