# Donald's Agent Skills Collection

Reusable agent skills for Codex-style local workflows.

## Install

This repo can be installed with the open agent skills CLI from [`vercel-labs/skills`](https://github.com/vercel-labs/skills).

List available skills:

```bash
npx skills add donaldxdonald/skills --list
```

Install a specific skill:

```bash
npx skills add donaldxdonald/skills --skill branding
```

Install for Codex globally:

```bash
npx skills add donaldxdonald/skills --skill branding -g -a codex
```

Install all skills from this repo:

```bash
npx skills add donaldxdonald/skills
```

## Included Skills

### `branding`

Helps shape brand strategy before visual execution. It focuses on audience, positioning, differentiation, messaging, proof, personality, and the touchpoints where the brand needs to stay consistent.

### `simplify`

Reviews changed code for reuse, quality, and efficiency, then fixes issues found. It is useful as a cleanup pass after implementation, especially before merging.

## Credits

The [`simplify`](./skills/simplify/) skill is adapted from the Claude Code workflow and included here with attribution.
