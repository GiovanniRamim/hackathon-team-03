---
title: "Helper Scripts"
description: "Bootstrap and quality-check scripts for the team repository"
author: "Paula Silva, Americas Software GBB, Microsoft"
date: "2026-04-29"
version: "1.0.0"
status: "approved"
tags: ["scripts", "bootstrap", "ci", "hackathon"]
---

# Scripts

| Script | What it does |
|--------|--------------|
| [`setup.sh`](setup.sh) | Bootstrap the team repo — verifies prerequisites, clones reference materials, initializes `.specs/` |
| [`check.sh`](check.sh) | Run all CI gates locally (backend tests, frontend lint/test, Terraform fmt) |

## Usage

```bash
chmod +x scripts/*.sh

# First-time setup
./scripts/setup.sh

# Before every push
./scripts/check.sh
```

## Notes

- `setup.sh` clones the [sifap-legacy](https://github.com/paulasilvatech/sifap-legacy) repo into `reference/` and creates the `legacy/` symlink. The `prototype/` and `infra/` symlinks are populated by facilitators at the start of Stages 3 and 4 respectively.
- The symlinks are gitignored — they're for your local convenience only.
- `check.sh` skips any check whose folder doesn't exist yet (so it works during early stages).
