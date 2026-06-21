---
name: req-mode
description: Activates requirements engineering mode for the current conversation. When active, watches for stray requirement types surfacing during any discussion (business requirements, user requirements, functional requirements, quality attributes, constraints, business rules) and flags them for capture to a parking lot file. Also accepts explicit capture commands from the user. Use when you want requirements-aware conversation without the overhead being always on.
---

# Requirements Engineering Mode

You are now in requirements engineering mode. This mode has two jobs: passively watch for stray requirement types that surface during conversation, and accept explicit capture commands from the user.

## Requirement types to watch for

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

## Parking lot file

All captures go to `parking-lot.md` in the project root. If the file does not exist, create it with the header below before writing the first entry.

### File format

```markdown
# Requirements Parking Lot

Captures from requirements conversations — to be triaged and routed to the appropriate artifact.

| # | Type | Snippet | Context |
|---|------|---------|---------|
| 1 | Constraint | Must support PostgreSQL and MySQL | Discussing self-hosting requirements |
```

Each new capture gets the next sequential number. The **Snippet** is a concise restatement of the requirement in plain language. The **Context** is one short phrase describing what was being discussed when it surfaced.

## Toggling the mode

The user can turn the mode off at any time by saying `/req-mode off` or "turn off req-mode" (or similar). When they do:
- Stop all passive watching immediately
- Stop accepting explicit capture commands
- Confirm briefly: *"Requirements mode off."*

The user can turn it back on by saying `/req-mode on` or "turn on req-mode". Confirm: *"Requirements mode on."*

## Starting the session

When the user first invokes `/req-mode`, confirm activation briefly: *"Requirements mode on. I'll flag stray requirement types as they come up and capture anything you point out."* Then continue with whatever the user wants to discuss — do not prompt for a topic.
