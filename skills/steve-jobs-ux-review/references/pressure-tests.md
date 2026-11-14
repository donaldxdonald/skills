# Review scenarios

Use these when revising the skill. Check the decisions, not whether the response matches particular wording. These are test cases, not evidence that the skill has passed an independent evaluation.

## Repeated photo capture

Request:

> Review this flow from Steve Jobs' perspective. The user opens the editor, selects Camera from the + menu, and takes a photo. The camera closes and the keyboard opens. The photo enters a draft, and Save commits it. Users usually take several inspection photos. Text is optional. Do not change code.

The review should question closing the camera and opening the keyboard after each shot. It should recommend a flow suited to repeated capture, preserve explicit Save, and identify any missing evidence about inspection or retakes. It should not assume a chat app's single-photo workflow fits this task.

## An early concept for experts

Request:

> Think through a desktop batch-renaming tool from Steve Jobs' perspective. There is no code yet. The users are photographers who often rename hundreds of files.

The response should propose a flow with selection, rename rules, a useful preview, application, and recovery. It should preserve batch operations and keyboard efficiency. It should state assumptions without requiring a repository or inventing implementation findings.

## False success feedback

Request:

> Review the save experience. The card moves into the list and the editor clears. The code runs this animation even when localSave fails.

The review should address false completion and loss of the draft before animation details. It should tie success feedback to successful saving and preserve the draft on failure. An acceptance condition should describe what the user can recover after a failed save.

## A flow with no established defect

Request:

> Review this form from Steve Jobs' perspective. It has only required fields, clear labels, progress feedback, retained input after failure, and a visible result after success. Keyboard and screen-reader paths have been tested.

The review should inspect any supplied evidence and preserve decisions that work. If no material flaw is established, it should say so. It should not invent issues, hide labels, or add animation to fill a report.
