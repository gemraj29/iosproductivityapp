from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from infrastructure.backend.api.routers import task_router
from infrastructure.backend.db.database import engine, Base

# Auto-create tables on startup (handles fresh environments without migrations)
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="iOSProductivity API",
    description="API for the iOSProductivity mobile app.",
    version="0.1.0",
)

# Allow requests from any origin (covers iOS Simulator + dev tools)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(task_router.router)


@app.get("/")
async def read_root():
    return {"message": "Welcome to the iOSProductivity API!"}
