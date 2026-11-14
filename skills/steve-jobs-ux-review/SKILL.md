---
name: steve-jobs-ux-review
description: "Think through or review UI/UX from a Steve Jobs-inspired perspective. Use when asked to think like Steve Jobs about a product or challenge the simplicity and usability of a flow. Supports early concepts and existing interfaces."
---

# Steve Jobs UX review

Review the experience through user intent, simplicity, clear defaults, and attention to detail. Treat Steve Jobs as a reference for this approach. Do not impersonate him, invent quotes, or use his presumed approval as evidence.

## Establish the task

Identify the user, what they want to accomplish, and how they will know they have succeeded. Use the context provided. State assumptions when needed, and ask only if the answer would change the recommendation.

For a concept, propose and challenge a flow. For an existing interface, inspect the flow and identify problems. Keep the review within the requested task, and edit the implementation only when authorized.

Respect product requirements and the intended audience. Question implementation choices that make users work around technical constraints. An expert's repeated task may need different controls from a beginner's first attempt.

## Walk the complete flow

Follow the task from discovering the entry point to taking action, seeing the result, and continuing. Check the relevant cancellation or failure path.

At each step, ask:

- Does the user know what to do next?
- What must they decide, remember, repeat, or switch away from?
- Can they tell what happened and where their content went?
- Can they inspect or correct the result before committing?
- Does going back or recovering from failure preserve their work?

Count decisions and interruptions as well as taps. Removing a step helps only if the user retains the understanding and control needed to finish the task.

For an existing product, operate the relevant flow when possible and inspect supplied code, screenshots, or recordings. Ground findings in a reproducible action, screen, timestamp, or verified code location. Separate observation from inference. A screenshot cannot establish timing, and a simulator cannot establish real camera responsiveness. Missing evidence should limit a claim, not prevent useful analysis.

## Challenge the design

### Remove work that does not serve the user

Identify the primary action in each state. For a questionable step, control, or explanation, ask what the user would lose if it disappeared. Remove it if nothing useful is lost. Move secondary controls to where users need them. Keep inspection, correction, and deliberate commitment when they protect the task.

Do not confuse an empty screen with an easy interface. Hiding an essential action behind an unlabeled icon or gesture can increase the work.

### Choose defaults that fit the intent

For each automatic behavior, identify the intent it assumes and test it against a common alternative. Opening a keyboard after a photo may help someone add a caption and interrupt someone taking several photos.

Use a default when the next step is predictable and a wrong choice is easy to reverse. Preserve control when automation could lose work, commit an action, or repeatedly interrupt the task. Add a setting only when a lasting user preference requires it. Do not make users configure their way out of a weak design decision.

### Preserve context and make completion clear

Check transitions between screens and input methods. Preserve the content, focus, and position the user still needs. Make the result easy to find.

Distinguish acknowledgement from completion. Capturing a photo, adding it to a draft, saving it, and sending it are separate actions. Feedback must reflect the action that actually succeeded. Check the interruptions most relevant to this task, such as denied permission, slow processing, or failed saving, and provide a clear way to continue.

### Refine the details that affect use

Once the flow works, inspect hierarchy, labels, reachability, feedback timing, and content visibility. Explain the user consequence of each issue. Check whether keyboard access, screen readers, larger text, or reduced motion expose a problem in this flow.

Use motion to explain a change or show where content went. Do not add animation to disguise extra steps or delay a repeated action. Respect the product's identity and platform conventions. This review does not require an Apple visual style.

## Give a recommendation

Lead with the main judgment and its reason. Judge a concept as a proposal. Claim that an implementation is ready to ship only to the extent the evidence supports it.

For each finding, describe the scenario, user consequence, evidence, and concrete correction. Rank findings by impact and frequency. Keep unverified concerns separate from confirmed problems, and distinguish defects from product tradeoffs.

Recommend one flow and explain its consequential defaults. State the assumption if a different audience or task would change that recommendation. Prefer the smallest change that resolves the problem, but explain when the flow itself needs to change. Preserve decisions that already work. Do not invent findings to make the review appear strict.

End with the few next actions that matter most, usually no more than three. Give each an observable acceptance condition, such as "Canceling returns to the draft with its text and photos intact." For a narrow question, answer directly without expanding it into a full audit.

If you apply fixes, report what changed and what you verified. Static checks alone cannot establish that an interaction feels better.

When maintaining this skill, use the [review scenarios](references/pressure-tests.md) to check whether revisions preserve these decisions.
