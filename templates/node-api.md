# [PROJECT_NAME]

[One sentence: what this API does]

## Stack

- Node.js 22 LTS
- TypeScript 5.7
- [FRAMEWORK] (Express / Fastify / Hono)
- [DATABASE] (PostgreSQL / MongoDB / SQLite)
- [ORM] (Prisma / Drizzle / Mongoose)
- [AUTH] (JWT / session / API keys)

## Commands

```bash
npm run dev      # Start with hot reload
npm run build    # Compile TypeScript
npm run start    # Run compiled code
npm run test     # Run tests
npm run db:push  # Push schema to database
npm run db:seed  # Seed database
```

## Structure

```
src/
├── routes/              # Route handlers
│   ├── users.ts
│   ├── posts.ts
│   └── index.ts         # Route aggregation
├── middleware/          # Custom middleware
│   ├── auth.ts
│   ├── validate.ts
│   └── errorHandler.ts
├── services/            # Business logic
│   └── userService.ts
├── lib/
│   ├── db.ts            # Database client
│   ├── logger.ts        # Logging
│   └── errors.ts        # Custom error classes
├── types/               # TypeScript types
├── utils/               # Helper functions
├── config.ts            # Environment config
└── index.ts             # Entry point
```

## API Design

### REST Endpoints
```
GET    /api/v1/users          # List users
POST   /api/v1/users          # Create user
GET    /api/v1/users/:id      # Get user
PATCH  /api/v1/users/:id      # Update user
DELETE /api/v1/users/:id      # Delete user
```

### Response Format
```json
{
  "data": { ... },
  "meta": { "page": 1, "total": 100 }
}
```

### Error Format
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email is required",
    "details": [...]
  }
}
```

## Conventions

### Route Handlers
```typescript
// routes/users.ts
router.get('/:id', async (req, res, next) => {
  try {
    const user = await userService.getById(req.params.id)
    res.json({ data: user })
  } catch (error) {
    next(error)
  }
})
```

### Services
- One service per domain entity
- Services don't know about HTTP
- Return data or throw custom errors

### Validation
- Use [Zod / Joi / Yup] for request validation
- Validate at route level, not service level

```typescript
const createUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(2),
})
```

### Error Handling
```typescript
// lib/errors.ts
export class AppError extends Error {
  constructor(
    public code: string,
    message: string,
    public statusCode = 400
  ) {
    super(message)
  }
}
```

## Do NOT

- Use `any` type
- Expose stack traces in production
- Store secrets in code
- Skip input validation
- Use sync file operations
- Catch errors without handling them

## Environment Variables

```
# .env
NODE_ENV=development
PORT=3000
DATABASE_URL=
JWT_SECRET=
```

## Database

### Migrations
```bash
npm run db:migrate      # Run migrations
npm run db:generate     # Generate migration
```

### Seeding
```bash
npm run db:seed         # Seed dev data
```

## Auth Pattern

```typescript
// middleware/auth.ts
export function requireAuth(req, res, next) {
  const token = req.headers.authorization?.split(' ')[1]
  if (!token) throw new AppError('UNAUTHORIZED', 'Missing token', 401)
  
  const payload = verifyToken(token)
  req.user = payload
  next()
}
```

## Testing

- [Vitest / Jest] for unit tests
- Supertest for integration tests
- Test database for isolation

```bash
npm run test:unit
npm run test:integration
```

---

*Last updated: [DATE]*
