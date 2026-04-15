```python
from fastapi import FastAPI
from infrastructure.backend.api.routers import task_router
from infrastructure.backend.db.database import engine, Base

# Create database tables if they don't exist
# In a real application, you'd likely use Alembic for migrations
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="iOSProductivity API",
    description="API for the iOSProductivity mobile app.",
    version="0.1.0",
)

app.include_router(task_router.router)

@app.get("/")
async def read_root():
    return {"message": "Welcome to the iOSProductivity API!"}
```
