# Interaction Motion Vocabulary

Use the narrowest term that explains the visible relationship. Name the overall interaction separately from its transition technique.

## Spatial structures

- **Spatial interface / spatial canvas**: Arrange objects in a persistent two-dimensional scene rather than a linear page.
- **Zoomable User Interface (ZUI)**: Navigate information by panning and zooming through a larger space.
- **Semantic zoom**: Change the representation or amount of information as zoom or focus changes; do not merely scale pixels.
- **Focus + context**: Emphasize a selected object while retaining enough surrounding structure to preserve orientation.
- **Camera / viewport transition**: Animate the user's view over a scene while scene coordinates remain stable.

## State continuity

- **Shared element transition**: Preserve the perceived identity of an element as it moves and transforms between two states or views.
- **Container transform**: Expand or contract a container so the source appears to become the destination surface. Common Material Design terminology.
- **Hero transition**: Framework-specific name, especially in Flutter, for a shared visual element moving between routes.
- **Matched geometry effect**: SwiftUI terminology for matching geometry across two view states.
- **Shared layout animation**: Common Motion terminology for matching elements with the same `layoutId`.
- **View transition**: Browser-managed transition between rendered states using captured visual representations.
- **Continuity transition**: A broader transition that preserves orientation and relationship, even when no exact element is shared.

## Layout and content changes

- **Layout animation**: Interpolate an element from its previous layout position or size to its new one.
- **Crossfade**: Fade one representation out while another fades in at the same location.
- **Semantic replacement**: Replace a summary representation with a richer one at a state or zoom threshold.
- **Direction-aware transition**: Make forward and backward navigation move in opposite directions to express hierarchy.
- **Origin-aware animation**: Make an entering surface appear to grow from its trigger rather than its own center.

## Disambiguation

- Use **shared element transition** when the same perceived object travels between states.
- Use **layout animation** when objects remain in one state tree but rearrange.
- Use **container transform** when a small surface expands into a larger destination surface.
- Use **semantic zoom** only when the representation changes with zoom or focus.
- Use **morph** only when shape geometry itself transforms. Scaling a card into a detail view is usually not a morph.
- Use **crossfade** when identity continuity is weak or geometry differs too much for a credible match.
- Use **page transition** for the navigation event; use **shared element transition** for the continuity technique inside it.

When terminology varies by framework, lead with the framework-neutral term and put the framework name second.
