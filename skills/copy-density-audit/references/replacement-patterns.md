# Replacement Patterns

Use this reference when a screen has paragraphs or repeated helper text that should become interface structure.

## Table of Contents

- Paragraph to control
- Paragraph to layout
- Paragraph to data
- Paragraph to state
- Paragraph to progressive disclosure
- Common traps

## Paragraph to Control

Use controls when text explains available choices.

Bad:

```text
Use this section to filter your projects by status, owner, and due date so you can focus on what needs attention.
```

Better:

```text
Status [All v]  Owner [Any v]  Due [This week v]
```

Patterns:

- "Choose between..." -> tabs or segmented control.
- "Turn on/off..." -> toggle.
- "Filter by..." -> filter bar.
- "Sort by..." -> sort menu.
- "Select a range..." -> date/range picker.

## Paragraph to Layout

Use layout when text explains relationships or groups.

Bad:

```text
The metrics below show how your team is performing across acquisition, activation, and retention.
```

Better:

```text
Acquisition | Activation | Retention
```

Patterns:

- Comparison explanation -> table or columns.
- Step explanation -> stepper or timeline.
- "This belongs to..." -> grouped section.
- "Details about selected item..." -> side panel.

## Paragraph to Data

Use examples or defaults when text explains an abstract concept.

Bad:

```text
Enter a prompt that describes what you want the assistant to do in enough detail.
```

Better:

```text
Prompt
Placeholder: Summarize new support tickets and group them by urgency.
```

Patterns:

- Explanation of valid input -> placeholder or example.
- Explanation of output -> preview.
- Explanation of report contents -> sample row.
- Explanation of default behavior -> pre-filled default.

## Paragraph to State

Use state copy when the user needs to understand what happened.

Bad:

```text
There are currently no connected sources, which means the dashboard cannot show any metrics until a source is connected.
```

Better:

```text
No sources connected.
[Connect source]
```

Patterns:

- Empty state -> one sentence plus action.
- Error -> what failed, why if known, next action.
- Loading -> noun phrase, not explanation.
- Success -> confirmation plus next useful action.

## Paragraph to Progressive Disclosure

Use progressive disclosure when information is useful but not needed for the default path.

Patterns:

- Rare edge cases -> help drawer.
- Field nuance -> tooltip or inline help.
- Advanced setting details -> "Advanced" disclosure.
- Policy or compliance note -> linked details.

Do not move essential instructions into tooltips. If the user must read it to complete the task, keep it visible and shorten it.

## Common Traps

- Replacing a paragraph with many badges is still clutter.
- Tooltips should not become hidden documentation.
- Empty states should not sell the whole product.
- Helper text under every field usually means the form labels are weak.
- Marketing claims inside a work surface make the UI harder to trust.
