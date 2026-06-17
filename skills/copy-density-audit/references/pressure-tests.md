# Pressure Tests

Use these scenarios to validate whether the skill changes agent behavior. A good result removes redundant text and proposes UI structure, not just shorter prose.

## Scenario 1: AI SaaS Dashboard

Prompt:

```text
Review this dashboard UI copy. The first screen has a welcome paragraph, three paragraphs explaining revenue/customer/activity cards, and helper text under every chart.
```

Expected behavior:

- Flag the welcome paragraph as P1 if it pushes metrics or actions down.
- Convert card explanations into headings, metric labels, deltas, badges, or chart captions.
- Preserve state/error copy if charts are empty or stale.
- End with a concrete revised copy budget.

Failure signs:

- Only rewrites the paragraphs to shorter paragraphs.
- Keeps marketing phrases like "unlock insights" in the app surface.
- Does not identify the primary workflow.

## Scenario 2: Form With Long Instructions

Prompt:

```text
Audit a report generator form with long explanatory text above each input: report type, date range, recipients, and export format.
```

Expected behavior:

- Convert choices into controls and labels.
- Keep helper text only where format, consequence, or constraints are not obvious.
- Move rare details into progressive disclosure.

Failure signs:

- Removes necessary validation guidance.
- Suggests tooltips for essential instructions.
- Leaves labels generic and compensates with helper text.

## Scenario 3: Empty State As Product Pitch

Prompt:

```text
Audit an empty state that explains the whole product and lists five benefits before showing the primary action.
```

Expected behavior:

- Reduce to one state sentence and one primary action.
- Preserve a secondary example or template only if it helps the user start.
- Mark benefit paragraphs as marketing copy in an app surface.

Failure signs:

- Keeps multiple benefit bullets.
- Adds a large onboarding card instead of simplifying the empty state.

## Scenario 4: Legitimate Long Copy

Prompt:

```text
Review a legal consent screen before deleting a workspace. It contains warnings, consequences, and confirmation requirements.
```

Expected behavior:

- Avoid aggressive reduction.
- Preserve consequences, irreversible actions, and confirmation requirements.
- Improve structure with bullets, grouping, and stronger labels.

Failure signs:

- Deletes warnings because they are long.
- Moves essential risk explanation into a tooltip.
