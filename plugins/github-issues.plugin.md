---
name: GitHub Issues
type: plugin
description: "Create and sync GitHub issues from SDD specification tasks. Bulk-create issues from TASKS.md, maintain REQ-ID traceability, manage labels and milestones."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
audience: persona-kits (all roles)
---

# 🎫 GitHub Issues Plugin

> Create and sync GitHub issues from SDD specification tasks. Bulk-create issues from TASKS.md, maintain REQ-ID traceability, manage labels and milestones.

---

## 📑 Table of Contents

1. [What It Does](#-what-it-does)
2. [Use This Plugin When](#-use-this-plugin-when)
3. [Tools Provided](#-tools-provided)
4. [Configuration](#-configuration)
5. [Usage Pattern](#-usage-pattern)
6. [Security](#-security)
7. [Anti-Patterns](#-anti-patterns)
8. [Quality Gate](#-quality-gate)

---

## 🎯 What It Does

Create and sync GitHub issues from SDD specification tasks. Bulk-create issues from TASKS.md, maintain REQ-ID traceability, manage labels and milestones.

---

## 📌 Use This Plugin When

- Creating issues from TASKS.md
- Syncing SDD artefacts to a GitHub project board
- Opening a set of issues for parallel team work in the hackathon

---

## 🛠️ Tools Provided

### `create_issue`
Create a single GitHub issue from a task description.

### `create_issues_from_tasks`
Parse TASKS.md and bulk-create an issue per task, preserving REQ-ID traceability in the body.

### `add_labels`
Add labels (persona role, priority, area) to an existing issue.

### `link_issues`
Add `Depends on #N` references between issues to mirror task dependencies.

### `move_to_milestone`
Attach issues to a milestone (e.g., 'Stage 3 — Implementation').

---

## ⚙️ Configuration

### Required configuration
- `repo`: `owner/repo` target of issue creation.
- `github_token`: PAT with `issues:write` scope (use `GITHUB_TOKEN` env var, never inline).
- `tasks_file`: path to `TASKS.md` (default `.specs/001-*/TASKS.md`).

### Optional configuration
- `label_map`: mapping of persona folder to label (e.g., `01-product-owner` → `role/po`).
- `milestone`: milestone to attach.
- `dry_run`: preview without creating (default `true`).

---

## 🚀 Usage Pattern

```text
@copilot using github-issues plugin, sync TASKS.md to <target>.
```

Copilot invokes the plugin, the plugin reads the markdown source of truth, and applies changes to the target system.

---

## 🔒 Security

- Always read credentials from environment variables. Never inline a PAT in a prompt or config file committed to the repo.
- Default `dry_run` to `true`. Only set to `false` after previewing output.
- Every operation logs the REQ-ID trace it acted on, so you can correlate changes with specification history.

---

## ⚠️ Anti-Patterns

- Using the plugin as the source of truth. The source of truth lives in markdown under `.specs/`; the plugin is a sync mechanism.
- Running with `dry_run: false` before reviewing the preview.
- Committing PATs to the repo.

---

## ✅ Quality Gate

Every sync must preserve REQ-ID traceability. If a target system cannot store the REQ-ID (legacy tracker), the plugin refuses to run.

---

## 🧭 Navigation

| Previous | Home | Next |
|---|---|---|
| ← [Plugins](./README.md) | [Kit Root](../README.md) | [Azure Boards](./azure-boards.plugin.md) → |

> Author: Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft.
