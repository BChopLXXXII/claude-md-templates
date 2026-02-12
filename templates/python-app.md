# [PROJECT_NAME]

[One sentence: what this does]

## Stack

- Python 3.12+
- [FRAMEWORK] (FastAPI / Flask / Django / None)
- [PACKAGE_MANAGER] (uv / pip / poetry)
- [TYPE_CHECKING] (mypy / pyright)
- [DATABASE] (SQLAlchemy / Prisma / raw SQL / None)

## Commands

```bash
# Environment
uv venv                  # Create virtual env
source .venv/bin/activate
uv pip install -e .      # Install in dev mode

# Running
python -m [package]      # Run as module
uvicorn app:app --reload # FastAPI dev server
flask run                # Flask dev server

# Development
uv pip install -e ".[dev]"
pytest                   # Run tests
mypy src/                # Type check
ruff check .             # Lint
ruff format .            # Format
```

## Structure

```
.
├── src/
│   └── [package]/
│       ├── __init__.py
│       ├── __main__.py      # Entry point for `python -m`
│       ├── app.py           # Main application
│       ├── routes/          # API routes (if web)
│       ├── services/        # Business logic
│       ├── models/          # Data models
│       └── utils/           # Helpers
├── tests/
│   ├── conftest.py          # Pytest fixtures
│   └── test_*.py
├── pyproject.toml           # Project config
└── README.md
```

## Conventions

### Type Hints
- All functions must have type hints
- Use `TypedDict` for dict shapes
- Use `Literal` for string enums
- Use `Protocol` for duck typing

```python
from typing import TypedDict

class UserData(TypedDict):
    id: str
    email: str
    name: str | None

def get_user(user_id: str) -> UserData | None:
    ...
```

### Imports
- Absolute imports only: `from package.services import user_service`
- No relative imports beyond single dot: `from .utils import helper`
- Sort with isort (or ruff)

### Naming
- `snake_case` for functions, variables, modules
- `PascalCase` for classes
- `SCREAMING_SNAKE_CASE` for constants
- Private: prefix with `_`

### Error Handling
```python
class AppError(Exception):
    def __init__(self, code: str, message: str, status_code: int = 400):
        self.code = code
        self.message = message
        self.status_code = status_code
        super().__init__(message)

# Usage
raise AppError("NOT_FOUND", "User not found", 404)
```

## FastAPI Patterns

### Route Handler
```python
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter(prefix="/users", tags=["users"])

class CreateUserRequest(BaseModel):
    email: str
    name: str

@router.post("/")
async def create_user(body: CreateUserRequest) -> UserResponse:
    user = await user_service.create(body.email, body.name)
    return UserResponse.from_model(user)
```

### Dependency Injection
```python
from fastapi import Depends

async def get_db():
    async with async_session() as session:
        yield session

@router.get("/{id}")
async def get_user(id: str, db = Depends(get_db)):
    ...
```

## Do NOT

- Use `Any` type
- Catch bare `except:`
- Use mutable default arguments
- Mix sync and async carelessly
- Skip type hints

## Environment Variables

```python
# config.py
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    database_url: str
    secret_key: str
    debug: bool = False
    
    class Config:
        env_file = ".env"

settings = Settings()
```

## Testing

```python
# tests/conftest.py
import pytest
from httpx import AsyncClient
from app import app

@pytest.fixture
async def client():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        yield ac

# tests/test_users.py
async def test_create_user(client):
    response = await client.post("/users", json={"email": "test@example.com"})
    assert response.status_code == 201
```

## Dependencies

```toml
# pyproject.toml
[project]
dependencies = [
    "fastapi>=0.129",
    "uvicorn[standard]",
]

[project.optional-dependencies]
dev = [
    "pytest",
    "pytest-asyncio",
    "mypy",
    "ruff",
]
```

---

*Last updated: [DATE]*
