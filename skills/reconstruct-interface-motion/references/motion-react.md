# React + Motion Implementation Guide

Use this reference only when the project uses React and the `motion` package.

## Core primitives

- Import React APIs from `motion/react`.
- Use `layout` for rearrangement within a rendered state.
- Use matching `layoutId` values for a shared element across states.
- Use `LayoutGroup` to coordinate related layout measurements.
- Use `AnimatePresence` to retain exiting UI long enough to animate.
- Use motion values for high-frequency camera or gesture state.
- Use variants or explicit transitions for coordinated content tracks.

## Recommended structure

```tsx
<LayoutGroup id="content-transitions">
  <Scene>
    <motion.article layoutId={`frame-${item.id}`}>
      <motion.img layoutId={`media-${item.id}`} />
    </motion.article>
  </Scene>

  <AnimatePresence>
    {selected && (
      <DetailLayer>
        <motion.article layoutId={`frame-${selected.id}`}>
          <motion.img layoutId={`media-${selected.id}`} />
          <motion.div>{/* target-only content */}</motion.div>
        </motion.article>
      </DetailLayer>
    )}
  </AnimatePresence>
</LayoutGroup>
```

Adapt this shape to the repository. Do not introduce duplicate visible source and target content without controlling opacity and accessibility exposure.

## Identity rules

- Derive `layoutId` from stable domain identity, not list index.
- Keep IDs unique within the active layout group.
- Preserve the source or a placeholder until Motion has measured the transition.
- Ensure source and target overlap in the React lifecycle when a shared transition is expected.
- Put the layout coordination boundary above route or overlay branches that must match.

## Layer rules

- Keep the spatial camera transform on a parent scene layer.
- Put the detail surface in a stable viewport layer when possible.
- Avoid nesting the target under a differently scaled ancestor from the source unless verified in the actual browser.
- Freeze or separate camera motion during the critical shared-geometry handoff if coordinate correction becomes unstable.
- Crossfade dense text and controls; share the frame and media.

## Timing rules

- Use a damped spring for direct, interruptible geometry changes.
- Avoid decorative bounce for frequently opened content.
- Start backdrop changes slightly before or with geometry motion.
- Introduce target-only content after the source has visually committed to expansion.
- Fade target-only content out early on close so the shared frame can return cleanly.

Treat numeric values as tuning tokens, not universal constants. Test on the actual component sizes and devices.

## Camera state

Store camera `x`, `y`, and `scale` in motion values when updates are gesture-driven. Use a single transformed world layer. Implement wheel zoom around the pointer by preserving the world coordinate beneath it. Clamp values and stop or redirect active animation when a new gesture begins.

## Routing

- Place `LayoutGroup` and required presence coordination above route branches when transitions cross routes.
- Ensure the router does not immediately destroy the source before measurement.
- Keep URL state, selected identity, and camera restoration explicit.
- If route lifecycles cannot provide overlap reliably, prefer the View Transitions API or an overlay route pattern.

## Common failures

- **Jump at start**: Source disappeared too early, identity changed, or layout measurement occurred after a reflow.
- **Jump at end**: Target content changed size during the transition or an image/font loaded late.
- **Distorted radius or shadow**: The visual is being scale-corrected on the wrong layer; move decoration to an inner/outer wrapper.
- **Blurry text**: Text is being scaled as shared geometry; crossfade a target rendering.
- **Wrong origin**: A transformed ancestor or portal changed the coordinate space.
- **Broken rapid clicks**: State transitions assume animations finish; model interruption and idempotent close/open behavior.

## Reduced motion

Use Motion's reduced-motion support or `prefers-reduced-motion`. Replace large spatial travel with a short opacity transition or immediate state change while preserving focus and navigation semantics.
