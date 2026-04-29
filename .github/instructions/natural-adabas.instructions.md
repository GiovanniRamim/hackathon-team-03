---
description: "Reading guide for Natural/Adabas legacy code — language patterns, FDT structure, naming conventions, batch flows"
applyTo: '**/*.nat,**/*.cpy,**/*.ddm,**/legacy/**'
---

# Natural/Adabas Legacy Code — Reading Guide

This file is activated when you open Natural programs, Adabas DDMs, or any file inside the `legacy/` directory. It teaches you how to read legacy code — it does not interpret any specific system for you.

## Natural Program Structure

A Natural program follows this skeleton:

```
DEFINE DATA
  LOCAL
    01 #MY-VARIABLE  (A20)    /* A = alphanumeric, 20 chars */
    01 #COUNTER      (N5)     /* N = numeric, 5 digits */
    01 #AMOUNT        (P9.2)   /* P = packed decimal, 9 digits + 2 decimal */
  END-DEFINE

  /* Main logic here */

END
```

Key blocks to recognize:

| Block | Purpose |
|-------|---------|
| `DEFINE DATA LOCAL` | Variable declarations scoped to this program |
| `DEFINE DATA PARAMETER` | Input/output variables received from a caller |
| `DEFINE DATA GLOBAL` | Shared across programs in a session (rare, fragile) |
| `INPUT` | Read from terminal (online) or sequential file (batch) |
| `DISPLAY` / `WRITE` | Output to screen or report |
| `MAP` | Screen layout definition (terminal UI) |

## CALLNAT vs PERFORM

- **`CALLNAT 'SUBPROG' parm1 parm2`** — calls an external subprogram (separate source file). Parameters are passed by reference unless marked `(AD=O)` for output-only.
- **`PERFORM subroutine-name`** — calls an internal subroutine defined with `DEFINE SUBROUTINE ... END-SUBROUTINE` within the same program.

When mapping call chains, `CALLNAT` is the important one — it crosses file boundaries.

## INCLUDE Copycodes

`INCLUDE copycode-name` inserts a shared code fragment at compile time, like a C `#include`. Copycodes (`.cpy` files) typically contain:

- Shared data area definitions (the "struct" of Natural)
- Common validation routines
- Standard error handling blocks

When you see `INCLUDE`, find the corresponding `.cpy` file to understand the full data layout.

## Adabas FDT (Field Definition Table)

Every Adabas file has an FDT that defines its fields. Think of it as the schema:

| Column | Meaning |
|--------|---------|
| Level | Hierarchy depth (01 = top, 02+ = children) |
| Name | 2-character short name (AA, AB, AC...) |
| Format | `A` = alpha, `N` = numeric, `P` = packed, `B` = binary, `D` = date, `T` = time |
| Length | Field size in bytes |
| Descriptor | `DE` = searchable index, `MU` = multi-value (array), `PE` = periodic group (repeating group) |

### MU Fields (Multiple-Value)

A field marked `MU` can hold multiple values (like an array). In Natural, accessed with an index: `FIELD(1)`, `FIELD(2)`, etc. Maximum occurrences defined in the FDT.

**Modern mapping**: `@ElementCollection` in JPA, or a JSONB column in PostgreSQL.

### PE Groups (Periodic Groups)

A `PE` group is a repeating group of related fields — like a row in an embedded table. For example, an address history where each occurrence has street, city, date.

**Modern mapping**: `@OneToMany` relationship with an embedded entity, or a JSONB array.

### Super-Descriptors

A super-descriptor combines multiple fields into a single searchable key (composite index). Notation like `SU = AA + AB(1-4)` means "concatenate field AA with the first 4 bytes of AB."

**Modern mapping**: `@Index(columnList = "col_a, col_b")` in JPA.

## 1990s Naming Conventions

Legacy Natural codebases use prefix-based naming. Common patterns include:

| Prefix Pattern | Typical Meaning |
|---|---|
| `BN-` or `BATCH-` | Batch program or batch-related variable |
| `PG-` or `PROG-` | Main program |
| `PS-` or `SUB-` | Subprogram (called via CALLNAT) |
| `AU-` or `AUT-` | Authorization or audit related |
| `#` prefix on variables | Local working variable (Natural convention) |
| `+` prefix on variables | Parameter variable passed from caller |

These are conventions, not rules — verify by reading the code, not by assuming.

## Batch Job Patterns

Batch Natural programs typically follow this structure:

```
READ WORK FILE 1 record
  /* process each record */
  AT END OF DATA
    /* final totals / cleanup */
  END-ENDDATA
END-WORK
```

Control-break reporting uses:

```
READ logical-file BY descriptor
  AT BREAK OF descriptor
    /* subtotal when descriptor value changes */
  BEFORE BREAK PROCESSING
    /* detail line for each record */
  END-BREAK
END-READ
```

## Packed Decimal Handling

Packed decimal (`P` format) stores digits efficiently: each byte holds two digits, the last nibble is the sign (C=positive, D=negative). Common in financial calculations.

When mapping to Java: always use `BigDecimal`, never `double` or `float`. Packed fields with format `P9.2` mean 9 total digits with 2 decimal places → `BigDecimal` with `scale(2)`.

## Reading Strategy

When approaching a legacy program for the first time:

1. **Start with DEFINE DATA** — understand the variables and their types
2. **Find the main READ or FIND** — this tells you what data the program processes
3. **Trace the CALLNAT calls** — these are the dependencies
4. **Look for INCLUDE copycodes** — these expand the data definitions
5. **Check for AT BREAK / AT END OF DATA** — these reveal the reporting or processing logic
6. **Note any ESCAPE or ON ERROR** — these are error handling paths
