---
mode: ask
model: claude-sonnet-4-6
description: "Synchronize SPECIFICATION.md with the current codebase"
---

# /spec-sync

## Task
Detect drift between SPECIFICATION.md and the implementation. Produce a sync report and a proposed spec update.

## Steps
1. Parse REQ-IDs from SPECIFICATION.md.
2. Grep the codebase for REQ-ID references (in comments, test names, commit messages).
3. For each REQ-ID: classify as Implemented (has code + test), Partial (code only), Orphaned (no code), Undocumented (code references an unknown REQ-ID).
4. For behavioral drift: pick 3 representative flows, compare spec vs. actual code path.
5. Propose additions/updates to SPECIFICATION.md for any Undocumented items found.

## Output
- Drift table: `REQ-ID | Status | Evidence (file:line) | Action`
- Proposed spec patch in a fenced diff block
- "Top 3 drifts by risk" summary

## Quality Gate
- [ ] Every REQ-ID in the spec is classified
- [ ] Every Undocumented finding has a proposed REQ-ID and EARS statement
- [ ] Evidence cites exact file:line
- [ ] The proposed patch compiles against the current SPECIFICATION.md structure
