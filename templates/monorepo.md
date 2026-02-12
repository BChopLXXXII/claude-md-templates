# [PROJECT_NAME]

[One sentence: what this monorepo contains and why]

## Stack

- [MONOREPO_TOOL] (Turborepo / Nx / Lerna)
- [PACKAGE_MANAGER] (pnpm / npm workspaces / yarn)
- TypeScript 5.7
- [SHARED_TOOLING] (ESLint, Prettier, tsconfig)

## Commands

```bash
# Root commands
pnpm install             # Install all dependencies
pnpm dev                 # Run all apps in dev mode
pnpm build               # Build all packages
pnpm lint                # Lint everything
pnpm test                # Run all tests

# Package-specific
pnpm --filter @org/web dev
pnpm --filter @org/api build
pnpm --filter "./packages/*" test
```

## Structure

```
.
├── apps/
│   ├── web/             # Next.js frontend
│   ├── api/             # Node.js backend
│   └── mobile/          # React Native app
├── packages/
│   ├── ui/              # Shared UI components
│   ├── config/          # Shared configs (eslint, tsconfig)
│   ├── types/           # Shared TypeScript types
│   └── utils/           # Shared utilities
├── turbo.json           # Turborepo config
├── pnpm-workspace.yaml  # Workspace definition
└── package.json         # Root package.json
```

## Packages

| Package | Description | Depends On |
|---------|-------------|------------|
| `@org/web` | Next.js frontend | ui, types, utils |
| `@org/api` | Express backend | types, utils |
| `@org/ui` | React component library | — |
| `@org/types` | Shared TypeScript types | — |
| `@org/utils` | Shared helper functions | types |
| `@org/config` | Shared ESLint/TS configs | — |

## Conventions

### Package Naming
- Scope all packages: `@org/package-name`
- Internal packages: `"version": "0.0.0"` (not published)
- Keep names short but descriptive

### Internal Dependencies
```json
// apps/web/package.json
{
  "dependencies": {
    "@org/ui": "workspace:*",
    "@org/utils": "workspace:*"
  }
}
```

### Shared Configs
```javascript
// packages/config/eslint.config.js
export default [
  // shared rules
]

// apps/web/eslint.config.js
import baseConfig from '@org/config/eslint.config'
export default [...baseConfig, /* app-specific */]
```

### TypeScript References
```json
// apps/web/tsconfig.json
{
  "extends": "@org/config/tsconfig.json",
  "references": [
    { "path": "../../packages/ui" },
    { "path": "../../packages/types" }
  ]
}
```

## Pipeline (Turborepo)

```json
// turbo.json
{
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "lint": {},
    "test": {
      "dependsOn": ["build"]
    }
  }
}
```

## Adding a Package

```bash
# Create new package
mkdir packages/new-package
cd packages/new-package
pnpm init

# Add to workspace
# (automatic with pnpm-workspace.yaml pattern)

# Use from other package
pnpm --filter @org/web add @org/new-package
```

## Do NOT

- Install deps in root (unless truly shared tooling)
- Create circular dependencies
- Put app-specific code in shared packages
- Skip `workspace:*` for internal deps
- Mix package managers

## Dependency Rules

- **apps/** can depend on **packages/**
- **packages/** can depend on other **packages/**
- Nothing depends on **apps/**
- Keep the dependency graph as flat as possible

## Versioning

- Internal packages: `0.0.0` (not versioned)
- Published packages: semantic versioning
- Use changesets for coordinated releases

## CI/CD

```yaml
# Only run affected builds
- run: pnpm turbo run build --filter=...[origin/main]

# Cache Turborepo remote cache
- uses: turborepo-remote-cache-action@v1
```

---

*Last updated: [DATE]*
