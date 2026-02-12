# claude-md-templates

Template repository for CLAUDE.md files. These are AI context files that help Claude Code understand codebases.

## Stack

- Markdown files only
- No code dependencies

## Structure

```
.
├── templates/          # The actual templates
│   ├── nextjs-app.md
│   ├── react-vite.md
│   ├── node-api.md
│   ├── cli-tool.md
│   ├── monorepo.md
│   ├── python-app.md
│   ├── ai-agent.md
│   └── minimal.md
├── README.md           # Main docs
├── CONTRIBUTING.md     # How to contribute
└── CLAUDE.md           # This file (meta!)
```

## Rules

- Templates must be immediately usable (copy, fill placeholders, done)
- Use `[PLACEHOLDER]` format for things to fill in
- Keep templates scannable — use headers, code blocks, tables
- Include both "do" and "do NOT" sections
- Don't assume specific tools — offer options where reasonable

## Template Structure

Each template should include:
1. Project description placeholder
2. Stack section
3. Commands section
4. Structure section (with ASCII tree)
5. Conventions section
6. Anti-patterns ("Do NOT")
7. Environment variables
8. Testing notes
