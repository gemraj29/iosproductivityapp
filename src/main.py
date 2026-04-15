"""Application entry point."""

from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .core.config import settings
from .core.logging import configure_logging

# Infrastructure imports — model import registers it with Base
from infrastructure.backend.db.database import Base, engine
from infrastructure.backend.db.models import task_model  # noqa: F401
from infrastructure.backend.api.routers.task_router import router as tasks_router

configure_logging()


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Create DB tables on startup (idempotent)."""
    Base.metadata.create_all(bind=engine)
    yield


app = FastAPI(
    title="iOSProductivity",
    version="0.1.0",
    docs_url="/docs" if settings.debug else None,
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # allow iOS simulator + any local origin
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Register routers
app.include_router(tasks_router)


@app.get("/health")
async def health() -> dict:
    return {"status": "ok", "version": "0.1.0"}
