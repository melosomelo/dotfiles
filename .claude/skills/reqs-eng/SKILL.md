---
name: reqs-eng
description:
  Requirements engineering workflow with 2 phases and 10 activities overall. Helps with discovering,
  refining, modelling and prioritizing business, user, functional and nonfunctional requirements,
  with persistent memory across sessions. Works with both new (greenfield) and existing (brownfield)
  projects. Use when (1) the conversation touches requirement engineering topics — business
  requirements, user requirements (use cases and/or user stories), functional requirements, quality
  attributes, constraints, business rules, vision and scope, or related artifacts; (2) something has
  been implemented, discovered, or decided that may affect, invalidate, or extend existing
  requirements.
---

# Requirements Engineering

## Core principles and practices

- A requirement is a specification of what should be implemented. It is a description of how the
  system should behave, or of a system property or attribute. They may be a constraint on the
  development process of the system.
- When dealing with requirements information, try to fit each within the distinct types. See
  [`requirements-info-types.md`](./references/requirements-info-types.md) for more.
- Perfect (or complete) requirements are NEVER the goal. The goal should _always_ be to gain a
  shared understanding of requirements that is _good enough_ to allow construction of the next
  portion of the product - be that 1 or 100 percent of the entire product - to proceed at an
  _acceptable_ level of risk. This is called the **requirements baseline**.
- Take a proactive stance with regards to detecting and flagging potential requirements risks to the
  user. These issues tend to compound and go unnoticed until its blows up in your face. We want to
  avoid that as much as possible. Read [`requirements-risks`](./references/requirements-risks.md)
  for more.
- Differentiate between stakeholders, customers and users. Also consider the relation between these
  sets.
  - Stakeholders are people or groups that are actively involved in a project, is affected by it or
    can influence it.
  - Customers are people or groups who get direct or indirect value from the project.
  - Users interact (in)directly with the system in order to achieve something of value.
  - Users is a subset of customers, which is a subset of stakeholders.

## Project structure

```
.specs/
├── reqs/
|   ├── REQS.md # Main requirements doc for the project (business, user and functional requirements)
|   ├── VISION.md # Optional file that describes the business requirements in more detail if contents become too large for PROJECT.md (more info on this later)
|   ├── USERS.md # Optional file describes user classes and requirements in more detail if contents become too large for PROJECT.md (more info this later)
|   ├── SCOPE.md # Scope for the current iteration. MUST contain things that are defined in PROJECT.md or in VISION.md (if it exists)
|   ├── STATE.md # Memory: decisions, blockers, lessons, todos, deferred ideas
```

## Workflow

ALWAYS keep in mind that, even though this workflow is described linearly, requirements engineering
is almost always done iteratively. It's very common for something in a later step to make you go
back to a previous one, and this may (or not) make you go through the next steps again. Therefore
it's best to consider this a sensible default that may require adjustments for the current project.
Any specificities must be stored within STATE.md.

NEVER block the user from doing the work on a step just because the previous ones were not done.
Flag this as a potential issue and ask if this is truly what they want to do. If so, go along with
it.

1. Initial phase. Usually done at the beginning of a project.

   1.1. Define business requirements. See
   [`references/define-biz-reqs.md`](references/define-biz-reqs.md)

   1.2. Identify user classes. See
   [`references/identify-user-classes.md`](references/identify-user-classes.md)

   1.3. Identify user requirements. See
   [`references/identify-user-reqs.md`](references/identify-user-reqs.md)

2. Iterative phase. Usually done for each iteration/release of the project. _Activities TBD_.

## Passive watching

During any requirements conversation, stay alert for things the user says that match one of the
types above but are not the current focus of the discussion. When you spot one:

1. Flag it explicitly: _"That sounds like a [type] — want me to capture it?"_
2. If the user confirms, log it to the parking lot.
3. If the user declines, drop it and continue.

Be mildly aggressive: err on the side of flagging. It is better to flag something the user dismisses
than to let a real requirement slip by unnoticed.

Do not interrupt the flow of the conversation for every flag — weave it in naturally at a moment
that doesn't derail the discussion.

## Explicit capture

The user may say things like:

- "capture this as a constraint"
- "log that as a business rule"
- "capture this" (no type specified)

**If no type is given:** Infer the type from context. State your inference when logging: _"Captured
as a [type]."_

**If a type is given:** Validate it against the taxonomy above. If the type seems wrong, say so and
explain why before logging. Example: _"That reads more like a functional requirement than a
constraint — a constraint limits the solution space, while this describes a system behavior. Want me
to log it as a functional requirement instead?"_ If the user insists on their classification,
respect it.

### Cross-referencing between documents

When content in one fundamental document refers to something defined in another, link to it rather
than repeating it. This improves navigation and keeps the documents consistent.

Keep in mind that a fundamental document is not necessarily a single discrete file — it may be a
Notion database, a set of Confluence pages, a collection of scattered notes, or any other format.
When linking, target the most specific anchor available: a section heading, a named entry, a
database row, a page URL, or whatever the source format supports. If no direct anchor exists, link
to the closest containing unit and note what to look for.

### Local files as pointers

A fundamental document's local file does not have to contain the document itself. It may instead
contain a short description of where to find the real content — for example, a link to a Notion
page, a Confluence URL, instructions for querying a database, or any other external source. When
reading a fundamental document, always check whether the local file is a pointer rather than
content, and follow it accordingly.
