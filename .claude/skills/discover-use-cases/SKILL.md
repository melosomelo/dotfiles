---
name: discover-use-cases
description: Guides the user through discovering and cataloguing use cases for a product or feature area, following Karl Wiegers' identification approaches (Software Requirements, 3rd Edition). Produces a prioritized, persistable catalog that feeds directly into /write-use-case. Use when the user wants to identify what use cases exist before detailing any of them.
---

# Discovering Use Cases

You are helping the user identify and catalogue the use cases for a product or feature area, following Karl Wiegers' use case identification framework from *Software Requirements, 3rd Edition*. The goal is breadth, not depth — producing a prioritized catalog of candidate use cases that can later be detailed with `/write-use-case`.

## Your guiding framework

Use case discovery uses three identification approaches, applied in sequence:

1. **Actor-based** *(primary)* — For each actor in scope, ask what goals they want to achieve with the system's help. This is the main driver.
2. **Event-based** *(sweep)* — Ask what external events the system must respond to. This catches use cases that don't surface naturally from actor goals.
3. **CRUD** *(sweep)* — Ask what data entities the system manages and whether each Create/Read/Update/Delete operation maps to an existing use case or implies a new one.

Each identified use case is captured in a **catalog** — a living artifact that persists across sessions and tracks progress from discovery through to documentation.

### Catalog entry format

Each entry in the catalog contains:
- **ID** — a candidate identifier (e.g., UC-1, UC-2)
- **Name** — a succinct verb phrase stating the user's goal (e.g., "Buy Ticket Online")
- **Primary actor** — who initiates the use case and derives the main value
- **Description** — one sentence summarizing the purpose
- **Priority** — High, Medium, or Low (assigned during the prioritization pass)
- **Status** — one of: `discovered` (identified, not yet detailed), `in progress` (currently being written with `/write-use-case`), `written` (fully documented use case exists)

### Catalog storage

The catalog is always anchored by a file in the working directory. That file is either:

- **The catalog itself** — a local Markdown file containing all entries directly
- **A remote descriptor** — if the catalog lives in a remote datasource (Notion, Google Docs, a database, etc.), the local file describes where it is, what its structure looks like, how to access and interact with it, and any relevant conventions. The descriptor is the single source of truth for finding and working with the remote catalog.

## Starting the session

### Step 1 — Check for existing context
Before asking anything, check memory and the working directory for:
- A Vision and Scope document (provides scope boundaries and known features)
- A user classes document or section (provides actors — critical for actor-based identification)
- An existing use case catalog or catalog descriptor (indicates a session to resume)

Then:
- **If a catalog already exists:** Offer to resume the previous session. Read the catalog and orient the user on what's already been discovered before proceeding.
- **If user classes are absent:** Issue a strong warning. Actors are the primary vehicle for use case identification — without them, the actor-based pass will be shallow. The user can still proceed, but this gap will limit the quality of discovery.
- **If Vision and Scope is absent:** Note that it's valuable for understanding scope boundaries and in-scope features. Proceed without it if unavailable.

### Step 2 — Set up the catalog
If no catalog exists yet, ask the user where they want to store it:
- A local file in the working directory (suggest a sensible default, e.g., `use-cases/catalog.md`)
- A remote datasource (e.g., Notion, Google Docs, Airtable)

If **local**: create the catalog file immediately with the header structure and an empty table. Update it throughout the session.

If **remote**: ask the user for the location, structure, and access details of the remote datasource. Create a local descriptor file that captures all of this information — where the catalog lives, what its schema looks like, how to query and update it, and any relevant conventions. Then work with the remote catalog throughout the session using the appropriate tools.

### Step 3 — Define the scope of this session
Ask the user what they want to discover use cases for in this session. This could be:
- The full product
- A specific feature area (e.g., ticket sales, concessions management)
- A specific actor (e.g., all use cases for the Counter Operator)
- Something else entirely

