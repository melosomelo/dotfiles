---
name: reqs-engineering
description: General requirements engineering guidelines. Trigger automatically whenever the conversation touches requirements engineering topics — business requirements, user requirements, functional requirements, quality attributes, constraints, business rules, use cases, user classes, vision and scope, or related artifacts.
---

# Requirements Engineering Guidelines

> **Work in progress.** This skill is a placeholder being built over time. The sections below represent what has been defined so far; much remains to be added.

## Requirement types

| Type | What it looks like |
|------|-------------------|
| **Business requirement** | A high-level business objective or success metric ("we need to increase revenue by X", "the system must support Brazilian fiscal law") |
| **User requirement** | A goal or task a user needs to accomplish with the system ("as a scheduler, I need to see conflicts across rooms") — distinct from a use case already in the catalog |
| **Functional requirement** | A specific behavior the system must exhibit ("the system shall send a confirmation email", "the system must prevent double-booking") |
| **Quality attribute** | A non-functional constraint on how well the system performs ("response time under 2 seconds", "must be available 99.9% of the time") |
| **Constraint** | A design or implementation restriction that limits the solution space ("must run on PostgreSQL", "must comply with NF-e") |
| **Business rule** | A policy, regulation, or domain rule that shapes requirements but isn't itself a requirement ("a session cannot be scheduled in a room with fewer seats than the minimum occupancy threshold") |

## Passive watching

During any requirements conversation, stay alert for things the user says that match one of the types above but are not the current focus of the discussion. When you spot one:

1. Flag it explicitly: *"That sounds like a [type] — want me to capture it?"*
2. If the user confirms, log it to the parking lot.
3. If the user declines, drop it and continue.

Be mildly aggressive: err on the side of flagging. It is better to flag something the user dismisses than to let a real requirement slip by unnoticed.

Do not interrupt the flow of the conversation for every flag — weave it in naturally at a moment that doesn't derail the discussion.

## Explicit capture

The user may say things like:
- "capture this as a constraint"
- "log that as a business rule"
- "capture this" (no type specified)

**If no type is given:** Infer the type from context. State your inference when logging: *"Captured as a [type]."*

**If a type is given:** Validate it against the taxonomy above. If the type seems wrong, say so and explain why before logging. Example: *"That reads more like a functional requirement than a constraint — a constraint limits the solution space, while this describes a system behavior. Want me to log it as a functional requirement instead?"* If the user insists on their classification, respect it.

## Requirements directory structure

All requirements artifacts live under a single directory, referred to here as `<REQS_DIR>`. The default is `.spec/reqs`. The user may specify a different path at any time — if they do, use that path for the remainder of the session.

### Fundamental documents

Each fundamental document has a default filename inside `<REQS_DIR>`. The user may override any filename.

| Document | Default filename | Produced by |
|----------|-----------------|-------------|
| Vision and Scope | `vision-and-scope.md` | `/discover-biz-reqs` |
| User Classes Catalog | `user-classes.md` | `/discover-user-classes` |
| Parking Lot | `parking-lot.md` | passive capture (this skill) |

### Local files as pointers

A fundamental document's local file does not have to contain the document itself. It may instead contain a short description of where to find the real content — for example, a link to a Notion page, a Confluence URL, instructions for querying a database, or any other external source. When reading a fundamental document, always check whether the local file is a pointer rather than content, and follow it accordingly.

## Parking lot file

All captures go to `<REQS_DIR>/parking-lot.md` (default: `.spec/reqs/parking-lot.md`). If the file does not exist, create it — including any missing parent directories — with the header below before writing the first entry.

```markdown
# Requirements Parking Lot

Captures from requirements conversations — to be triaged and routed to the appropriate artifact.

| # | Type | Snippet | Context |
|---|------|---------|---------|
| 1 | Constraint | Must support PostgreSQL and MySQL | Discussing self-hosting requirements |
```

Each new capture gets the next sequential number. The **Snippet** is a concise restatement of the requirement in plain language. The **Context** is one short phrase describing what was being discussed when it surfaced.
