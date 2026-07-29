---
name: reconstruct-interface-motion
description: Analyze and reconstruct web interface interactions from videos, GIFs, screenshots, prototypes, descriptions, or existing UI. Use when Codex needs to identify motion terminology, derive state and shared-element models, reproduce card-to-detail or spatial transitions, create an implementation-ready motion specification, choose between Motion, View Transitions, CSS, GSAP, SVG, Canvas, or WebGL, implement reusable motion architecture, or validate interaction fidelity, interruptibility, accessibility, and performance.
---

# Reconstruct Interface Motion

Turn an interaction reference into an evidence-based, reusable web motion system. Separate observation from inference, preserve object identity across states, and select technology only after modeling the interaction.

## Determine the task mode

Classify the request before acting:

- **Name**: Identify professional terms and distinguish close alternatives. Keep the answer short.
- **Analyze**: Inspect the reference and explain states, layers, timing, and feasibility. Do not modify a codebase.
- **Specify**: Produce an implementation-ready motion specification and component architecture.
- **Implement**: Inspect the existing stack, implement the smallest coherent system, and verify it.
- **Audit**: Review an implementation for fidelity, robustness, accessibility, and performance. Lead with findings.

Do not turn an analysis or audit request into an implementation without authorization.

## Apply the SPACE workflow

### 1. Segment states

Identify stable interface states before analyzing in-between frames. Name states by user-visible meaning, such as `overview`, `group-expanded`, `item-focused`, and `detail-open`.

For a video or GIF:

1. Inspect duration, dimensions, and frame rate.
2. Extract a coarse storyboard to locate state boundaries.
3. Inspect denser frames only around transitions.
4. Record visible evidence separately from uncertain inference.

Use `scripts/extract_video_storyboard.sh <input> [output-dir] [seconds-per-frame]` when `ffmpeg` and `ffprobe` are available. Default to a 0.5-second sampling interval, then resample important transitions more densely.

Output a state graph with triggers, forward paths, reverse paths, and interruption points.

### 2. Preserve identity

Map which visual objects represent the same entity across states. For every candidate, choose one strategy:

- **Shared geometry**: Preserve identity and interpolate position, size, radius, or crop.
- **Crossfade**: Replace one representation with another in place.
- **Semantic replacement**: Switch from summary content to richer content at a zoom/state threshold.
- **Independent enter/exit**: Treat the objects as unrelated.

Prefer shared geometry for containers, covers, and hero media. Prefer crossfade or semantic replacement for tiny text, controls, and content whose layout changes substantially. Never scale thumbnail text into reading text when a clean target rendering can crossfade in.

Create an identity map such as `overview.document-42 -> detail.document-42` and note any placeholder required for a reversible close transition.

### 3. Assign layers

Separate responsibilities so one element does not carry incompatible transforms:

- **Camera layer**: Pan, zoom, and viewport focus.
- **Shared layer**: Containers, covers, images, and other identity-preserving elements.
- **Content layer**: Text, controls, and state-specific UI.
- **Atmosphere layer**: Backdrop, dimming, blur, shadow, and depth cues.
- **Interaction layer**: Pointer, wheel, keyboard, focus, history, and scroll locking.

Determine whether motion changes layout, moves a camera over a scene, replaces content semantically, or combines all three.

### 4. Choreograph tracks

Describe the transition as coordinated tracks rather than one generic duration. Specify:

- Trigger and completion condition
- Position, scale, crop, radius, opacity, blur, and content tracks
- Relative start times and overlap
- Spring or easing rationale
- Interruption and reversal behavior
- Reduced-motion behavior

Use approximate timing when evidence is incomplete and label it as an estimate. Favor short, responsive transitions for frequently repeated actions.

### 5. Evaluate and choose architecture

Choose the rendering and animation stack from interaction constraints, not personal preference:

- Use CSS transitions for local, independent property changes.
- Use Motion shared layout for React elements that can coexist in one application tree.
- Use the View Transitions API for document or route transitions where snapshot-based handoff is useful.
- Use GSAP when precise timelines, path motion, or imperative orchestration dominates.
- Use DOM with a transformed world layer for spatial canvases containing readable text and moderate node counts.
- Use SVG for vector geometry and path-centric motion.
- Use Canvas or WebGL only when object count, effects, or true 3D justify losing ordinary DOM layout and accessibility.

Read `references/architecture-decisions.md` whenever selecting a stack. Read `references/motion-react.md` before designing or editing a React + Motion implementation. Read `references/view-transitions.md` before recommending native view transitions or combining them with another engine.

## Design for reuse

Extract primitives around behavioral seams, not page-specific markup. Prefer an architecture such as:

```text
MotionSystem
├── Viewport or SceneController
├── TransitionItem(source, target, identity)
├── TransitionLayer
├── ContentAdapter(preview, detail)
└── MotionTokens
```

Keep business content in slots or render functions. Keep identity, timing, layering, focus restoration, history behavior, and reduced-motion policy in the reusable system. Avoid a universal component that assumes every page has the same geometry.

## Implement in risk order

When implementation is requested:

1. Inspect the repository conventions, router, rendering model, and existing motion dependencies.
2. Implement the explicit state model and navigation semantics first.
3. Establish stable source/target identity and DOM layering.
4. Add geometry continuity without decorative effects.
5. Add content enter/exit orchestration.
6. Add camera, blur, shadow, or depth only when they clarify hierarchy.
7. Add reduced-motion, focus management, keyboard support, history behavior, and scroll locking.
8. Test reverse navigation and rapid interruption before tuning polish.

Preserve existing application behavior and avoid adding a second animation library unless the chosen architecture requires it.

## Validate

Read `references/validation-checklist.md` for every implementation or audit. Verify the real interaction, not only static snapshots. Test open, close, back, rapid repeat, resize, content overflow, reduced motion, keyboard navigation, and at least one constrained device profile when available.

## Produce the appropriate output

For an analysis or specification, include only relevant sections from this contract:

1. **Interaction summary**
2. **Vocabulary**
3. **Evidence and uncertainties**
4. **State graph**
5. **Identity map**
6. **Layer model**
7. **Motion timeline**
8. **Technology decision**
9. **Reusable component architecture**
10. **Risks and validation plan**

For an implementation, lead with the completed behavior, link changed files, summarize architectural decisions, and report validation results. For a terminology-only request, read `references/pattern-vocabulary.md` and return the best term plus at most two close alternatives.

## Reference routing

- Read `references/pattern-vocabulary.md` to name or disambiguate interaction patterns.
- Read `references/architecture-decisions.md` to choose rendering layers, libraries, and routing strategy.
- Read `references/motion-react.md` only for React + Motion design or implementation.
- Read `references/view-transitions.md` only for native same-document or cross-document view transitions.
- Read `references/validation-checklist.md` for implementation, audit, or fidelity review.
