# [PROJECT_NAME]

[One sentence describing what this app does and who uses it]

## Stack

- Next.js 16.1 (App Router, Server Components)
- TypeScript 5.9 (strict mode)
- React 19.2
- Tailwind CSS 4.1
- [AUTH_PROVIDER] (e.g., NextAuth, Clerk, Supabase Auth)
- [DATABASE] (e.g., Supabase, Planetscale, Prisma + Postgres)
- [HOSTING] (e.g., Vercel, Cloudflare)

## Commands

```bash
npm run dev      # Start dev server (localhost:3000)
npm run build    # Production build
npm run start    # Run production build
npm run lint     # ESLint
npm run test     # Run tests
```

## Structure

```
src/
├── app/                    # App Router
│   ├── (auth)/            # Auth route group
│   ├── (dashboard)/       # Dashboard route group
│   ├── api/               # API routes
│   ├── layout.tsx         # Root layout
│   └── page.tsx           # Home page
├── components/
│   ├── ui/                # Reusable UI components
│   └── [feature]/         # Feature-specific components
├── lib/
│   ├── utils.ts           # Helper functions
│   ├── db.ts              # Database client
│   └── auth.ts            # Auth helpers
├── hooks/                 # Custom React hooks
├── types/                 # TypeScript types
└── styles/                # Global styles
```

## Conventions

### Components
- One component per file
- PascalCase filenames: `UserCard.tsx`
- Default exports for page components
- Named exports for shared components
- Colocate component-specific types

### Styling
- Tailwind classes only (no CSS modules)
- Use `cn()` from lib/utils for conditional classes
- Design tokens via CSS variables in globals.css
- Mobile-first responsive design

### Data Fetching
- Server Components for initial data
- Server Actions for mutations
- `use` hook for client-side data
- No `useEffect` for data fetching

### File Naming
- `page.tsx` — route page
- `layout.tsx` — route layout
- `loading.tsx` — loading UI
- `error.tsx` — error boundary
- `actions.ts` — server actions (colocated)

## Patterns

### Server Action Pattern
```typescript
// app/posts/actions.ts
'use server'
export async function createPost(formData: FormData) {
  // validate, mutate, revalidate
}
```

### Client Component Pattern
```typescript
'use client'
import { useTransition } from 'react'
import { createPost } from './actions'
```

## Do NOT

- Use `any` type — use `unknown` and narrow
- Create API routes when Server Actions work
- Put client components in Server Component files
- Use `useEffect` for data fetching
- Import server-only code in client components
- Skip TypeScript errors with `@ts-ignore`

## Environment Variables

```
# .env.local
DATABASE_URL=
NEXT_PUBLIC_[APP_NAME]_URL=
[AUTH_PROVIDER]_SECRET=
```

## Testing

- [TEST_FRAMEWORK] (e.g., Vitest, Jest)
- Test files next to source: `Component.test.tsx`
- Focus on integration tests over unit tests

## Deploy

```bash
vercel --prod  # or your deploy command
```

---

*Last updated: [DATE]*
