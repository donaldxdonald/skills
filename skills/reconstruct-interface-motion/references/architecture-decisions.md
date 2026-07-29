# Architecture Decisions

## Start with constraints

Record these facts before selecting technology:

- Framework and router
- Same component tree, same document, or cross-document navigation
- Object count and content type
- Need for readable/selectable text
- Drag, wheel, pinch, momentum, and interruption requirements
- Target browsers and devices
- Accessibility and reduced-motion requirements
- Existing animation dependencies

## Choose the rendering layer

| Constraint | Preferred layer | Reason |
| --- | --- | --- |
| Ordinary UI, text, forms, cards | DOM | Native layout, accessibility, selection, and responsive behavior |
| Large spatial surface with moderate nodes | DOM world layer with one camera transform | Keep content semantic while moving the scene on the compositor |
| Vector paths or shape interpolation | SVG | Direct control over geometry and paths |
| Thousands of simple objects | Canvas | Lower retained-DOM overhead |
| True 3D, shaders, particles, very large scenes | WebGL | GPU-oriented rendering and effects |

Do not choose Canvas or WebGL only because the design looks spatial. Prefer DOM until measured constraints disqualify it.

## Choose the transition engine

| Situation | Preferred approach |
| --- | --- |
| Small local hover, press, opacity, or transform | CSS transition or keyframes |
| React layout rearrangement | Motion `layout` |
| React source and target can coexist | Motion `layoutId` inside a shared layout context |
| Route/document handoff benefits from snapshots | View Transitions API |
| Precise multi-track timeline or path control dominates | GSAP timeline or Web Animations API orchestration |
| Gesture physics and interruptible values dominate | Motion values or a dedicated gesture/physics layer |

Prefer the animation library already present when it can express the required model cleanly.

## Choose the navigation model

- Use an **overlay detail state** when the source context must remain visible and closing should restore the exact viewport.
- Use a **route detail state** when the destination needs a stable URL, independent loading, or browser navigation semantics.
- Combine route state with an overlay presentation when deep linking and spatial continuity are both required.
- Persist the selected identity and camera state in a durable parent or navigation state; do not infer restoration from current DOM geometry alone.

## Use five layers

1. **Camera**: Apply scene pan and zoom to one parent transform.
2. **Shared**: Animate source/target geometry in a stable coordinate space.
3. **Content**: Crossfade state-specific content instead of geometrically scaling complex text.
4. **Atmosphere**: Isolate blur, dimming, shadow, and depth so they can be removed on constrained devices.
5. **Interaction**: Own pointer capture, wheel math, focus, history, scroll lock, and escape/back behavior.

Avoid applying camera scale and shared-element correction to the same DOM node.

## Design the camera

Represent the camera with `x`, `y`, and `scale`. Keep world coordinates stable. For pointer-centered zoom, preserve the world point under the pointer:

```text
worldX = (pointerX - x) / oldScale
nextX  = pointerX - worldX * nextScale
```

Apply the same calculation for Y. Clamp scale, consider wheel delta normalization, and make programmatic focus transitions interruptible.

## Decide what is actually shared

Good shared candidates:

- Card or container frame
- Cover image or hero media
- Stable title with similar typography
- Selection indicator

Poor shared candidates:

- Dense thumbnail text becoming readable body text
- Elements that reflow into unrelated structures
- Controls that change meaning
- Large blur or filter surfaces

Use a target rendering plus crossfade for poor candidates.

## Avoid common dead ends

- Do not animate `top`, `left`, `width`, or `height` every frame when a transform can express the motion.
- Do not apply large animated blur to an entire viewport without profiling.
- Do not let both a router transition and a shared-layout engine own the same geometry.
- Do not remove the source before measuring or capturing its geometry.
- Do not treat closing as an afterthought; design the reverse path with the opening path.
- Do not tune spring values before state, identity, and layer ownership are correct.
