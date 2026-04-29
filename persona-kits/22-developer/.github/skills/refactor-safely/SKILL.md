---
name: Refactor Safely
description: "Use when refactoring legacy code, extracting a service, or making behavior-preserving changes. Triggers on 'refactor', 'legacy code', 'strangler fig', 'characterization test', 'mikado method'."
---

# Refactor Safely

## When to invoke
- Working in code without sufficient tests.
- Splitting a monolith / extracting a service.
- A change is "one line" but touches a scary path.

## First rule
**Refactoring is behavior-preserving.** If you can't prove behavior is preserved, it's not a refactor - it's a rewrite. Put characterization tests in place first.

## The workflow
1. **Characterize** - write tests that pin down current behavior, including quirks. Don't fix bugs yet; the goal is a safety net, not correctness.
2. **Small reversible steps** - one behavior-preserving transformation at a time. Commit between each.
3. **Keep green** - run tests after every step. Revert immediately if red and you can't see why.
4. **Separate refactor commits from behavior-change commits** - reviewers can focus, bisect stays useful.
5. **Land often** - long-lived refactor branches rot.

## Patterns
### Strangler Fig (for systems)
1. Put a façade (proxy, router, feature flag) in front of the old system.
2. Route a thin slice of traffic to the new implementation.
3. Grow the new implementation slice by slice; shrink the old.
4. Delete the old when its traffic is zero.

### Mikado Method (for code)
1. Write down the goal.
2. Naively attempt it; note what breaks as **prerequisites**.
3. Revert. Tackle one prerequisite first. Recurse.
4. Leaves get done first; the original goal falls out last.

### Branch by Abstraction
Introduce an interface, migrate callers to it, swap implementations, retire the old one - all without a long-lived branch.

## Characterization tests - how
- Run the code on representative inputs, record the output (golden files / snapshot tests).
- Prefer observing from the outside (HTTP, CLI, DB state) - resilient to internal refactor.
- Cover the weird cases too; they're what breaks.
- Accept that some behavior is *bugs you're now pinning* - mark them, fix after the safety net exists.

## Anti-patterns
- "Refactor" PRs that also fix bugs, change APIs, and rename files - impossible to review, impossible to revert.
- Big-bang rewrite with no delivery for months.
- Deleting old code before the new code handles 100% of traffic.
- Refactoring without tests, trusting manual verification on a happy path.

## References
- [Martin Fowler - Refactoring (2nd ed.)](https://martinfowler.com/books/refactoring.html)
- [Michael Feathers - Working Effectively with Legacy Code](https://www.oreilly.com/library/view/working-effectively-with/0131177052/)
- [Mikado Method](https://mikadomethod.info/)
- [Fowler - Strangler Fig Application](https://martinfowler.com/bliki/StranglerFigApplication.html)
