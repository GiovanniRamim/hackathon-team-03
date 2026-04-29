---
mode: ask
model: claude-sonnet-4-6
description: "Audit context engineering files for the repository"
---

# /audit-context

## Task
Audit the context engineering surface of the repository (AGENTS.md, CODEMAP.md, `.github/instructions/*`, `.github/prompts/*`, `.github/agents/*`) and return a prioritized fix list.

## Steps
1. List every file under `.github/instructions/`, `.github/prompts/`, `.github/agents/` and report line counts.
2. Check `applyTo:` scoping on every instruction file. Flag any file with `applyTo: "**"` or missing scope.
3. Read CODEMAP.md. Flag it as stale if it has not been updated in the last 30 days or references deleted files.
4. Check every prompt/agent frontmatter for: `description` present and informative (not "TBD"), `model` set, `mode` correct.
5. Grep for stale folder references (rename tracking) and broken relative links.
6. Summarize as a table: `File | Issue | Severity (High/Med/Low) | Fix`.

## Output
- A markdown table with one row per finding, ordered by severity.
- A short "Top 3 fixes" summary at the end.

## Quality Gate
- [ ] No false positives (every flagged item is actually an issue)
- [ ] Every High severity item has a concrete fix, not a vague suggestion
- [ ] CODEMAP.md freshness explicitly reported
- [ ] No suggestions to edit code, only context files
