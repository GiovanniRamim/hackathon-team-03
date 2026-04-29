---
name: Flaky Test Triage
description: "Use when a test is intermittent, when asked to investigate CI instability, 'quarantine a flaky test', or to build a flaky-test dashboard."
---

# Flaky Test Triage

## When to invoke
- CI fails and re-run passes.
- "This test is flaky - help me fix it."
- "Build a flaky-test quarantine process."

## Diagnostic workflow
1. **Reproduce**: run the test in isolation 50× with `--repeat-each 50` (Playwright) or `pytest --count=50`. If it fails <1× it's likely order-dependent.
2. **Categorize** the flake root cause:
   - **Async/timing** - missing await, race condition, hard-coded sleep
   - **Order dependency** - shared state, DB not cleaned, global singleton
   - **External dependency** - network, clock, filesystem
   - **Non-determinism** - iteration over unordered map, random seed
   - **Resource contention** - port, file lock, parallel worker collision
3. **Fix at the root**: replace sleeps with explicit waits, isolate state, pin random seeds, use test-scoped ports.
4. **Quarantine if unfixable in <1 day**: move to a `flaky/` tag, file a tracking issue, set a 30-day SLA to fix or delete.

## Quarantine policy
- Quarantined tests run but do not fail the build.
- Anything in quarantine >30 days gets deleted; a test that cannot be fixed is worse than no test.
- Dashboard: track flake rate per test over 100 runs. Anything >5% is quarantined automatically.

## Anti-patterns
- `sleep(1000)` - always wrong.
- Retrying the assertion with a loop - hides timing bugs.
- `@Retry(3)` - masks flakes and rewards bad tests.

## References
- [Google - Flaky Tests at Google](https://testing.googleblog.com/2016/05/flaky-tests-at-google-and-how-we.html)
- [Microsoft Research - Empirical Study of Flaky Tests](https://www.microsoft.com/en-us/research/publication/an-empirical-analysis-of-flaky-tests/)
