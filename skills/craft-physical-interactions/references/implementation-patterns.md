# Implementation patterns

## Contents

1. Choose the mechanism
2. Model interaction state
3. Implement direct manipulation
4. Sample velocity and choose targets
5. Implement interruptible springs
6. Use Motion or Framer Motion
7. Layer transforms
8. Test behavior

## 1. Choose the mechanism

Use the least powerful mechanism that still preserves the required behavior:

| Interaction | Preferred mechanism |
| --- | --- |
| Hover, pressed color, short fade | CSS transition |
| Page choreography with a known schedule | CSS, WAAPI, or existing motion library |
| Drag, swipe, sheet, throw, snap | Spring-capable motion library or Pointer Events + rAF |
| Mid-flight retargeting | Motion value / spring state with current velocity |
| Ambient illustration loop | CSS keyframes or motion library, isolated from gesture transform |

Avoid adding a dependency if the project already has an adequate motion primitive.

## 2. Model interaction state

Prefer an explicit transition model:

```text
idle → pressed → dragging → settling → idle
             ↘ tap/commit
```

Track at minimum:

```ts
type MotionState = {
  phase: 'idle' | 'pressed' | 'dragging' | 'settling'
  position: { x: number; y: number }
  velocity: { x: number; y: number }
  target: { x: number; y: number }
  pointerId?: number
  grabOffset?: { x: number; y: number }
}
```

Keep target state separate from presentation position. A spring changes presentation values toward the target; a new input can replace the target without teleporting presentation values.

## 3. Implement direct manipulation

Use pointer capture and preserve grab offset:

```js
element.addEventListener('pointerdown', event => {
  element.setPointerCapture(event.pointerId)

  const rect = element.getBoundingClientRect()
  state.pointerId = event.pointerId
  state.grabOffset = {
    x: event.clientX - rect.left,
    y: event.clientY - rect.top,
  }
  state.phase = 'pressed'
})
```

On move:

1. Measure distance from the original pointer-down point.
2. Commit to drag after the threshold.
3. Map pointer position to object position while preserving offset.
4. Record timestamped position samples.

Handle `pointercancel`, lost capture, window blur, and component unmount. Do not let a canceled gesture commit a tap.

## 4. Sample velocity and choose targets

Use a rolling recent window:

```js
function estimateVelocity(samples, now, windowMs = 100) {
  const recent = samples.filter(sample => now - sample.time <= windowMs)
  if (recent.length < 2) return { x: 0, y: 0 }

  const first = recent[0]
  const last = recent[recent.length - 1]
  const seconds = Math.max(0.001, (last.time - first.time) / 1000)

  return {
    x: (last.x - first.x) / seconds,
    y: (last.y - first.y) / seconds,
  }
}
```

For a carousel or sheet:

```js
const projected = current + velocity * projectionSeconds
const target = nearestSnapPoint(projected)
```

Use velocity sign and projected endpoint to resolve ambiguous releases. Add hysteresis so tiny movements near a threshold do not change targets repeatedly.

## 5. Implement interruptible springs

A semi-implicit Euler integrator is sufficient for a small custom interaction if substepped:

```js
function stepSpring(state, target, config, deltaSeconds) {
  let remaining = Math.min(deltaSeconds, 0.05)

  while (remaining > 0) {
    const dt = Math.min(1 / 120, remaining)
    const force = -config.stiffness * (state.x - target)
    const damping = -config.damping * state.velocity
    const acceleration = (force + damping) / config.mass

    state.velocity += acceleration * dt
    state.x += state.velocity * dt
    remaining -= dt
  }
}
```

On retarget:

```js
spring.target = nextTarget
// Keep spring.x and spring.velocity unchanged.
```

On re-grab, stop spring ownership but keep the current on-screen position. Begin direct manipulation from that value.

For two-dimensional motion, run independent X and Y springs. This preserves different axis velocities and avoids coupling artifacts.

## 6. Use Motion or Framer Motion

For a draggable object that returns to origin:

```tsx
<motion.button
  drag
  dragSnapToOrigin
  dragTransition={{
    bounceStiffness: 600,
    bounceDamping: 20,
  }}
  whileHover={{ scale: 1.05 }}
  whileTap={{ scale: 0.98 }}
  whileDrag={{ scale: 1.04, rotate: 6 }}
/>
```

For motion that must retarget, keep position in motion values or animation controls rather than remounting a keyed element. Ensure the new animation begins from the current value and library-maintained velocity.

Do not use a fixed duration as the primary control for an object that inherits gesture velocity. If the framework offers `bounce` plus `duration`, treat those as designer-facing spring controls, not evidence that the behavior is a cubic easing.

Use presence animation for content lifecycle, but do not block valid input solely to protect an exit animation. Preserve focus and accessibility while content enters or leaves.

## 7. Layer transforms

Use nested elements when independent systems need transforms:

```tsx
<motion.div style={layoutTransform}>
  <motion.div style={dragTransform}>
    <motion.div animate={selectedState}>
      <motion.div animate={ambientMotion}>
        <img src={artwork} alt="" />
      </motion.div>
    </motion.div>
  </motion.div>
</motion.div>
```

Avoid letting hover scale, drag translation, layout animation, and idle keyframes overwrite the same `transform` declaration.

## 8. Test behavior

Test state and target-selection logic separately from rendering when possible:

- Movement below threshold remains a tap.
- Movement above threshold cancels tap.
- Velocity estimator handles sparse and identical timestamps.
- Projected endpoints choose the expected snap target.
- A retarget preserves position and velocity.
- Pointer cancel restores a valid state.
- Reduced motion removes large spatial movement while keeping feedback.

In integration tests, exercise rapid reversal, re-grab during settle, pointer leaving bounds, responsive resize, and keyboard equivalents.
