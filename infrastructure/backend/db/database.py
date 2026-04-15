import os
from pathlib import Path

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Load .env from the project root
_root = Path(__file__).resolve().parents[4]
load_dotenv(_root / ".env")

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://app:secret@localhost:5432/appdb"
)
# Convert asyncpg driver to sync psycopg2 if needed
DATABASE_URL = DATABASE_URL.replace("postgresql+asyncpg://", "postgresql://")

engine = create_engine(DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()
