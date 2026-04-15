import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from infrastructure.backend.app.main import app, get_db
from infrastructure.backend.app.database import Base

# Database setup for testing
SQLALCHEMY_DATABASE_URL = "sqlite:///:memory:"
engine = create_engine(SQLALCHEMY_DATABASE_URL)
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Override the dependency to use the test database
def override_get_db():
    try:
        db = TestingSessionLocal()
        yield db
    finally:
        db.close()

app.dependency_overrides[get_db] = override_get_db

@pytest.fixture(scope="module")
def test_db():
    Base.metadata.create_all(bind=engine)
    yield
    Base.metadata.drop_all(bind=engine)

@pytest.fixture(scope="module")
def client():
    return TestClient(app)

# Example test for a hypothetical root endpoint
def test_read_root(client, test_db):
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to the iOSProductivity API"}

# Add more tests for your actual API endpoints below
# Example: Testing a hypothetical task creation endpoint
# def test_create_task(client, test_db):
#     task_data = {"title": "Buy groceries", "description": "Milk, Eggs, Bread"}
#     response = client.post("/tasks/", json=task_data)
#     assert response.status_code == 200
#     assert response.json()["title"] == "Buy groceries"
#     assert response.json()["description"] == "Milk, Eggs, Bread"

# Example: Testing a hypothetical task retrieval endpoint
# def test_get_tasks(client, test_db):
#     # First, create a task
#     task_data = {"title": "Read a book", "description": "Finish chapter 5"}
#     client.post("/tasks/", json=task_data)
#
#     # Then, retrieve all tasks
#     response = client.get("/tasks/")
#     assert response.status_code == 200
#     assert len(response.json()) == 1
#     assert response.json()[0]["title"] == "Read a book"
