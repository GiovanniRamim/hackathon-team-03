---
name: TDD Workflow
description: "Use when practicing test-driven development, writing a failing test first, or coaching red-green-refactor. Triggers on 'TDD', 'red-green-refactor', 'test first', 'failing test', 'write a test'."
---

# TDD Workflow

## When to invoke
- Starting a new behavior or bug fix.
- Pairing / mobbing on unfamiliar code and wanting a safety net.
- When changes keep breaking things nobody expected.

## The loop
```
RED    → write the smallest failing test that expresses the next behavior
GREEN  → write the smallest code that makes it pass
REFACTOR → improve design; tests stay green
```
Commit at each green. One behavior per cycle.

## Rules
1. **No production code without a failing test.** No test, no change.
2. **One failing test at a time.** Never have two reds.
3. **Smallest step that fails.** If your first test is hard to write, the design is telling you something.
4. **Test names describe behavior**, not implementation: `calculates_tax_for_tax_exempt_customer`, not `test_method1`.
5. **Given-When-Then / Arrange-Act-Assert** structure in the test body.
6. **Refactor phase is not optional** - that's where most of the value lives.

## Choosing the next test
Order tests to drive the design:
- Start with the simplest non-trivial case (the "0→1" or happy path with one input).
- Then add a single variation (a boundary, a branch, an error).
- Resist writing a giant test that covers everything.

## Faking and stubbing
- Use a test double only when the real collaborator is slow, non-deterministic, or not yet written.
- Don't mock types you don't own - wrap them in a thin seam first.
- A test that mocks everything tests nothing.

## When TDD is hard, it's usually the design
- Hard to construct the object under test → too many collaborators, violate SRP.
- Can't assert without reading three other objects → Law of Demeter / encapsulation issue.
- Have to mock the world → hidden coupling; introduce an abstraction.

## Anti-patterns
- Writing the code, then the test (that's verification, not TDD).
- Skipping the refactor phase.
- Tests that duplicate the implementation (change detectors).
- Giant test fixtures shared across files - brittle.
- Asserting on implementation details (private methods, exact SQL string).

## References
- [Kent Beck - Test Driven Development: By Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/)
- [GOOS - Growing Object-Oriented Software, Guided by Tests](http://www.growing-object-oriented-software.com/)
- [Martin Fowler - Mocks Aren't Stubs](https://martinfowler.com/articles/mocksArentStubs.html)
