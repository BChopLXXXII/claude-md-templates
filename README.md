# CLAUDE.md Templates

Starter templates for AI-assisted development. Drop one in your project, customize it, and let Claude Code understand your codebase instantly.

## Why CLAUDE.md?

Without context, AI tools waste time:
- Asking about your stack
- Guessing your conventions
- Breaking your patterns
- Forgetting decisions you made 3 messages ago

A good CLAUDE.md file fixes all of this. Claude reads it automatically at the start of every session.

## Quick Start

1. Find the template that matches your project
2. Copy it to your project root as `CLAUDE.md`
3. Fill in the `[PLACEHOLDERS]`
4. Start coding

### Optional: Use the scaffold script

Skip manual copy/paste:

```bash
./scripts/scaffold-claude.sh --list
./scripts/scaffold-claude.sh --template react-vite
```

This creates `./CLAUDE.md` in your current directory. Use `--output` to pick a custom path.

## Templates

| Template | Use Case |
|----------|----------|
| [`nextjs-app.md`](./templates/nextjs-app.md) | Next.js 16+ apps with App Router |
| [`react-vite.md`](./templates/react-vite.md) | React + Vite SPAs |
| [`node-api.md`](./templates/node-api.md) | Node.js/Express backends |
| [`cli-tool.md`](./templates/cli-tool.md) | Command-line tools |
| [`monorepo.md`](./templates/monorepo.md) | Turborepo/Nx monorepos |
| [`python-app.md`](./templates/python-app.md) | Python projects (FastAPI, Flask, scripts) |
| [`ai-agent.md`](./templates/ai-agent.md) | AI assistants and autonomous agents |
| [`minimal.md`](./templates/minimal.md) | Bare minimum for any project |

## What Makes a Good CLAUDE.md?

**Include:**
- Project purpose (one sentence)
- Tech stack with versions
- File structure conventions
- How to run/test/deploy
- Coding style rules
- Things to NEVER do

**Skip:**
- Obvious stuff ("this is a web app")
- Implementation details that change often
- Long explanations (keep it scannable)

## Example Usage

```markdown
# [Project Name]

[One sentence: what this does and who it's for]

## Stack
- Next.js 16.1 (App Router)
- TypeScript 5.9
- Tailwind CSS 4.1
- Supabase (auth + database)

## Commands
- `npm run dev` - Start dev server
- `npm run build` - Production build
- `npm run test` - Run tests

## Structure
src/
  app/           # App Router pages
  components/    # React components
  lib/           # Utilities and helpers
  types/         # TypeScript types

## Rules
- Use `cn()` for conditional classes
- All API routes go in `app/api/`
- Never use `any` type
- Components: PascalCase files, default exports
```

## Tips

1. **Start minimal** — add sections when Claude gets confused
2. **Be specific** — "use shadcn/ui" beats "use a component library"
3. **Update it** — when you make a decision, add it to CLAUDE.md
4. **Folder-level context** — for large projects, you can create local context files in subdirectories (e.g., `docs/CONTEXT.md`). Just tell Claude to "check the context file in this folder" when working there

## Version Safety Check

Run this before shipping template updates:

```bash
./scripts/check-versions.sh
```

It compares common stack versions in `README.md` and core templates against current npm releases.

## See Also

**Want simpler, beginner-friendly templates?** Check out [vibe-coder-rules](https://github.com/BChopLXXXII/vibe-coder-rules) — under 100 lines, heavily commented, includes .cursorrules for Cursor IDE.

## License

MIT. Do whatever you want with these.

## About

Made by [@BChopLXXXII](https://x.com/BChopLXXXII)

Stop re-explaining your project to AI every session.

Ship it. 🚀

---

If this helped, [star the repo](https://github.com/BChopLXXXII/claude-md-templates) — it helps others find it.
