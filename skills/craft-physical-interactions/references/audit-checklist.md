# Motion audit checklist

## Contents

1. Build the inventory
2. Diagnose by pillar
3. Inspect architecture and performance
4. Verify accessibility
5. Report findings

## 1. Build the inventory

Read repository instructions first. Then use focused searches appropriate to the stack:

```text
rg "transition|animation|@keyframes|transform" src
rg "motion\.|AnimatePresence|useSpring|useMotionValue|drag" src
rg "pointerdown|pointermove|pointerup|setPointerCapture" src
rg "requestAnimationFrame|performance\.now" src
rg "prefers-reduced-motion|useReducedMotion" src
```

Identify:

- Shared motion tokens and primitives.
- Gesture recognizers and pointer lifecycle.
- Spring/easing parameters.
- Layout properties changed during animation.
- State gates that disable input during transitions.
- Automated tests covering gesture decisions.

Run the UI when possible. Observe before reading implementation details so code does not bias the symptom description.

## 2. Diagnose by pillar

| Pillar | Questions | Evidence |
| --- | --- | --- |
| Response | Does feedback begin on pointer-down? | Event order, timers, state latency |
| Continuity | Does content track 1:1 and keep grab offset? | Pointer math, capture, video/frame observation |
| Velocity | Is recent release velocity sampled and handed off? | Sample history, spring options, velocity curve |
| Interruptibility | Can motion be reversed or re-grabbed mid-flight? | Disabled controls, queues, target resets |

Classify each issue by its earliest broken pillar. A spring that feels wrong may be a velocity-handoff bug rather than a parameter problem.

## 3. Inspect architecture and performance

Flag with evidence:

- Multiple systems writing the same transform.
- `transition: all` on interactive components.
- Per-frame `top`, `left`, `width`, `height`, margin, or expensive filter changes.
- Layout reads interleaved with writes inside pointermove.
- React state updates on every pointer event when motion values or refs would suffice.
- Permanent `will-change` across many elements.
- Unbounded loops, queued animations, or timers surviving unmount.
- Remounting keyed elements to restart motion, which discards presentation velocity.
- Fixed-duration easing used after a flick or throw.
- Bounce on events with no causal momentum.

Inspect responsive behavior: coordinate systems, snap points, and active targets must survive resize without teleporting.

## 4. Verify accessibility

Check:

- Keyboard-equivalent actions and visible focus.
- Accessible names for icon-only and gesture-only controls.
- Touch target size and cancel behavior.
- `prefers-reduced-motion` behavior.
- No essential information revealed only through hover or motion.
- Optional sound/haptics can be muted or follow system preferences.
- Large motion and ambient loops do not dominate reading surfaces.

Reduced motion should keep state feedback while replacing large movement, parallax, and overshoot.

## 5. Report findings

For each actionable finding, include:

```text
Priority and title
Location: file:line
Observed symptom
Evidence in code or runtime behavior
Broken pillar
User impact
Smallest viable fix
Verification method
```

Prioritize:

1. Broken input, trapped state, or inaccessible controls.
2. Discontinuity, lost gestures, or incorrect target selection.
3. Jank and layout-driven animation.
4. Non-interruptible behavior.
5. Parameter and visual-polish improvements.

Do not recommend wholesale library replacement without demonstrating that the current stack cannot express the required behavior.
