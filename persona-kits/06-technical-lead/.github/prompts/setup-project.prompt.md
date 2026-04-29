---
mode: ask
model: claude-sonnet-4-6
description: "Bootstrap a new Copilot-enabled project"
---

# /setup-project

## Task
Bootstrap a project with the Copilot context engineering scaffold: AGENTS.md, CODEMAP.md, `.github/instructions/`, `.github/prompts/`, `.github/agents/`, `.github/copilot-instructions.md`.

## Steps
1. Detect the tech stack from existing files (package.json, pom.xml, requirements.txt, *.csproj).
2. Create AGENTS.md with: stack summary, coding conventions, test command, lint command, build command.
3. Create CODEMAP.md skeleton with `## Modules`, `## Data Flow`, `## External Integrations` sections.
4. Create `.github/copilot-instructions.md` with language, tone, and security rules from the team standard.
5. Drop in baseline instruction files scoped by `applyTo:` (e.g. `**/*.java`, `**/*.ts`).
6. Stage the changes but do not commit. Print the list of files created.

## Output
- List of files created (absolute paths)
- Suggested first commit message
- Three follow-up actions the user should take manually

## Quality Gate
- [ ] AGENTS.md is specific to the detected stack, not generic
- [ ] Every instruction file has an `applyTo:` scope
- [ ] No secrets, no credentials, no placeholders like TODO
- [ ] `.gitignore` updated if new folders need to be versioned
