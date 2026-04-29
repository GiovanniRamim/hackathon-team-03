---
name: Documentation Style Lint
description: "Use when reviewing documentation for style, clarity, inclusive language, or Microsoft/Google style guide compliance. Triggers on "doc review", "style guide", "plain language", "inclusive language", "readability"."
---

# Documentation Style Lint

## When to invoke
- "Lint this README against our style guide."
- "Rewrite this API doc in plain language."
- "Check for exclusionary terms and jargon."

## Rules

### Voice and tone
- **Active voice**. "The system stores the file" not "The file is stored by the system."
- **Present tense**. "Returns a JSON response" not "Will return a JSON response."
- **Second person** ("you") for how-to; **third person** for reference.
- **Sentence-case headings** (not Title Case).

### Clarity
- One idea per sentence.
- Max 25 words per sentence as a rule of thumb.
- Max 5 sentences per paragraph.
- Avoid hedge words ("just", "simply", "easily") - they lie to the reader.
- No em-dashes. Use commas, parentheses, or colons.

### Inclusive language
Replace:
- "master/slave" -> "primary/replica" or "leader/follower"
- "whitelist/blacklist" -> "allowlist/blocklist"
- "guys" -> "folks", "everyone", "team"
- "crazy/insane" (as intensifier) -> "significant", "unusual"
- "dummy" (variable names) -> "example", "sample"
- "sanity check" -> "quick check", "verification"

### Structure
- **Start with outcome**, not background. Reader knows why to keep reading.
- **Tell them what they will learn** at the top.
- **Summarise at the end** for long documents.
- **Chunked headings** so reader can scan.

### Links
- Link text describes destination. Never "click here" or "this link".
- Absolute URLs to external sources; relative for internal.
- Check links at CI time.

### Code samples
- Every runnable snippet must be tested.
- Use realistic examples, not `foo/bar/baz`.
- Highlight placeholders clearly: `<YOUR-API-KEY>`.

### Numbers and units
- Numerals for 10+, words for 0-9 (Microsoft style).
- Metric units; include conversion if audience is mixed.
- Always specify unit: "100 MB" not "100".

## Review steps
1. **Read once as the intended reader**. Is it the right length? Right detail level?
2. **Run automated checks**: Vale, Alex.js, markdownlint.
3. **Apply style rules** section by section.
4. **Test every code sample**.
5. **Ask**: would a new hire on day 1 understand this?

## Output template
```markdown
## Style Review - <Doc>

### Summary
- Readability (Flesch-Kincaid grade): 11 (target: <=12)
- Passive voice: 8% (target: <10%)
- Inclusive language issues: 2
- Broken links: 0
- Untested code samples: 3

### Recommendations (top 10)
| ID | Location | Issue | Fix |
|----|----------|-------|-----|
| 01 | Install section | Passive voice | Rewrite in active voice |
| 02 | Troubleshooting | "guys" | Replace with "team" |
| 03 | API reference | "simply call" | Remove "simply" |
```

## Anti-patterns
- Review without running automated linters first.
- Style over substance.
- Rewriting the author's voice instead of polishing it.
- Ignoring accessibility (alt text, heading levels, link text).

## Quality gate
Every doc must pass automated linters before human review.
