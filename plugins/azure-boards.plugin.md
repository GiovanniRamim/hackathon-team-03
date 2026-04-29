---
name: Azure Boards
type: plugin
description: "Sync SDD work items with Azure DevOps Boards. Create Epics, Features, User Stories, and Tasks with REQ-ID traceability."
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
audience: persona-kits (all roles)
---

# 📊 Azure Boards Plugin

> Sync SDD work items with Azure DevOps Boards. Create Epics, Features, User Stories, and Tasks with REQ-ID traceability.

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

Sync SDD work items with Azure DevOps Boards. Create Epics, Features, User Stories, and Tasks with REQ-ID traceability.

---

## 📌 Use This Plugin When

- Syncing from TASKS.md to an ADO project with the hackathon work items
- Creating Epic → Feature → Story hierarchy aligned to SPECIFICATION.md
- Keeping acceptance criteria in sync between markdown and ADO

---

## 🛠️ Tools Provided

### `create_work_item`
Create a single Epic/Feature/User Story/Task with fields mapped from markdown frontmatter.

### `sync_tasks_file`
Parse TASKS.md and upsert work items; existing items matched by REQ-ID in the tag list.

### `link_hierarchy`
Create parent-child links between Epic/Feature/Story/Task from the markdown outline.

### `push_acceptance_criteria`
Copy acceptance criteria from SPECIFICATION.md REQ-NNN into the matching work item's Acceptance Criteria field.

### `comment_on_change`
Post a comment on the work item summarising a git commit that references its REQ-ID.

---

## ⚙️ Configuration

### Required configuration
- `organization`: ADO organisation name.
- `project`: ADO project name.
- `pat`: Personal Access Token with `Work Items (Read & Write)` scope (env var `AZURE_DEVOPS_PAT`).
- `area_path`: default area path for created items.

### Optional configuration
- `iteration_path`: default sprint iteration.
- `type_map`: override mapping of markdown heading level to work item type. Default:
  - `# Epic` → Epic
  - `## Feature` → Feature
  - `### Story` → User Story
  - `- [ ] Task` → Task
- `dry_run`: preview without writing (default `true`).

---

## 🚀 Usage Pattern

```text
@copilot using azure-boards plugin, sync TASKS.md to <target>.
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
| ← [GitHub Issues](./github-issues.plugin.md) | [Kit Root](../README.md) | [Plugins](./README.md) → |

> Author: Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft.
