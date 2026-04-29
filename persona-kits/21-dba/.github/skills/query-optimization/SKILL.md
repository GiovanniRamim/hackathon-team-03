---
name: Query Optimization
description: "Use when investigating slow queries, designing indexes, or reviewing execution plans. Triggers on 'slow query', 'explain plan', 'index', 'query tuning', 'N+1', 'table scan'."
---

# Query Optimization

## When to invoke
- "This query is slow."
- "Why is it not using the index?"
- "Should I add an index on…?"
- "Review this EXPLAIN output."

## Diagnostic workflow
1. **Measure before you tune** - capture baseline (p50/p95 latency, rows examined, rows returned, logical reads).
2. **Get the plan**: `EXPLAIN (ANALYZE, BUFFERS)` in PostgreSQL, `EXPLAIN ANALYZE FORMAT=JSON` in MySQL 8, `SET STATISTICS IO, TIME ON` in SQL Server.
3. **Look for the usual suspects**:
   - **Seq Scan / Table Scan** on a large table with a selective predicate → missing index
   - **Rows estimate off by >10×** → stale statistics, run `ANALYZE`
   - **Nested Loop with high outer rows** → should be Hash/Merge join
   - **Sort spilled to disk** → `work_mem` too low or missing index on ORDER BY
   - **Filter after join** instead of pushed down → rewrite or add predicate index
4. **Propose the smallest change**: index, rewrite, statistics refresh, parameter tweak.
5. **Validate**: rerun with ANALYZE, confirm plan changed and latency dropped. Never "ship and hope."

## Index design heuristics
- **Equality columns first**, then range, then sort (the ESR rule).
- **Covering index** (INCLUDE columns) for read-heavy queries avoids heap lookups.
- **Partial index** for highly selective filters on skewed data (`WHERE status = 'pending'`).
- Every index costs writes - justify each one.

## Anti-patterns
- `SELECT *` in hot paths - forces heap access, breaks covering indexes.
- `WHERE func(col) = x` - kills index use; store computed column or use expression index.
- N+1 from ORM - fix at the ORM (eager load), not with an index.
- "Add index on every column" - wastes storage and slows writes.

## References
- [Use The Index, Luke!](https://use-the-index-luke.com/)
- [PostgreSQL - Performance Tips](https://www.postgresql.org/docs/current/performance-tips.html)
- [SQL Server - Query Store](https://learn.microsoft.com/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store)
