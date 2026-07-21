---
name: craft-physical-interactions
description: Design, implement, diagnose, and refine fluid physical interface motion for web and app UIs. Use when Codex needs to create or improve gesture-driven interactions, draggable objects, swipe/carousel behavior, sheets and drawers, spring animations, momentum and snap points, interruptible transitions, ambient character motion, motion accessibility, or an interface whose animation feels delayed, disconnected, floaty, stiff, janky, over-bouncy, or hard to control. Supports both new feature work and audits/refactors of existing CSS, JavaScript, React, Motion/Framer Motion, or similar animation code.
---

# Craft Physical Interactions

Build motion as continuous behavior, not a sequence of decorative clips. Organize decisions around four pillars: response, continuity, velocity handoff, and interruptibility.

## Route the task

Choose one path before editing:

- **Create:** define the interaction contract, implement it, and verify real input behavior.
- **Improve:** reproduce the current feel, identify the broken pillar, then change the smallest responsible layer.
- **Audit:** inspect without editing unless the user also requests fixes; report evidence by file and line.

Read the matching references:

- Read [references/principles.md](references/principles.md) when designing behavior, choosing springs, tuning feel, or explaining physical motion.
- Read [references/implementation-patterns.md](references/implementation-patterns.md) before implementing gesture, velocity, snap, or interruption logic.
- Read [references/audit-checklist.md](references/audit-checklist.md) when reviewing or optimizing an existing codebase.

## Inspect before deciding

1. Read repository instructions and relevant component, style, test, and package files.
2. Identify the existing animation stack and reusable primitives. Prefer the project's current library.
3. Reproduce the interaction with real pointer, touch-equivalent, and keyboard input when a runnable UI exists.
4. Separate observed symptoms from inferred implementation causes.
5. Preserve unrelated user changes and existing product conventions.

Do not add an animation dependency merely to express a simple hover, fade, or system-driven transition. Prefer:

- CSS for brief, non-interruptible state feedback.
- The existing spring/motion library for gesture-driven or retargetable behavior.
- Pointer Events plus `requestAnimationFrame` when the project intentionally avoids animation dependencies.

## Define the interaction contract

Write down the behavior before choosing parameters:

- States: idle, hover, pressed, dragging, settling, selected, disabled.
- Inputs: pointer down/move/up/cancel, keyboard, resize, route/state changes.
- Direct mapping: what follows the pointer 1:1, including grab offset.
- Gesture threshold: how tap and drag are disambiguated.
- Release rule: where the object should settle and whether velocity affects the target.
- Interruption rule: what happens when a new input arrives mid-animation.
- Bounds: hard constraint, rubber-band resistance, or unrestricted motion.
- Accessibility equivalents: keyboard action and reduced-motion behavior.

Prefer an explicit state model over interacting boolean flags.

## Implement in causal order

Implement and validate each layer before adding the next:

1. **Response:** react on pointer-down; keep feedback small and immediate.
2. **Continuity:** track the pointer 1:1 and preserve the original grab offset.
3. **Intent:** apply a short movement threshold before committing to drag.
4. **Velocity:** sample recent positions and compute release velocity.
5. **Destination:** project momentum when choosing among snap points.
6. **Settle:** start a spring from the current presentation value and release velocity.
7. **Interruption:** allow retargeting or re-grabbing without resetting position or velocity.
8. **Character:** add restrained scale, rotation, ambient motion, sound, or haptics only after the behavior is correct.

Use separate transform layers when layout, drag, state, ambient motion, and artwork pose need to animate independently.

## Improve in priority order

Fix causes in this order:

1. Input latency and delayed feedback.
2. Pointer/object discontinuity or lost grab offset.
3. Release-time velocity discontinuity.
4. Locked input, target-value jumps, and non-interruptible transitions.
5. Layout-triggering per-frame work and dropped frames.
6. Spring parameters, easing, overshoot, and staging.
7. Decorative character, material, sound, and haptics.

Do not tune stiffness or damping until the interaction seam and state model are correct. Parameter changes cannot repair broken causality.

## Motion rules

- Use springs for objects users can directly touch, redirect, or throw.
- Use duration-based easing for short fades and system-directed choreography with a known schedule.
- Start ordinary UI movement near critical damping; add overshoot only when momentum or material character justifies it.
- Carry velocity through release and retargeting.
- Animate primarily `transform` and `opacity`; avoid per-frame layout properties.
- Avoid `transition: all` and indefinite ambient motion on primary reading surfaces.
- Keep entrance and exit paths spatially consistent.
- Synchronize sound or haptics with the causal visual event, not with an arbitrary timer.
- Never let animation delay, obscure, or block a user's latest valid intent without a product-state reason.

## Accessibility and user control

- Implement `prefers-reduced-motion` as a gentler equivalent, not silence: replace large translation, parallax, and overshoot with short cross-fades or immediate state changes.
- Preserve meaningful pressed, selected, completion, warning, and error feedback.
- Provide keyboard-equivalent actions and visible focus.
- Give icon-only and gesture-only controls accessible names.
- Keep hit targets usable on touch and do not rely on hover to reveal essential behavior.
- Treat optional sound and haptics as user-controlled enhancements.

## Verify

Test proportionally to risk:

- Press feedback begins immediately.
- Drag remains attached when the pointer leaves the original bounds.
- Tap does not misfire after a drag.
- Fast and slow releases produce coherent motion.
- Reversal and re-grab work during the first, middle, and final thirds of motion.
- Resize or responsive changes do not teleport an active object.
- Mouse, touch-equivalent, keyboard, and reduced-motion paths work.
- The interaction remains smooth under CPU throttling or a slower device when available.
- Existing automated tests pass; add focused tests for state and target selection when appropriate.

For audits, report the symptom, evidence, violated pillar, user impact, and smallest viable fix. For implementation work, complete and verify the change rather than returning only recommendations.
