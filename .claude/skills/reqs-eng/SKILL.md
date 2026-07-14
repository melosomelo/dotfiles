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
