# Physical interaction principles

## Contents

1. The four-pillar model
2. Springs and damping
3. Gesture-to-animation handoff
4. Momentum, targets, and bounds
5. Spatial choreography and transform layers
6. Multimodal feedback
7. Performance and accessibility
8. Tuning heuristics

## 1. The four-pillar model

### Response

Create feedback on pointer-down, not after click. The user should perceive the object acknowledging contact before the action commits.

Useful signals:

- Scale by roughly 2–5%.
- Change color, opacity, or shadow without moving layout.
- Change the cursor or pose when drag becomes active.

Symptoms of failure:

- The control feels sticky or unresponsive.
- Visual feedback appears after the user's finger has already lifted.
- A debounce, timer, network request, or state round-trip sits on the input path.

### Continuity

Keep content attached to the pointer throughout direct manipulation. Preserve the offset from the point where the user grabbed the object.

Use Pointer Events and pointer capture. Require a short movement threshold, commonly 8–10px, before treating a press as a drag.

Symptoms of failure:

- The object jumps so its center sits under the pointer.
- The object lags behind the pointer during drag.
- Tracking stops when the pointer leaves the element.
- Releasing after a small hand tremor opens the item accidentally.

### Velocity handoff

Continue from the release velocity instead of restarting from rest. Sample a short recent window, commonly 60–120ms, rather than relying on a single noisy pointer event.

Symptoms of failure:

- The object visibly stops for a frame at release.
- A fast flick looks identical to a slow release.
- The animation moves backward immediately despite strong forward velocity.

### Interruptibility

Treat the latest valid user intent as authoritative. Retarget from the current presentation value and carry the current velocity into the new motion.

Symptoms of failure:

- Input is disabled until an animation completes.
- Reversal jumps to the old target or logical state.
- Re-grabbing a moving object resets its velocity or position.
- Rapid commands queue and play after the user's intent has changed.

## 2. Springs and damping

The classic mass-spring-damper system is:

```text
m·x'' + c·x' + k·(x - target) = 0
```

- `m` mass: inertia.
- `k` stiffness: restoring force.
- `c` damping: rate of energy loss.

Derived values are easier to reason about:

```text
natural frequency: ωₙ = √(k / m)
damping ratio:     ζ  = c / (2√(k·m))
```

| Damping ratio | Behavior | Typical use |
| --- | --- | --- |
| `ζ < 1` | Overshoots and oscillates | Drag release, playful objects |
| `ζ ≈ 1` | Fastest settle without overshoot | Default UI movement |
| `ζ > 1` | Slow, controlled, no overshoot | Heavy or cautious systems |

Spring character:

- Increase stiffness to accelerate correction.
- Increase damping to reduce overshoot.
- Increase mass to add inertia and slow direction changes.
- If stiffness rises, damping often must rise too.

Do not treat a spring as a fixed-duration easing. Its settle time emerges from parameters, displacement, velocity, and rest thresholds.

Reasonable starting points for mass `1`:

| Intent | Stiffness | Damping | Character |
| --- | ---: | ---: | --- |
| Controlled reposition | 350–450 | 35–45 | Near critical |
| Momentum release | 450–600 | 26–36 | Light overshoot |
| Playful character | 500–700 | 16–24 | Noticeably elastic |
| Heavy object | 250–400 | 28–42 | Slower response; raise mass |

Tune against the real interaction and viewport; these are starting points, not standards.

## 3. Gesture-to-animation handoff

Maintain a short position history:

```text
samples = [{ time, x, y }, ...]
velocity = (latest.position - earliest.position) / elapsedSeconds
```

Discard stale samples and avoid deriving velocity from one event. Clamp implausible spikes caused by event gaps or coordinate changes.

At release:

1. Read the current presentation position.
2. Compute release velocity.
3. Choose the target.
4. Start the spring with the current position and velocity.

For libraries that accept absolute velocity, pass px/s directly. For APIs expecting normalized velocity:

```text
relativeVelocity = gestureVelocity / (target - current)
```

## 4. Momentum, targets, and bounds

When several snap targets exist, choose based on projected motion rather than release position alone.

```js
function project(velocity, decelerationRate = 0.998) {
  return (velocity / 1000) * decelerationRate / (1 - decelerationRate)
}

const projected = current + project(releaseVelocity)
const target = nearestSnapPoint(projected)
```

Use a lower rate such as `0.99` for a shorter, more controllable projection. Always test on the actual interaction; projection is an intent heuristic, not a physics demonstration.

At bounds, prefer progressive resistance over a hard stop:

```js
function rubberband(overshoot, dimension, constant = 0.55) {
  return (overshoot * dimension * constant)
    / (dimension + constant * Math.abs(overshoot))
}
```

Use hysteresis around snap thresholds to prevent targets from flapping under small input noise.

## 5. Spatial choreography and transform layers

Keep entrance and exit paths symmetric. Anchor menus, popovers, and sheets to their source so the spatial relationship remains understandable.

Separate competing transforms:

```text
layout layer       track position, responsive arrangement
└─ gesture layer   drag translation and release velocity
   └─ state layer  scale, opacity, selected/disabled state
      └─ ambient layer  idle float or breathing motion
         └─ artwork layer  pose and local rotation
```

This prevents layout animation, drag, hover, and ambient loops from overwriting one `transform` value.

Use the smallest motion that communicates hierarchy. Large objects, full-viewport movement, and slow continuous oscillation demand stronger accessibility fallbacks.

## 6. Multimodal feedback

Use sound and haptics only when they reinforce a meaningful event.

- **Causality:** trigger on pickup, release, snap, commit, error, or completion.
- **Harmony:** align visual, audio, and haptic feedback in the same perceptual moment.
- **Utility:** avoid feedback on every hover or every frame of a drag.

Match character to the action: short high-frequency sounds feel light; lower and longer sounds feel heavier. Always provide mute or system-preference behavior when appropriate.

## 7. Performance and accessibility

Prefer compositor-friendly properties:

```text
transform
opacity
```

Avoid per-frame changes to layout-driving properties such as `top`, `left`, `width`, `height`, and margins. Avoid broad `transition: all` rules.

Use `will-change` narrowly around active motion; applying it permanently to many elements can waste memory.

Reduced motion should preserve understanding:

- Replace large translation, parallax, and elastic overshoot with short cross-fades or immediate state changes.
- Keep pressed, selected, status, completion, warning, and error feedback.
- Reduce or remove indefinite ambient loops.
- Provide solid-material fallbacks when reduced transparency or increased contrast is relevant.

## 8. Tuning heuristics

Tune in this order:

1. Remove input delay.
2. Make drag 1:1 and preserve grab offset.
3. Validate the gesture threshold and cancel path.
4. Make release velocity continuous.
5. Make retargeting interruptible.
6. Choose target projection and boundary resistance.
7. Tune stiffness, damping, mass, and rest thresholds.
8. Add pose, ambient motion, sound, and material.

Review at normal speed, slow motion, and under CPU throttling. A motion that only feels good in an isolated playground may fail inside the actual information hierarchy.
