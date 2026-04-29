---
title: "Team Documentation"
description: "ADRs, architecture notes, and team-curated documentation for SIFAP 2.0 modernization"
author: "Tech Writer (your team)"
date: "2026-04-29"
version: "1.0.0"
status: "draft"
tags: ["docs", "adr", "team"]
---

# Documentation

This folder is owned by the **Tech Writer** persona but contributed to by everyone. It holds team-curated documentation that accumulates during the hackathon.

## Structure

| Path | Purpose |
|------|---------|
| [`adr/`](adr/) | Architecture Decision Records (one file per decision) |
| [`glossary.md`](glossary.md) | Domain glossary — populated during Stage 1 (Archaeology) |
| [`api.md`](api.md) | OpenAPI overview and endpoint summary (auto-generated where possible) |
| [`runbook.md`](runbook.md) | How to run the system locally, in CI, and in Azure |

## Conventions

- One ADR per decision. Number them sequentially: `0001-title.md`, `0002-title.md`.
- Glossary terms in alphabetical order, with citations to the legacy program where the term originated.
- Every README in subfolders has YAML frontmatter and follows the project's markdown standard (see [`.github/copilot-instructions.md`](../.github/copilot-instructions.md)).

## Quick links

- [Team flow](../TEAM-FLOW.md)
- [Persona cards](../personas/)
- [Stage guides](../01-arqueologia/GUIDE.md)
