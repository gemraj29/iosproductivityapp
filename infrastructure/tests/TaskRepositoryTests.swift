import XCTest
import CoreData
@testable import Domain
@testable import Infrastructure

final class TaskRepositoryTests: XCTestCase {

    private var coreDataStack: CoreDataStack!
    private var taskRepository: TaskRepositoryImpl!

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStack(modelName: "ProductivityModel", inMemory: true)
        taskRepository = TaskRepositoryImpl(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        coreDataStack = nil
        taskRepository = nil
        super.tearDown()
    }

    func test_saveTask_shouldPersistTask() async throws {
        // Given
        let task = Task(id: UUID(), title: "Test Task", isCompleted: false)

        // When
        try await taskRepository.saveTask(task: task)

        // Then
        let fetchedTasks = try await taskRepository.getAllTasks()
        XCTAssertEqual(fetchedTasks.count, 1)
        XCTAssertEqual(fetchedTasks.first?.id, task.id)
        XCTAssertEqual(fetchedTasks.first?.title, task.title)
        XCTAssertEqual(fetchedTasks.first?.isCompleted, task.isCompleted)
    }

    func test_getAllTasks_whenEmpty_shouldReturnEmptyArray() async throws {
        // Given (no tasks saved)

        // When
        let tasks = try await taskRepository.getAllTasks()

        // Then
        XCTAssertTrue(tasks.isEmpty)
    }

    func test_getAllTasks_whenMultipleTasks_shouldReturnAllTasks() async throws {
        // Given
        let task1 = Task(id: UUID(), title: "Task 1", isCompleted: false)
        let task2 = Task(id: UUID(), title: "Task 2", isCompleted: true)
        let task3 = Task(id: UUID(), title: "Task 3", isCompleted: false)

        try await taskRepository.saveTask(task: task1)
        try await taskRepository.saveTask(task: task2)
        try await taskRepository.saveTask(task: task3)

        // When
        let fetchedTasks = try await taskRepository.getAllTasks()

        // Then
        XCTAssertEqual(fetchedTasks.count, 3)
        XCTAssertTrue(fetchedTasks.contains { $0.id == task1.id })
        XCTAssertTrue(fetchedTasks.contains { $0.id == task2.id })
        XCTAssertTrue(fetchedTasks.contains { $0.id == task3.id })
    }

    func test_getTaskById_whenTaskExists_shouldReturnTask() async throws {
        // Given
        let task = Task(id: UUID(), title: "Specific Task", isCompleted: false)
        try await taskRepository.saveTask(task: task)

        // When
        let fetchedTask = try await taskRepository.getTaskById(id: task.id)

        // Then
        XCTAssertNotNil(fetchedTask)
        XCTAssertEqual(fetchedTask?.id, task.id)
        XCTAssertEqual(fetchedTask?.title, task.title)
    }

    func test_getTaskById_whenTaskDoesNotExist_shouldReturnNil() async throws {
        // Given
        let nonExistentId = UUID()

        // When
        let fetchedTask = try await taskRepository.getTaskById(id: nonExistentId)

        // Then
        XCTAssertNil(fetchedTask)
    }

    func test_updateTask_shouldModifyExistingTask() async throws {
        // Given
        var task = Task(id: UUID(), title: "Original Title", isCompleted: false)
        try await taskRepository.saveTask(task: task)

        // When
        task.title = "Updated Title"
        task.isCompleted = true
        try await taskRepository.updateTask(task: task)

        // Then
        let fetchedTask = try await taskRepository.getTaskById(id: task.id)
        XCTAssertNotNil(fetchedTask)
        XCTAssertEqual(fetchedTask?.title, "Updated Title")
        XCTAssertTrue(fetchedTask!.isCompleted)
    }

    func test_updateTask_whenTaskDoesNotExist_shouldThrowError() async {
        // Given
        let nonExistentTask = Task(id: UUID(), title: "Non Existent", isCompleted: false)

        // When & Then
        do {
            try await taskRepository.updateTask(task: nonExistentTask)
            XCTFail("Expected an error to be thrown for updating a non-existent task.")
        } catch {
            // We expect an error, but don't need to assert specific error type for this test
            XCTAssertTrue(error is TaskRepositoryError)
        }
    }

    func test_deleteTask_shouldRemoveTask() async throws {
        // Given
        let task = Task(id: UUID(), title: "Task to Delete", isCompleted: false)
        try await taskRepository.saveTask(task: task)
        let initialTasks = try await taskRepository.getAllTasks()
        XCTAssertEqual(initialTasks.count, 1)

        // When
        try await taskRepository.deleteTask(id: task.id)

        // Then
        let fetchedTasks = try await taskRepository.getAllTasks()
        XCTAssertTrue(fetchedTasks.isEmpty)
        let fetchedTask = try await taskRepository.getTaskById(id: task.id)
        XCTAssertNil(fetchedTask)
    }

    func test_deleteTask_whenTaskDoesNotExist_shouldThrowError() async {
        // Given
        let nonExistentId = UUID()

        // When & Then
        do {
            try await taskRepository.deleteTask(id: nonExistentId)
            XCTFail("Expected an error to be thrown for deleting a non-existent task.")
        } catch {
            // We expect an error, but don't need to assert specific error type for this test
            XCTAssertTrue(error is TaskRepositoryError)
        }
    }
}
