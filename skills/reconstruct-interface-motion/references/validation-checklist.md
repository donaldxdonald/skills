# Motion Validation Checklist

## State and navigation

- Verify every stable state without animation.
- Verify open, close, escape, browser back, and direct-link entry.
- Verify a second action during opening and during closing.
- Verify repeated rapid selection of the same and different items.
- Verify camera and scroll restoration after close or back.
- Verify missing, slow, or failed media does not break geometry.

## Visual continuity

- Slow the animation or record it frame-by-frame.
- Check the first and last two frames for jumps.
- Confirm shared objects preserve identity, crop, and perceived origin.
- Confirm target-only content does not appear before its container can plausibly contain it.
- Confirm close is intentionally reversed, not merely faded out.
- Check radius, shadow, clipping, and image aspect ratio throughout.
- Check responsive breakpoints, resize during transition, and content overflow.

## Interaction quality

- Verify animations can be redirected or safely ignored during interruption.
- Verify pointer capture ends correctly after drag or cancellation.
- Verify wheel and pinch zoom preserve the intended focal point.
- Verify hit targets do not move ahead of their visible elements.
- Verify no invisible overlay blocks the page after exit.

## Performance

- Profile the real target browser and a constrained device when available.
- Prefer compositor-friendly transform and opacity work.
- Look for repeated layout, paint-heavy blur, large shadows, and oversized layers.
- Confirm images are appropriately sized and decoded before critical transitions.
- Check memory and layer count for large spatial scenes.
- Treat 60 fps as a baseline target, not proof of correctness.

## Accessibility

- Honor `prefers-reduced-motion` without breaking navigation.
- Move focus into an opened modal/detail surface when appropriate.
- Restore focus to the invoking element on close.
- Provide keyboard equivalents for pointer-only actions.
- Lock and restore background scroll deliberately.
- Keep hidden duplicate shared elements out of the accessibility tree.
- Preserve readable contrast while dimming or blurring the background.

## Evidence report

Report:

- Environments tested
- Behaviors exercised
- Measurements or recordings used
- Known limitations
- Any approximation caused by missing source assets or incomplete reference footage

Do not claim exact fidelity from static inspection alone.
