---
name: Release Notes Generation
description: "Use when preparing release notes, classifying changes, or drafting upgrade/breaking-change communications. Triggers on "release notes", "changelog", "version", "ship", "customer-facing communication"."
---

# Release Notes Generation

## When to invoke
- "Draft release notes for v2.4.0 from the PR list."
- "Classify these 42 merged PRs by change type."
- "Write customer-facing upgrade notes for this breaking change."

## Audience matters

| Audience | Tone | Detail |
|---|---|---|
| End users | Plain language, benefits-first | "What's new for me?" |
| Integrators / API consumers | Precise, breaking-change callout | Migration code |
| Ops / SRE | Operational impact, rollback plan | Config changes |
| Internal teams | Technical, links to PRs | Everything |

Write one note per audience if the release is significant. A single note for everyone is a compromise nobody loves.

## Classification scheme (keep-a-changelog style)
- **Added**: new user-facing capability
- **Changed**: behaviour change that is not breaking
- **Deprecated**: soon-to-be-removed
- **Removed**: taken out
- **Fixed**: bug fix
- **Security**: vulnerability fix (mandatory callout)
- **Breaking**: requires action from consumer

## Steps
1. **Gather inputs**: merged PR list, linked issues, traces to REQ-IDs.
2. **Bucket** every PR into exactly one category. Refuse "chore" or "misc".
3. **Write user-facing descriptions** - not PR titles. Rewrite in outcome language.
4. **Callout breaking changes** at the top. Include migration code.
5. **Highlight security fixes** with CVSS if applicable.
6. **Include upgrade path** and rollback instructions.
7. **Version**: SemVer strictly. Breaking = major, feature = minor, fix = patch.

## Output template
```markdown
# Release v2.4.0 - 2026-04-28

## BREAKING CHANGES
- API endpoint `/users/{id}/roles` now returns paginated results.
  **Migration**:
  ```diff
  - const roles = await api.getUserRoles(id);
  + const { data: roles } = await api.getUserRoles(id, { page: 1 });
  ```

## Security
- [CVE-2026-0123] Fix authentication bypass in OAuth callback. **Upgrade immediately.**

## Added
- Multi-factor authentication via WebAuthn.
- Export tax assessments to CSV.

## Fixed
- Penalty interest calculation off-by-one for leap years.
- CSV exports now include BOM for Excel compatibility.

## Upgrade path
1. Back up database (full backup).
2. Deploy v2.4.0.
3. Run migration `V24__role_pagination.sql`.
4. Rollback: redeploy v2.3.5 and restore backup.

## Contributors
Thanks: @alex, @sam, @jordan.
```

## Anti-patterns
- "Various improvements and bug fixes" (zero signal).
- Breaking change hidden in "Changed" section.
- Copy-paste of PR titles (jargon-heavy, unclear).
- No rollback plan.
- Missing version number.

## Quality gate
Reject release if any breaking change lacks a migration snippet or rollback instructions.
