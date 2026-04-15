from sqlalchemy import Column, Integer, String, Date, Boolean
from infrastructure.backend.db.database import Base


class TaskModel(Base):
    __tablename__ = "tasks"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    description = Column(String, nullable=True)
    due_date = Column(Date, nullable=True)
    is_completed = Column(Boolean, default=False)
