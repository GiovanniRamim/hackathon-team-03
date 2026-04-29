---
title: "Setup Guide — From Zero to Coding"
description: "Complete beginner-friendly step-by-step: create the team's GitHub repository, add members, activate Copilot, install Spec-Kit and Specky, set branch strategy, and configure each persona's Copilot kit"
author: "Paula Silva, Americas Software GBB, Microsoft"
date: "2026-04-29"
version: "2.0.0"
status: "approved"
tags: ["setup", "onboarding", "github", "copilot", "spec-kit", "specky", "hackathon", "datacorp", "beginner"]
---

# Setup Guide — From Zero to Coding

> **You are 10 people. You have one workday.** This guide takes you from "we have nothing yet" to "first commit pushed, Copilot working, every persona ready" in **45 minutes**.
>
> **Everyone in the team should follow along on their own laptop.** One person screen-shares the steps, the other 9 mirror them. By the end, every laptop is fully configured.

## Table of Contents

- [📋 Before You Start — Mental Model](#-before-you-start--mental-model)
- [✅ Step 1 — Verify your laptop has the prerequisites](#-step-1--verify-your-laptop-has-the-prerequisites)
- [👥 Step 2 — Create the team's GitHub repository (lead only)](#-step-2--create-the-teams-github-repository-lead-only)
- [🎟️ Step 3 — Add the other 9 team members (lead only)](#%EF%B8%8F-step-3--add-the-other-9-team-members-lead-only)
- [🛡️ Step 4 — Protect the `main` branch (lead only)](#%EF%B8%8F-step-4--protect-the-main-branch-lead-only)
- [📥 Step 5 — Bootstrap your team repo from this kit (lead only)](#-step-5--bootstrap-your-team-repo-from-this-kit-lead-only)
- [💻 Step 6 — Each member clones the team repo](#-step-6--each-member-clones-the-team-repo)
- [🤖 Step 7 — Activate GitHub Copilot in VS Code (everyone)](#-step-7--activate-github-copilot-in-vs-code-everyone)
- [🎭 Step 8 — Install your persona's Copilot kit (everyone)](#-step-8--install-your-personas-copilot-kit-everyone)
- [📐 Step 9 — Install Spec-Kit (everyone)](#-step-9--install-spec-kit-everyone)
- [🎯 Step 10 — Install Specky (everyone)](#-step-10--install-specky-everyone)
- [🌿 Step 11 — Understand the branch strategy](#-step-11--understand-the-branch-strategy)
- [🔄 Step 12 — Daily workflow per persona](#-step-12--daily-workflow-per-persona)
- [🚦 Step 13 — Run the smoke test (whole team, at 09:30)](#-step-13--run-the-smoke-test-whole-team-at-0930)
- [🆘 Troubleshooting](#-troubleshooting)

---

## 📋 Before You Start — Mental Model

You will end up with **3 repositories on your laptop**:

```
~/Code/
├── kit/                            (this team-kit, READ-ONLY reference)
├── reference/sifap-legacy/         (legacy SIFAP code, READ-ONLY reference)
└── hackathon-team-XX/              (YOUR team's working repo — where you commit)
```

| Repo | What you do with it | Where it lives |
|------|---------------------|----------------|
| `team-kit` | You read its docs and copy parts of it once at start | github.com/paulasilvatech/hackathon-datacorp-team-kit (public) |
| `sifap-legacy` | You read it during Stage 1 — never edit | github.com/paulasilvatech/sifap-legacy (public) |
| `hackathon-team-XX` | **All your work goes here** | github.com/<YOUR_GITHUB_USER>/hackathon-team-XX (private, you create it) |

> **Key rule.** Never push to the kit or sifap-legacy. Your team's commits go only to `hackathon-team-XX`.

---

## ✅ Step 1 — Verify your laptop has the prerequisites

**Every team member runs this checklist on their own laptop.**

| Tool | Min version | How to verify | If missing |
|------|-------------|---------------|------------|
| **Git** | 2.40+ | Open a terminal, type `git --version` | <https://git-scm.com/downloads> |
| **GitHub account** | — | Go to github.com, sign in | <https://github.com/signup> |
| **GitHub CLI** | 2.40+ | `gh --version` | <https://cli.github.com> |
| **VS Code** | 1.93+ | Open VS Code, **Help → About** | <https://code.visualstudio.com/download> |
| **Docker Desktop** | 4.30+ | `docker --version` AND open Docker app | <https://www.docker.com/products/docker-desktop> |
| **Java 21 JDK** | 21 | `java -version` | <https://learn.microsoft.com/java/openjdk/download> |
| **Node.js** | 20 LTS | `node --version` | <https://nodejs.org/en/download> |

> **Have most of these missing?** The fastest path is to use the **dev container** (Step 6.4). It bundles every tool. You only need Docker Desktop running.

### License check (one person checks for the team)

1. Open <https://github.com/settings/copilot> in your browser.
2. You must see **"Active subscription"** (Individual) or **"Business plan"** at the top.
3. If you see "Get GitHub Copilot" instead, raise a hand for the blue-cord facilitator team.

---

## 👥 Step 2 — Create the team's GitHub repository (lead only)

**Pick one person to be the team lead** (usually the Tech Lead persona). Only the lead does Steps 2–5. The other 9 wait and follow from Step 6.

### Option A — using the website (easier for beginners)

1. Open <https://github.com/new> in your browser.
2. Fill in:
   - **Owner**: **your own GitHub username** (do **not** pick `paulasilvatech` — teams do not have admin rights there). If your team has its own GitHub org and you are an admin of it, you can use that instead.
   - **Repository name**: `hackathon-team-XX` (replace XX with your team number, e.g., `hackathon-team-01`)
   - **Description**: `Hackathon DATACORP 2026 — Team XX`
   - **Visibility**: **Private** ✅
3. Initialize this repository with:
   - **Add a README file** ✅
   - **Add .gitignore**: pick `Java`
   - **Choose a license**: leave **None**
4. Click the green **Create repository** button.

You should now see your empty repo with a README. Keep this browser tab open — you'll come back to it.

### Option B — using the GitHub CLI (faster, but typing-heavy)

Open a terminal and run:

```bash
# Sign in once per laptop — opens a browser to authorize
gh auth login

# Create the repo (replace 01 with your team number)
# Use just the repo name — no owner prefix. Creates the repo under YOUR GitHub user.
gh repo create hackathon-team-01 \
  --private \
  --description "Hackathon DATACORP 2026 — Team 01" \
  --add-readme \
  --gitignore Java
```

If the command prints a URL ending in `hackathon-team-01`, you're done.

---

## 🎟️ Step 3 — Add the other 9 team members (lead only)

The lead invites the rest of the team so everyone can push and pull.

### Option A — using the website

1. Go to your repo on GitHub: `https://github.com/<YOUR_GITHUB_USER>/hackathon-team-XX`
2. Click **Settings** (top tab — needs admin permission, the lead has it).
3. Left sidebar: click **Collaborators**.
4. Click **Add people**.
5. Type the GitHub username (e.g., `alice-builder`) and pick from the dropdown.
6. **Choose the role**: pick **Write** (not Admin, not Read).
7. Click **Add ... to this repository**.
8. Repeat for the other 8 people.

> **Tip.** Each invited person receives an email and an in-app notification. They must click **Accept invitation** before they can push.

### Option B — using the CLI

Once per teammate:

```bash
# Replace alice with the actual GitHub username
gh api -X PUT "repos/<YOUR_GITHUB_USER>/hackathon-team-01/collaborators/alice" \
  -f permission=write
```

Or in a loop:

```bash
for user in alice bob carla dani eve felipe gabi hugo ivone juliana; do
  gh api -X PUT "repos/<YOUR_GITHUB_USER>/hackathon-team-01/collaborators/${user}" \
    -f permission=write
done
```

---

## 🛡️ Step 4 — Protect the `main` branch (lead only)

This prevents anyone (including you) from pushing broken code straight to `main`. Every change must go through a Pull Request.

### Using the website

1. Go to **Settings** → **Branches** (left sidebar).
2. Under **Branch protection rules**, click **Add rule**.
3. Branch name pattern: `main`
4. Tick:
   - **Require a pull request before merging** ✅
   - **Require approvals** — set to `1`
   - **Require conversation resolution before merging** ✅
5. Click **Create**.

### Using the CLI

```bash
gh api -X PUT "repos/<YOUR_GITHUB_USER>/hackathon-team-01/branches/main/protection" \
  --input - <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": { "required_approving_review_count": 1 },
  "restrictions": null
}
JSON
```

> **Why this matters.** Without this rule, someone in the team will eventually push a typo to `main` at minute 90 and the demo will fail at minute 480. Cost: 30 seconds. Saves: hours.

---

## 📥 Step 5 — Bootstrap your team repo from this kit (lead only)

Now we copy everything from this team-kit into the empty team repo so you have all the templates, personas, scripts, and CI workflows ready.

```bash
# 1. Pick a folder for all your code
mkdir -p ~/Code && cd ~/Code

# 2. Clone this team kit (read-only reference)
git clone https://github.com/paulasilvatech/hackathon-datacorp-team-kit.git kit

# 3. Clone YOUR empty team repo (where work happens)
git clone https://github.com/<YOUR_GITHUB_USER>/hackathon-team-01.git
cd hackathon-team-01

# 4. Copy everything from the kit into your team repo
#    The trailing /. and the dot at the end matter — they copy hidden files too
cp -R ../kit/. .

# 5. Don't bring the kit's git history. Your team has its own.
rm -rf .git
git init -b main
git remote add origin https://github.com/<YOUR_GITHUB_USER>/hackathon-team-01.git

# 6. Make scripts executable (one-time fix)
chmod +x scripts/*.sh
```

### Run the bootstrap script

This clones the read-only `sifap-legacy` repository into `reference/`, creates the `legacy/` symlink, and initializes an empty `.specs/` folder for Specky.

```bash
./scripts/setup.sh
```

If it ends with **"Done."** and lists "Next steps", you are good. If it errors, check the [Troubleshooting](#-troubleshooting) section.

### First commit and push

```bash
git add -A
git commit -m "chore: bootstrap team kit"
git push -u origin main
```

You should see "main set up to track origin/main" and "Branch 'main' set up to track remote branch 'main' from 'origin'." That means the push worked.

> ⚠️ **Important.** From now on you should never push directly to `main`. Step 4 protects it. The next sections show how to use feature branches.

### Create the `develop` integration branch

```bash
git checkout -b develop
git push -u origin develop
```

`develop` is where everyone's feature branches will merge. Promotions to `main` happen via PR after each stage.

---

## 💻 Step 6 — Each member clones the team repo

**Now everyone joins.** The 9 other team members do this.

### 6.1 Accept the invitation

1. Open the email from GitHub titled **"Paula Nunes invited you to ..."** (or check the bell icon at github.com).
2. Click **View invitation** → **Accept invitation**.

### 6.2 Clone

```bash
mkdir -p ~/Code && cd ~/Code

# Replace 01 with your actual team number
git clone https://github.com/<YOUR_GITHUB_USER>/hackathon-team-01.git
cd hackathon-team-01
```

### 6.3 Open in VS Code

```bash
code .
```

### 6.4 Reopen in Dev Container (highly recommended)

The repo includes `.devcontainer/devcontainer.json`. The dev container has Java 21, Node 20, Docker-in-Docker, and the Copilot extensions already pinned to known-good versions.

1. VS Code shows a popup at the bottom-right: **"Folder contains a Dev Container configuration. Reopen in Container?"** → click **Reopen in Container**.
2. If you missed the popup: open the Command Palette (`Ctrl+Shift+P` on Windows/Linux, `Cmd+Shift+P` on Mac) and pick **Dev Containers: Reopen in Container**.
3. Wait 2-5 minutes the first time. VS Code rebuilds.
4. When the bottom-left shows **"Dev Container: SIFAP 2.0 …"**, you're inside.

### 6.5 Bootstrap on your machine too

Even though the lead bootstrapped the repo, each member needs to materialize the `legacy/` symlink locally:

```bash
./scripts/setup.sh
```

---

## 🤖 Step 7 — Activate GitHub Copilot in VS Code (everyone)

Each person does this on their own laptop.

### 7.1 Sign in

1. In VS Code, look at the bottom status bar. Click the **Copilot** icon (🤖).
2. Pick **Sign in with GitHub**.
3. A browser window opens. Click **Authorize Visual Studio Code**.
4. Return to VS Code. Wait for "Copilot ready" near the bottom-right.

### 7.2 Open the Copilot Chat panel

| OS | Shortcut |
|----|----------|
| Mac | `Cmd+Ctrl+I` |
| Windows / Linux | `Ctrl+Alt+I` |

A panel opens on the right.

### 7.3 Verify the 3 modes are available

At the top of the chat panel there is a dropdown:

| Mode | When to use |
|------|-------------|
| **Chat** (default) | Ask questions, explore code, brainstorm |
| **Edits** | Multi-file edits with you reviewing the diff |
| **Agent** | Delegate a full feature via an Issue, then merge the PR |

Click the dropdown to confirm all three are listed. If **Agent** is missing, update VS Code to **1.93 or later** (or use VS Code Insiders, which always has the latest).

### 7.4 Smoke test Copilot

In the Chat panel, type:

```
What stack are we using on this project?
```

It should answer with **Java 21 + Spring Boot 3.3 + Next.js 15 + PostgreSQL 16**. If it doesn't, the project's `.github/copilot-instructions.md` file isn't being loaded — see [Troubleshooting](#-troubleshooting).

---

## 🎭 Step 8 — Install your persona's Copilot kit (everyone)

Each of the 10 team members has a **persona** (Product Owner, Developer, DBA, etc.). The team kit ships with 25 different Copilot agent packages — one per persona. You install the one for your role.

### 8.1 Find your role

Open `personas/` in VS Code. You'll see 10 cards, numbered 01-10. Read your card top to bottom (~10 minutes). It tells you:

- What you do across the 4 stages
- Which Copilot mode to use
- Specific prompts you can copy/paste
- Who you depend on, who depends on you

### 8.2 Install your kit

Each persona has a corresponding **kit** in `persona-kits/`. The kit contains:

- `.github/agents/<role>.agent.md` — pre-configured Copilot agent
- `.github/prompts/<command>.prompt.md` — slash commands for recurring tasks
- `.github/skills/<skill>/SKILL.md` — reusable mental models
- `mcp.json` — MCP server config (if any)

To install your kit, copy its `.github/` content into the team repo's `.github/`:

```bash
# Replace XX-your-role with your actual persona id
# e.g., 06-developer, 09-devops-engineer, 13-qa-engineer
cp -r persona-kits/XX-your-role/.github/* .github/

# If your kit has mcp.json, copy it into .vscode/
[ -f persona-kits/XX-your-role/mcp.json ] && \
  mkdir -p .vscode && \
  cp persona-kits/XX-your-role/mcp.json .vscode/mcp.json
```

### 8.3 Persona-to-kit mapping

The 10 personas map to these specific kits:

| Persona card (`personas/`) | Kit (`persona-kits/`) |
|----------------------------|------------------------|
| `01-product-owner.md` | `01-product-owner/` |
| `02-requirements-engineer.md` | `03-requirements-engineer/` |
| `03-enterprise-architect.md` | `04-enterprise-architect/` |
| `04-software-architect.md` | `05-software-architect/` |
| `05-technical-lead.md` | `06-technical-lead/` |
| `06-developer.md` | `22-developer/` |
| `07-dba.md` | `21-dba/` |
| `08-qa-engineer.md` | `13-qa-engineer/` |
| `09-devops-engineer.md` | `11-devops-engineer/` |
| `10-tech-writer.md` | `23-tech-writer/` |

### 8.4 Update the team's `copilot-instructions.md`

Once each persona has installed their kit, the **team lead** updates the file `.github/copilot-instructions.md` with everyone's names. Find this section:

```markdown
## Active Personas on This Team

- [ ] 01 — Product Owner
- [ ] 02 — Requirements Engineer
...
```

Tick the boxes and write the name next to each role:

```markdown
- [x] 01 — Product Owner — Maria Santos
- [x] 02 — Requirements Engineer — João Silva
- [x] 03 — Enterprise Architect — Ana Costa
...
```

Commit and push to `develop`. Now Copilot suggestions know who is on your team.

---

## 📐 Step 9 — Install Spec-Kit (everyone)

[**Spec-Kit**](https://github.com/github/spec-kit) is GitHub's official toolkit for spec-driven development. Use it for **quick feature drafts** in Stage 2.

### 9.1 Install globally on your laptop

```bash
npm install -g @github/spec-kit
spec-kit --version
```

### 9.2 Initialize in the team repo

Run this once, in the root of your team repo:

```bash
spec-kit init
```

This creates a `.spec-kit/` folder with a starter project file.

### 9.3 Author a feature

```bash
spec-kit new "payment-cycle-generation"
```

Spec-Kit asks you (interactively):

1. **Goal** — write one sentence: *"Allow operators to generate a monthly payment cycle for active beneficiaries."*
2. **Personas** — who benefits? (the operator, the beneficiary)
3. **Acceptance criteria** — list what must be true when this is done
4. **Out-of-scope** — what we are explicitly NOT doing now

Output: `.spec-kit/payment-cycle-generation/spec.md` — a clean spec your whole team can read.

### 9.4 When to use Spec-Kit vs Specky

| Use Spec-Kit | Use Specky |
|--------------|------------|
| Quick natural-language draft | Full 10-phase pipeline |
| 30-minute brain-dump in Stage 2 | Engineering rigor in Stage 2 → 3 → 4 |
| Stakeholder-friendly | Engineering-friendly |
| Single feature | Modular monolith with REQ-IDs |

> **Hackathon recommendation.** Start in Spec-Kit (15 minutes to draft), validate with the Product Owner, then promote into Specky for the full pipeline.

---

## 🎯 Step 10 — Install Specky (everyone)

[**Specky**](https://github.com/paulasilvatech/specky) is the SDD pipeline engine used in this hackathon. It enforces a 10-phase pipeline with quality gates.

### 10.1 Install globally

```bash
npm install -g specky-sdd@latest
specky --version
specky doctor          # verifies your environment
```

### 10.2 Install Specky into the team repo

This populates `.github/agents/`, `.github/prompts/`, `.github/skills/`, and `.specky/`:

```bash
cd ~/Code/hackathon-team-01
specky install --ide=copilot
```

> **Note.** This is on top of any persona-kit you installed. Specky and persona-kits coexist — they install into different sub-folders of `.github/`.

### 10.3 Initialize a feature in Specky

In Copilot Chat, type:

```
@specky-onboarding
```

Or directly:

```
@sdd-init
```

The agent asks:
- Feature name (e.g., `payment-cycle-generation`)
- Sponsoring persona
- Target stage

Specky writes:

```
.specs/001-payment-cycle-generation/
├── CONSTITUTION.md
├── RESEARCH.md
└── (others created in later phases)
```

### 10.4 The 10-phase pipeline

| Phase | Agent | Output | Owner persona |
|-------|-------|--------|---------------|
| 0 Init | `@sdd-init` | CONSTITUTION.md | Tech Lead |
| 1 Discover | `@research-analyst` | RESEARCH.md | Requirements Engineer + Enterprise Architect |
| 2 Specify | `@spec-engineer` | SPECIFICATION.md (EARS) | Requirements Engineer |
| 3 Clarify | `@sdd-clarify` | CLARIFICATION-LOG.md | Requirements Engineer + Product Owner |
| 4 Design | `@design-architect` | DESIGN.md + ADRs + diagrams | Software Architect + Enterprise Architect |
| 5 Tasks | `@task-planner` | TASKS.md + CHECKLIST.md | Tech Lead |
| 6 Analyze | `@quality-reviewer` | ANALYSIS.md | QA Engineer |
| 7 Implement | `@implementer` | code | Developer |
| 8 Verify | `@test-verifier` | tests + coverage | QA Engineer |
| 9 Release | `@release-engineer` | PR + deploy | DevOps Engineer |

> **LGTM gates** after Specify, Design, and Tasks. The team must explicitly approve before advancing.

---

## 🌿 Step 11 — Understand the branch strategy

Your team has **5 categories of branches**. Use the right type for the right work.

```
main                    ← release-ready, protected, 1 reviewer required
develop                 ← integration of all features
spec/NNN-feature        ← Specification work (Stage 2)
impl/NNN-feature        ← Implementation work (Stage 3)
infra/NNN-azure         ← Infrastructure work (Stage 4)
```

### Naming convention

| Type | Pattern | Example |
|------|---------|---------|
| Spec | `spec/NNN-kebab-name` | `spec/001-payment-cycle-generation` |
| Implementation | `impl/NNN-kebab-name` | `impl/001-payment-cycle-generation` |
| Infrastructure | `infra/NNN-kebab-name` | `infra/001-azure-deployment` |

`NNN` is the feature number (matches the folder in `.specs/NNN-...`).

### Creating a feature branch

```bash
# Make sure you're on develop with latest changes
git checkout develop
git pull

# Create your feature branch
git checkout -b spec/001-payment-cycle-generation

# Work, commit
git add -A
git commit -m "feat(payments): draft EARS requirements for cycle generation"

# Push to origin
git push -u origin spec/001-payment-cycle-generation
```

### Opening a Pull Request

1. After pushing, GitHub prints a URL like `https://github.com/.../pull/new/spec/001-...`. Click it (or paste in your browser).
2. Title: use Conventional Commits — `feat(payments): add cycle generation spec`
3. Description: GitHub auto-loads the template (`.github/PULL_REQUEST_TEMPLATE.md`). Fill in:
   - **What changed** (one paragraph)
   - **REQ-IDs implemented** (e.g., `REQ-PAY-014, REQ-PAY-015`)
   - **How to test** (the reviewer pulls and runs this)
   - **Linked issues** (e.g., `Closes #12`)
4. **Reviewers**: add at least one teammate from a different persona.
5. Click **Create pull request**.
6. CI runs (the workflow `.github/workflows/ci.yml`). Wait for the green check.
7. After approval, click **Rebase and merge** (not Merge commit, not Squash).
8. Delete the feature branch when prompted.

---

## 🔄 Step 12 — Daily workflow per persona

Each persona has a **default daily loop**. Run it as many times as needed during the day.

### 🧠 Product Owner / Requirements Engineer

```
1. Read the Stage 1 findings (glossary, business rules catalog)
2. Open Spec-Kit: spec-kit new "feature-name"
3. Validate the draft with stakeholder personas (PO + EA)
4. Promote to Specky: @sdd-init feature-name
5. Run @spec-engineer to produce SPECIFICATION.md (EARS)
6. Open a PR on branch spec/NNN-feature-name
7. Hand off to Software Architect (LGTM gate)
```

### 🏗️ Enterprise Architect / Software Architect

```
1. Pull latest develop
2. git checkout spec/NNN-feature-name (read the EARS spec)
3. Run @design-architect → produces DESIGN.md + Mermaid C4 diagrams
4. Add ADRs in docs/adr/ for non-trivial decisions
5. Open a PR — review the spec PR's design section
6. Hand off to Tech Lead (LGTM gate)
```

### 🧠 Technical Lead

```
1. Read the merged DESIGN.md
2. Run @task-planner → produces TASKS.md with task IDs (T-001, T-002, ...)
3. Open a GitHub Issue per task using .github/ISSUE_TEMPLATE/task.yml
4. Assign each issue to a Developer / DBA / QA
5. Watch CI green/red, unblock people
```

### 💻 Developer

```
1. Pick a task issue (T-NNN) from the team board
2. git checkout -b impl/NNN-task-name (from develop)
3. In Copilot, run /implement (your prompt is in 22-developer/.github/prompts/)
4. Tests first (red), code (green), refactor
5. ./scripts/check.sh (mirrors CI)
6. git commit, git push, open PR
7. Tag the issue with "Closes #NN" in the PR body
```

### 🗃️ DBA

```
1. Pick a schema/migration task
2. git checkout -b impl/NNN-migration-name
3. Add Flyway migration in backend/src/main/resources/db/migration/
4. Run /migration prompt (in 21-dba/.github/prompts/)
5. Test locally with docker compose up
6. Open PR, request Developer review
```

### 🧪 QA Engineer

```
1. Watch every implementation PR
2. Run /coverage-gaps prompt to find uncovered REQ-IDs
3. Add tests on the implementation branch (pair with Developer)
4. /test-strategy prompt produces a test plan for new features
5. Block merge if coverage drops below 70%
```

### ⚙️ DevOps Engineer

```
1. Pick an infra task (Azure setup, CI/CD, deployment)
2. git checkout -b infra/NNN-azure-foo
3. Edit infra/ Terraform modules
4. terraform fmt + terraform validate locally
5. Run /iac-module prompt (in 11-devops-engineer/.github/prompts/)
6. Open PR, the workflows/ci.yml runs Terraform validation
```

### 📝 Tech Writer

```
1. After every merge to develop, scan for ADR/glossary drift
2. Run /doc-drift prompt (in 23-tech-writer/.github/prompts/)
3. Update docs/glossary.md, docs/adr/, READMEs
4. Open a small PR per documentation update
```

---

## 🚦 Step 13 — Run the smoke test (whole team, at 09:30)

The team lead reads each item out loud. Each person confirms on their laptop.

- [ ] Every member has cloned `hackathon-team-XX`
- [ ] Every member can run `git push origin develop` (write access confirmed)
- [ ] CI ran on the bootstrap commit — green check in **Actions** tab
- [ ] `docker compose up -d` succeeds (or facilitator hands you the prototype tarball at Stage 3)
- [ ] Every Copilot Chat answers "What stack are we using?" with the right answer
- [ ] Every member has installed Specky: `specky doctor` reports no errors
- [ ] `spec-kit --version` prints a version on every laptop
- [ ] `gh issue list` works (returns the 3 issue templates: spec, adr, task)
- [ ] All 10 team members visible in repo Settings → Collaborators
- [ ] Each persona has read their card in `personas/XX-role.md`
- [ ] Team lead has updated `.github/copilot-instructions.md` with everyone's names
- [ ] Each persona has installed their kit: `cp -r persona-kits/XX/.github/* .github/`
- [ ] [`TEAM-FLOW.md`](TEAM-FLOW.md) read aloud once (the daily timeline)

When all 13 are green, your team is ready for **Stage 1: Archaeology**.

---

## 🆘 Troubleshooting

### Copilot doesn't read `copilot-instructions.md`

- VS Code must be opened **at the repo root**, not inside a sub-folder.
- Restart VS Code after editing the file.
- In Settings, check `github.copilot.chat.useProjectInstructions` is `true` (default in 1.93+).

### `gh repo create` returns 422

- The name is already taken. Bump the number (`hackathon-team-01b`).
- Or create from the website (Option A in [§2](#-step-2--create-the-teams-github-repository-lead-only)).

### `specky install` fails with "Cannot resolve plugin"

- Run `specky doctor` to see which dependency is missing.
- Clear the cache: `rm -rf ~/.specky-cache && specky install --ide=copilot`.
- If it still fails, ask a facilitator. Specky can be installed manually.

### CI fails on first push with "no tests found"

- Expected. The `ci.yml` workflow only runs jobs whose paths changed. Once backend/frontend code lands, the relevant jobs run.

### Docker compose up hangs or fails

- Ports 5432, 8080, or 3000 may be in use. Run:

  ```bash
  lsof -i :5432 -i :8080 -i :3000
  ```

  Kill the offending process (`kill -9 <PID>`) and retry.
- Make sure Docker Desktop is **running** (its menu bar icon should be steady, not animated).

### Copilot Agent mode doesn't appear in the dropdown

- Update VS Code to **1.93 or later** (or install **VS Code Insiders**, which always has it).
- Reload the window: Command Palette → **Developer: Reload Window**.

### "Permission denied" when pushing to `main`

- Branch protection (Step 4) is doing its job. Open a Pull Request from your feature branch instead.

### Pulled latest `develop` but my IDE still shows old code

- Reload the VS Code window: Command Palette → **Developer: Reload Window**.
- If you're inside a dev container, sometimes you also need: Command Palette → **Dev Containers: Rebuild Container**.

### Persona kit installation broke my `.github/` folder

- The kit's `.github/` is meant to **add to** what's already there, not overwrite.
- If something looks broken: `git checkout main -- .github/` to restore, then `cp -r persona-kits/XX/.github/* .github/` again.

---

## 🧭 Navigation

| Parent | Home | Next |
|--------|------|------|
| [README](README.md) | [Repository Root](README.md) | [TEAM-FLOW.md](TEAM-FLOW.md) |

— Paula
