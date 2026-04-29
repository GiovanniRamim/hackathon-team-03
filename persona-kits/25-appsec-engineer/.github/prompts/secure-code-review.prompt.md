---
mode: ask
model: claude-opus-4-6
description: "Security-focused code review against OWASP Top 10 and project secure-coding rules"
---

# /secure-code-review

## Task
Review the selected diff or files for security defects. Focus on OWASP Top 10 (2021) and any rules in `.github/instructions/secure-coding.instructions.md`.

## Steps
1. Read the diff / selection plus touched files for full context.
2. Check authentication, authorization, input validation, output encoding, cryptography, secrets handling, dependency use, and error handling.
3. For each finding report: `File:Line | Severity | OWASP/CWE | Issue | Suggested fix`.
4. Note positive patterns worth reusing.
5. Summarize must-fix vs. nice-to-fix.

## Quality Gate
- [ ] Every Critical/High finding cites a CWE or OWASP category
- [ ] Suggested fix is concrete (code snippet or library reference)
- [ ] No secret values are echoed back - redact
- [ ] CONSTITUTION.md constraints respected
