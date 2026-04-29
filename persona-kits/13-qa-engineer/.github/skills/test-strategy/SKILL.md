---
name: Test Strategy Designer
description: "Use when asked to design a test strategy, choose a test pyramid shape, define coverage targets, or evaluate testing investments across unit / integration / E2E layers."
---

# Test Strategy Designer

## When to invoke
- "Design a test strategy for…"
- "How much unit vs integration vs E2E testing?"
- "What coverage target is right?"
- "Audit our test pyramid."

## Workflow
1. **Inventory** the code under test: modules, public APIs, external integrations, critical paths.
2. **Classify risk** per module (P0 / P1 / P2) based on blast radius if it breaks.
3. **Allocate pyramid**: aim for 70% unit, 20% integration, 10% E2E as a starting point; justify deviations.
4. **Set coverage targets**: 80% line coverage baseline, 90% for P0 modules, branch coverage tracked separately.
5. **Define the flaky-test budget**: max 1% flaky rate; anything above triggers quarantine.
6. **Pick tools per layer**: unit (Vitest/JUnit/pytest), integration (Testcontainers), E2E (Playwright).
7. **Output**: a one-page strategy doc with layer targets, tools, coverage thresholds, and quarantine rules.

## Heuristics
- If an E2E test can be rewritten as integration + contract test, do it - E2E is expensive and flaky.
- Contract tests beat mocks for anything that crosses a service boundary.
- Mutation testing (Stryker, PIT) is the only honest way to detect phantom tests.

## References
- [Google Testing Blog - Test Sizes](https://testing.googleblog.com/2010/12/test-sizes.html)
- [ISTQB Foundation Syllabus](https://www.istqb.org/certifications/certified-tester-foundation-level)
- [Martin Fowler - Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)
