from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from infrastructure.backend.api.dependencies import get_db
from infrastructure.backend.db.crud import task_crud
from infrastructure.backend.api.schemas import task_schema

router = APIRouter(prefix="/tasks", tags=["tasks"])


@router.get("/", response_model=List[task_schema.Task])
def read_tasks(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return task_crud.get_tasks(db, skip=skip, limit=limit)


@router.post("/", response_model=task_schema.Task, status_code=201)
def create_task(task: task_schema.TaskCreate, db: Session = Depends(get_db)):
    return task_crud.create_task(db=db, task=task)


@router.get("/{task_id}", response_model=task_schema.Task)
def read_task(task_id: int, db: Session = Depends(get_db)):
    db_task = task_crud.get_task(db, task_id=task_id)
    if db_task is None:
        raise HTTPException(status_code=404, detail="Task not found")
    return db_task


@router.put("/{task_id}", response_model=task_schema.Task)
def update_task(task_id: int, task: task_schema.TaskUpdate, db: Session = Depends(get_db)):
    db_task = task_crud.update_task(db, task_id=task_id, task_update=task)
    if db_task is None:
        raise HTTPException(status_code=404, detail="Task not found")
    return db_task


@router.delete("/{task_id}", response_model=task_schema.Task)
def delete_task(task_id: int, db: Session = Depends(get_db)):
    db_task = task_crud.delete_task(db, task_id=task_id)
    if db_task is None:
        raise HTTPException(status_code=404, detail="Task not found")
    return db_task
