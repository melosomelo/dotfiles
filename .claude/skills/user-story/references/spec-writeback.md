# spec.md writeback — User Stories index only

After emitting `user-stories.md`, update **only** the `## User Stories` section
in `spec.md`. See [SKILL.md](../SKILL.md) § **Permissions on `spec.md`**.

---

## Layer model (Option A)

| Layer | File | Content |
| --- | --- | --- |
| **Contract** | `spec.md` → `## Requirements` | `[ID]-NN` with `WHEN/THEN/SHALL` (written by Specify — **not** this skill) |
| **Index** | `spec.md` → `## User Stories` | Summary table + links to `US-NN` in `user-stories.md` (**this skill**) |
| **Elaboration** | `user-stories.md` | Context, As/I want/so that, Given/When/Then AC, Out of Scope, Open Questions |
| **Proof** | `acceptance/*.feature` | Gherkin scenarios (via [gherkin-acceptance](../../gherkin-acceptance/SKILL.md)) |

Do **not** duplicate full story narratives or elaborated AC in `spec.md`.

---

## What to replace

Remove any legacy content under `## User Stories` (full `P1:` blocks, embedded
`As a…` narratives, per-story acceptance criteria, Independent Test lines).

Replace with the index table below — one row per `US-NN` from `user-stories.md`.

**Do not modify** any other `spec.md` section: Problem Statement, Goals,
Requirements, Out of Scope, Edge Cases, Requirement Traceability, Success Criteria,
Decisions Log, architecture notes, or header metadata beyond what already exists.

---

## Index table template

```markdown
## User Stories

Detailed stories: [user-stories.md](./user-stories.md)

| ID | Title | Priority | Requirements | Detail |
| --- | --- | --- | --- | --- |
| US-01 | [Short title matching user-stories.md] | P1 | [FEAT]-01, [FEAT]-02 | [§ US-01](./user-stories.md#us-01-[slug-from-title]) |
| US-02 | [Short title] | P1 | [FEAT]-03 | [§ US-02](./user-stories.md#us-02-[slug-from-title]) |
| US-03 | [Short title] | P2 | [FEAT]-04 | [§ US-03](./user-stories.md#us-03-[slug-from-title]) |
```

### Column rules

| Column | Rule |
| --- | --- |
| **ID** | `US-NN` — must match anchors in `user-stories.md` (`### US-NN:` headers) |
| **Title** | Same short title as in `user-stories.md` |
| **Priority** | `P1` / `P2` / `P3` — align with spec priorities and story **Priority** field |
| **Requirements** | Comma-separated requirement IDs from `spec.md` `## Requirements` or traceability |
| **Detail** | Markdown link to the matching `### US-NN:` anchor in `user-stories.md` |

### Anchor slug

GitHub-style slug from the `### US-NN: [Title]` header: lowercase, spaces to
hyphens, strip punctuation. Example: `### US-01: Keep project role assignments
in sync from 4PS` → `#us-01-keep-project-role-assignments-in-sync-from-4ps`.

---

## When `spec.md` does not exist yet

Emit `user-stories.md` only. Do **not** create `spec.md`. Flag that Specify
should run first for requirement IDs and the Requirements contract.

---

## When `## User Stories` section is missing

Insert the section **after** `## Out of Scope` (or after `## Requirements` if
Out of Scope is absent) and **before** the next major section (`## Edge Cases`,
`## Requirement Traceability`, etc.). Do not reorder or edit other sections.
