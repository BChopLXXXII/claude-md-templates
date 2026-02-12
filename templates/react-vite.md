# [PROJECT_NAME]

[One sentence describing what this SPA does]

## Stack

- React 19
- Vite 6.0
- TypeScript 5.7
- Tailwind CSS 4.0
- React Router 7 (or TanStack Router)
- [STATE_MANAGEMENT] (e.g., Zustand, Jotai, TanStack Query)
- [BUILD_TARGET] (e.g., Vercel, Netlify, Cloudflare Pages)

## Commands

```bash
npm run dev      # Start dev server (localhost:5173)
npm run build    # Production build to dist/
npm run preview  # Preview production build
npm run lint     # ESLint
npm run test     # Vitest
```

## Structure

```
src/
├── assets/              # Static assets (images, fonts)
├── components/
│   ├── ui/              # Reusable UI components
│   └── [feature]/       # Feature components
├── hooks/               # Custom hooks
├── lib/
│   ├── utils.ts         # Helper functions
│   ├── api.ts           # API client
│   └── constants.ts     # App constants
├── pages/               # Route pages (or routes/)
├── stores/              # State management
├── types/               # TypeScript types
├── App.tsx              # Root component
└── main.tsx             # Entry point
```

## Conventions

### Components
- One component per file
- PascalCase: `UserCard.tsx`
- Props interface above component
- Destructure props in function signature

```typescript
interface UserCardProps {
  user: User
  onSelect?: (id: string) => void
}

export function UserCard({ user, onSelect }: UserCardProps) {
  // ...
}
```

### Hooks
- Prefix with `use`: `useAuth.ts`
- Return object, not array (unless order matters)
- Handle loading/error states

### State
- Component state: `useState`
- Shared state: [STATE_LIBRARY]
- Server state: TanStack Query (or SWR)
- URL state: search params

### Routing
```typescript
// pages/Dashboard.tsx
export function Dashboard() {
  return <div>...</div>
}

// App.tsx or routes.tsx
<Route path="/dashboard" element={<Dashboard />} />
```

## API Pattern

```typescript
// lib/api.ts
const API_URL = import.meta.env.VITE_API_URL

export async function fetchUser(id: string): Promise<User> {
  const res = await fetch(`${API_URL}/users/${id}`)
  if (!res.ok) throw new Error('Failed to fetch user')
  return res.json()
}
```

## Do NOT

- Use `any` type
- Fetch in `useEffect` without cleanup
- Store derived state
- Create god components (>200 lines = split it)
- Use inline styles (use Tailwind)
- Import from `../../../` (use path aliases)

## Path Aliases

```typescript
// vite.config.ts
resolve: {
  alias: {
    '@': path.resolve(__dirname, './src'),
  }
}

// Usage
import { Button } from '@/components/ui/Button'
```

## Environment Variables

```
# .env
VITE_API_URL=
VITE_[SERVICE]_KEY=
```

Note: Only `VITE_` prefixed vars are exposed to client.

## Testing

- Vitest + React Testing Library
- Test files: `Component.test.tsx`
- Mock API calls with MSW

---

*Last updated: [DATE]*
