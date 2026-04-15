import datetime
from typing import Optional

from pydantic import BaseModel


class TaskBase(BaseModel):
    title: str
    description: Optional[str] = None
    due_date: Optional[datetime.date] = None
    is_completed: bool = False


class TaskCreate(TaskBase):
    pass


class TaskUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    due_date: Optional[datetime.date] = None
    is_completed: Optional[bool] = None


class Task(TaskBase):
    id: int

    class Config:
        from_attributes = True  # Pydantic v2 (replaces orm_mode)
