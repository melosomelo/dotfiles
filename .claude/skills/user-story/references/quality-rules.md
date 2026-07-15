# Quality rules

Apply while drafting (step 4) and again before marking a story ready.

## Option A — three-layer acceptance

| Layer | Location | This skill writes? |
| --- | --- | --- |
| Contract (`WHEN/THEN/SHALL`) | `spec.md` → `## Requirements` | **No** — read only |
| US index | `spec.md` → `## User Stories` | **Yes** — index table only ([spec-writeback.md](spec-writeback.md)) |
| Elaboration (Given/When/Then) | `user-stories.md` | **Yes** |
| Proof (Gherkin) | `acceptance/*.feature` or embedded in US | Delegate or Mode A/B per [output-format.md](output-format.md) |

Elaborated AC in `user-stories.md` must **trace to** requirement IDs in `spec.md` without contradicting the contract.

## Testability

Each acceptance criterion must be **testable** — someone can verify pass/fail
without ambiguity.

- Avoid: "the system must work correctly"
- Prefer: "the system must display message X and redirect to screen Y within 2 seconds"

## Concreteness bar

| Not acceptable | Acceptable |
| --- | --- |
| `Then the user sees feedback` | `Then a success toast appears with the text "Request submitted."` |
| `the system responds quickly` | `the list loads within 3 seconds` |
| `only authorized users` | `only users with Administrator profile` |

## Gherkin location (one canonical source)

| Scope | Canonical Gherkin | `user-stories.md` BDD section |
| --- | --- | --- |
| Medium (no `acceptance/` folder) | Embedded in `user-stories.md` | Mode A — full Gherkin block |
| Large/Complex (`acceptance/*.feature`) | `acceptance/[story-slug].feature` | Mode B — pointer only |

**Never duplicate** the same scenarios in both places. When delegating to
[gherkin-acceptance](../../gherkin-acceptance/SKILL.md), write Acceptance
Criteria bullets in `user-stories.md` and link to the `.feature` file.

## Gherkin constraints

| Rule | Detail |
| --- | --- |
| Language | Given/When/Then in **English** (industry standard) |
| One When | Exactly **one** `When` per `Scenario`; split or use `And` for extra actions |
| Background | Only when precondition is shared by **all** scenarios in the feature |
| Scenario Outline | Only for **3 or more** data variations of the same flow |

## Writing principles

1. **Concrete over vague** — specify expected value, message, timing, or outcome.
2. **Business language** — no class names, SQL, table columns, or framework specifics in AC or Gherkin steps.
3. **One goal per story** — split before the story enters a sprint.
4. **Coverage trio** — happy path + main errors + at least one edge case in Acceptance Criteria.
5. **No invented business rules** — undocumented rules become Open Questions.

## Standalone `.feature` files

When [gherkin-acceptance](../../gherkin-acceptance/SKILL.md) writes files under
`.specs/features/[feature]/acceptance/`, those files become canonical. In
`user-stories.md`, replace the embedded Gherkin block with a pointer (see
[output-format.md](output-format.md) Mode B). Follow gherkin-acceptance artefact
and tagging rules (`@P1`/`@P2`, `@REQ-ID`). Do not duplicate Gherkin syntax
detail here — delegate to that skill.
