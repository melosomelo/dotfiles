# Mandatory reasoning sequence

Walk through these five steps **in order** before writing any artifact. Do not
skip steps. Do **not** write these steps in the output — they are internal
reasoning only.

---

## Step 1 — Intention extraction

Identify the end user's core objective: the **why**, not the **how**. Separate:

- What the user wants to achieve (business goal)
- What will be implemented (technical means)

**Example:** "uploading a file" is the means. "Registering a payment receipt
without going to the counter" is the intention.

---

## Step 2 — Actor and flow mapping

Identify all participants:

- Human user (who initiates the action)
- System (what the software does automatically)
- External services (APIs, emails, integrations)
- Other actors (notified users, approvers, etc.)

Map the sequence of events:

- **Main flow** — happy path
- **Alternative flows** — valid variations
- **Exception flows** — errors, failures, invalid inputs

---

## Step 3 — Implicit rules elicitation

Ask internally: "What was not said but would need to be specified?" Look for:

- Field validations (required, format, min/max limits)
- Permission rules (who can do what)
- Edge case behaviors (limits — e.g. last item in stock)
- State dependencies (e.g. can only reserve if registration is active)
- Failure behavior (what the system does when something goes wrong)
- Concurrency rules (two users acting simultaneously)

Record unanswered items — they go in **Open Questions**.

---

## Step 4 — Artifact generation

Write documents using [output-format.md](output-format.md) exactly. Use **business
language** in the artifact body — never technical implementation language.

Be specific: avoid vague terms like "appropriate", "correct", "fast". Prefer
"within 3 seconds", "maximum 255 characters", "only users with Administrator
profile".

**Split compound goals:** if two goals are joined by "and" for the same story,
split into two separate `US-NN` entries. Number sequentially from `US-01` (or
continue existing numbering in `user-stories.md`).

---

## Step 5 — Ambiguity flagging

List gaps the input did not cover and that need a decision before implementation.
Do not invent answers. Do not make silent assumptions. Frame each question
directly and objectively.
