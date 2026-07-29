# View Transitions API Guide

Use native view transitions when browser snapshots provide a cleaner handoff than keeping source and target React elements alive together.

## Good fits

- Route transitions with distinct source and destination trees
- Same-document state changes where snapshot interpolation is sufficient
- Cross-document navigation on supported browsers
- Progressive enhancement where the navigation must remain correct without animation

## Model

For same-document transitions, wrap the state or DOM update in `document.startViewTransition`. Assign a unique `view-transition-name` to matched source and target elements. Style the generated old/new pseudo-elements for timing and composition.

For cross-document transitions, follow the browser's current opt-in and naming requirements. Check current browser support and syntax before implementation because this area evolves.

## Rules

- Keep `view-transition-name` unique in the rendered document.
- Preserve navigation correctness when `startViewTransition` is unavailable.
- Avoid assigning a view transition name to large changing subtrees without measuring snapshot and memory cost.
- Crossfade or independently animate content that should not be geometrically matched.
- Keep focus, history, scroll restoration, and loading states independent from visual snapshots.
- Design the reverse navigation explicitly; do not assume the browser will infer hierarchy.

## Combining with Motion

Use one owner for each visual property:

- Let View Transitions own route-level snapshots and shared geometry.
- Let Motion own local gestures, internal layout changes, or content tracks that are not snapshot-matched.
- Do not make both systems animate the same element's transform or opacity during the same interval.

Prefer Motion when live DOM interruption and gesture continuity dominate. Prefer View Transitions when route lifecycle and source/target coexistence are the harder problem.

## Limitations to account for

- Snapshot content is not live during the visual handoff.
- Dynamic video, canvas, caret, and scroll content may need special handling.
- Browser support and cross-document behavior vary; verify against the project's target matrix.
- Snapshot layering can conflict with fixed overlays, top-layer elements, and application z-index assumptions.
- Long transitions can expose stale snapshots after the underlying state has already changed.
