---
title: "Persona Card - Developer"
description: "What the Developer does inside the team of 10 during Day 2 of Hackathon DATACORP 2026."
author: "Paula Silva, Americas Software GBB, Microsoft"
date: "2026-04-18"
version: "1.0.0"
persona_id: "06"
tags: ["persona", "developer", "hackathon", "DATACORP"]
---

# Persona - Developer

## Who this person is

You write the code. More than that: you are the one using Copilot all day across all three modes and translating ideas into diff. In Stage 3 you carry the heavy weight of production.

## Mission in the hackathon

Turn the spec into running code. Use Copilot deliberately - Chat to understand, Edits to produce, Agent to delegate. Push every day.

## Your role in the Agentic Legacy Modernization framework

This hackathon applies the **Agentic Legacy Modernization** framework — an approach to legacy system modernization using AI agents specialized in each phase. The full pipeline is described in the **Hackathon Blueprint** (provided separately by the facilitators). Your persona maps to the pipeline as follows:

- **Relevant agents**: Translation Agent (S3), Review Agent (S3)
- **Framework phase**: Translation and Test Generation
- **Your role in the pipeline**: Implement the Natural → Java translation guided by the EARS spec

## Where you show up by stage

| Stage | You do this | Deliverable that depends on you |
|---|---|---|
| 1. Archaeology | Read Natural programs with Copilot Chat. Produce a readable summary for the rest of the team. | Narrative summaries of the programs |
| 2. Greenfield Spec | Pair with the Requirements Engineer to anticipate implementation problems. | Preventive signals in the spec |
| 3. Reconstruction | Implement, test, open PR, review PR, implement again. | Backend + frontend of your slice |
| 4. Evolution with Agent | Watch the Agent work. Step in when it loses its way. Finish what it didn't complete. | Agent's PR in mergeable shape |

## Tools and primitives

- **Copilot Chat** - understanding and design discussion.
- **Copilot Edits** - your main tool in Stage 3.
- **Copilot Agent** - in Stage 4, you are the one driving the Agent for the team or alongside the TL.
- **Specky** - consumer of the SA and RE artifacts; produces code guided by the spec.
- **GitHub MCP** to work with issues and PRs without leaving VS Code.

## Cheat sheets you use

- `cheat-sheets/copilot-3-modes.md` - this is your map for the day.
- `cheat-sheets/specky-workflow.md` - phases 5 to 10.
- `cheat-sheets/model-routing.md` - Haiku 4.5 for simple snippets, Sonnet 4.6 as the default, Opus 4.6 for design.

## How you do well

- Use the three Copilot modes deliberately - it is not always Chat.
- Small commits and small pull requests.
- Write tests at the same time as the code.
- Don't fall in love with an abstraction in the middle of Stage 3.

## How you get lost

- Work eight hours on a single huge branch.
- Use the Agent for a task that Edits would solve in 5 minutes.
- Write code without tests and discover at 4:30 PM that nothing works.
- Always go to Opus 4.6 - you'll spend too much time waiting.

## If you took on two personas

- **Developer + Technical Lead** - very common.
- **Developer + QA Engineer** - you write the feature and the tests in the same head.
- **Developer + DevOps Engineer** in a small team - you package and ship.

## 3 Example prompts

1. **(Chat)** "Explain the CALCDSCT.NSN program from legacy SIFAP and identify the discount cap rule. Then help me implement the equivalent in Java following the existing PaymentService pattern."
2. **(Edits)** "Select BeneficiaryEntity.java, BeneficiaryService.java, and BeneficiaryController.java. Add an 'email' field to the beneficiary: entity, service, controller, migration, and test."
3. **(Agent)** "Implement the feature described in this Issue: [paste the issue]. Respect the 3-layer architecture and include tests."

## If you get stuck (emergency defaults)

- Code won't compile? `mvn test-compile` to see the exact error. Usually it's a missing import.
- Don't know the package structure? Look at `beneficiary/` as a reference: domain/ → application/ → infrastructure/.
- Copilot generating bad code? Switch from Chat to Edits - select the relevant files and describe the change.
- Test failing? Read the error message. If it's NPE, you're probably missing a mock. If it's an assertion, the expected value is wrong.

## Dependencies - Who depends on you

| Persona | Relationship | Artifact |
|---------|---------|----------|
| Software Architect | YOU depend on them | Package structure and bounded contexts |
| Requirements Engineer | YOU depend on them | Clear requirements to implement |
| Technical Lead | Depends on YOU | PRs to review |
| QA Engineer | Depends on YOU | Testable code |
| DBA | YOU depend on them | Migrations and data model |

## How you are evaluated

- Rubric A3 (Technical Integrity): functional endpoints, passing tests
- Rubric A4 (Conscious Use of Copilot): deliberate switching between Chat, Edits, and Agent
- Criterion: "Small commits, reviewable PRs, tests written alongside the code"

- Paula