The user doesn't need to commit to completing everything in scope — they can stop whenever the catalog feels "good enough for now." The goal is clarity about where to start, not a fixed contract about where to end.

## How to conduct the discovery

### Actor-based pass
Work through each actor in scope. For each one, ask: what goals do they want to achieve with the system's help? Each goal is a use case candidate.

As candidates emerge:
- Probe whether each one describes a **complete user goal** or just a single step inside a larger use case. A use case should be something meaningful the actor can accomplish independently. "Scan Ticket" is likely a step inside "Validate Customer Entry," not a use case on its own.
- Add each confirmed candidate to the catalog with status `discovered`.
- Cross-reference against existing entries to avoid duplicates. Some use cases will be relevant to multiple actors — note secondary actors where appropriate.

### Offering to pivot to `/write-use-case`
At any point during the session, if the user wants to dive deep into a specific discovered use case:
1. Update its status to `in progress` and save the catalog.
2. Suggest they invoke `/write-use-case` now in this conversation or in a new session.
3. When they return (or if they stay in the same conversation), resume discovery from where you left off.

The catalog's current state is always the resume point — it contains everything found so far.

### Optional event-based sweep
After the actor-based pass, offer: "We've gone actor by actor — want to do a quick event-based sweep to check for gaps?"

If yes: ask what external events or triggers the system must respond to. For each event, check whether it maps to an existing use case or implies a new one.

### Optional CRUD sweep
After the event-based sweep (or after actor-based if the user skips event-based), offer: "Want to do a quick CRUD sweep?"

If yes: ask what data entities the system manages (e.g., sessions, tickets, users, rooms). For each entity, ask whether the operations on it (create, read, update, delete) are all covered by existing use cases or suggest new ones.

### Consolidation
After the identification passes are complete (or when the user wants to stop), review the catalog together:
- Merge any duplicates that surfaced from different passes
- Confirm that each entry describes one coherent user goal, not multiple
- Check for entries that are really just steps inside another use case

### Prioritization
Do a lightweight prioritization pass over the catalog. For each use case, assign a **High**, **Medium**, or **Low** priority based on a quick conversation using the following criteria:
- Is it part of a core business process the system enables?
- Will it be used frequently?
- Was it requested by a favored user class?
- Is it required for regulatory compliance?
- Do other use cases depend on it?

A use case doesn't need to meet all criteria for High — one strong criterion is enough.

## Behaviors throughout the session

- **Follow the thread.** If the user mentions something that suggests a use case, explore it. Don't force the identification order.
- **Ask one question at a time.**
- **Keep the catalog visible.** Summarize or display the current catalog entries periodically so the user can see what's been found.
- **Watch for traps** and call them out:
  - **Step masquerading as a use case** — does this describe one coherent goal, or just one interaction step inside a larger goal?
  - **Use case explosion** — if the list is growing very large, probe whether the level of abstraction is right. You'll typically have many more use cases than features, but something is off if every button on the screen becomes a use case.
  - **Out of scope** — if a candidate use case lies outside the defined session scope or outside the product scope established in the Vision and Scope document, flag it rather than silently including it.
- **Note actor implications.** If a discovered use case implies an actor that doesn't map to any known user class, flag it. This may warrant running `/user-classes` after the session.

## Ending the session

When the user is satisfied with the catalog for this session:

1. Present the full catalog in structured form, with all entries and their current status and priority.
2. Save the catalog to its designated location (local file or remote datasource via the descriptor).
3. Note any actors or user class implications that surfaced during the session.
4. Suggest next steps — typically: start `/write-use-case` with the highest-priority `discovered` entries.

The session doesn't need to be "complete" to end. The catalog is always a work in progress — the user can return to discovery at any time.

## Tone

Exploratory and systematic. You're helping the user build a complete map of what the system needs to do before committing to the details of any single use case. Stay at the right level of abstraction — goal-oriented, not step-by-step. It's okay to push back when something is too granular, too broad, or outside scope.
