import XCTest
@testable import application
@testable import domain

final class TaskUseCasesTests: XCTestCase {

    private var mockTaskRepository: MockTaskRepository!
    private var taskUseCases: TaskUseCases!

    override func setUp() {
        super.setUp()
        mockTaskRepository = MockTaskRepository()
        taskUseCases = TaskUseCases(taskRepository: mockTaskRepository)
    }

    override func tearDown() {
        mockTaskRepository = nil
        taskUseCases = nil
        super.tearDown()
    }

    func test_createTask_callsRepositoryCreate() async throws {
        // Given
        let task = Task(id: UUID(), title: "Test Task", description: "A test task", dueDate: Date(), isCompleted: false)
        mockTaskRepository.createTaskResult = task

        // When
        let createdTask = try await taskUseCases.createTask(title: "Test Task", description: "A test task", dueDate: Date())

        // Then
        XCTAssertEqual(createdTask.title, task.title)
        XCTAssertEqual(createdTask.description, task.description)
        XCTAssertEqual(createdTask.dueDate, task.dueDate)
        XCTAssertEqual(mockTaskRepository.createTaskCalled, true)
    }

    func test_getTaskById_callsRepositoryGetById() async throws {
        // Given
        let task = Task(id: UUID(), title: "Test Task", description: "A test task", dueDate: Date(), isCompleted: false)
        mockTaskRepository.getTaskByIdResult = task

        // When
        let fetchedTask = try await taskUseCases.getTaskById(id: task.id)

        // Then
        XCTAssertEqual(fetchedTask?.id, task.id)
        XCTAssertEqual(fetchedTask?.title, task.title)
        XCTAssertEqual(mockTaskRepository.getTaskByIdCalled, true)
        XCTAssertEqual(mockTaskRepository.getTaskByIdArgument, task.id)
    }

    func test_getAllTasks_callsRepositoryGetAll() async throws {
        // Given
        let tasks = [
            Task(id: UUID(), title: "Task 1", description: "Desc 1", dueDate: Date(), isCompleted: false),
            Task(id: UUID(), title: "Task 2", description: "Desc 2", dueDate: Date(), isCompleted: true)
        ]
        mockTaskRepository.getAllTasksResult = tasks

        // When
        let fetchedTasks = try await taskUseCases.getAllTasks()

        // Then
        XCTAssertEqual(fetchedTasks.count, tasks.count)
        XCTAssertEqual(mockTaskRepository.getAllTasksCalled, true)
    }

    func test_updateTask_callsRepositoryUpdate() async throws {
        // Given
        var task = Task(id: UUID(), title: "Test Task", description: "A test task", dueDate: Date(), isCompleted: false)
        task.isCompleted = true
        mockTaskRepository.updateTaskResult = task

        // When
        let updatedTask = try await taskUseCases.updateTask(task: task)

        // Then
        XCTAssertEqual(updatedTask.id, task.id)
        XCTAssertEqual(updatedTask.isCompleted, true)
        XCTAssertEqual(mockTaskRepository.updateTaskCalled, true)
        XCTAssertEqual(mockTaskRepository.updateTaskArgument?.id, task.id)
    }

    func test_deleteTask_callsRepositoryDelete() async throws {
        // Given
        let taskID = UUID()
        mockTaskRepository.deleteTaskCalled = true

        // When
        try await taskUseCases.deleteTask(id: taskID)

        // Then
        XCTAssertEqual(mockTaskRepository.deleteTaskCalled, true)
        XCTAssertEqual(mockTaskRepository.deleteTaskArgument, taskID)
    }

    func test_createTask_withEmptyTitle_throwsError() async {
        // Given
        let emptyTitle = ""
        let description = "A test task"
        let dueDate = Date()

        // When & Then
        await XCTAssertThrowsError(try await taskUseCases.createTask(title: emptyTitle, description: description, dueDate: dueDate)) { error in
            XCTAssertEqual(error as? TaskUseCases.TaskUseCaseError, TaskUseCases.TaskUseCaseError.invalidInput("Task title cannot be empty."))
        }
        XCTAssertEqual(mockTaskRepository.createTaskCalled, false)
    }

    func test_createTask_withEmptyDescription_throwsError() async {
        // Given
        let title = "Test Task"
        let emptyDescription = ""
        let dueDate = Date()

        // When & Then
        await XCTAssertThrowsError(try await taskUseCases.createTask(title: title, description: emptyDescription, dueDate: dueDate)) { error in
            XCTAssertEqual(error as? TaskUseCases.TaskUseCaseError, TaskUseCases.TaskUseCaseError.invalidInput("Task description cannot be empty."))
        }
        XCTAssertEqual(mockTaskRepository.createTaskCalled, false)
    }

    func test_updateTask_withEmptyTitle_throwsError() async {
        // Given
        var task = Task(id: UUID(), title: "Test Task", description: "A test task", dueDate: Date(), isCompleted: false)
        task.title = ""

        // When & Then
        await XCTAssertThrowsError(try await taskUseCases.updateTask(task: task)) { error in
            XCTAssertEqual(error as? TaskUseCases.TaskUseCaseError, TaskUseCases.TaskUseCaseError.invalidInput("Task title cannot be empty."))
        }
        XCTAssertEqual(mockTaskRepository.updateTaskCalled, false)
    }

    func test_updateTask_withEmptyDescription_throwsError() async {
        // Given
        var task = Task(id: UUID(), title: "Test Task", description: "A test task", dueDate: Date(), isCompleted: false)
        task.description = ""

        // When & Then
        await XCTAssertThrowsError(try await taskUseCases.updateTask(task: task)) { error in
            XCTAssertEqual(error as? TaskUseCases.TaskUseCaseError, TaskUseCases.TaskUseCaseError.invalidInput("Task description cannot be empty."))
        }
        XCTAssertEqual(mockTaskRepository.updateTaskCalled, false)
    }
}

// Mock implementation of TaskRepository for testing
class MockTaskRepository: TaskRepository {
    var createTaskResult: Task?
    var createTaskCalled = false

    var getTaskByIdResult: Task?
    var getTaskByIdCalled = false
    var getTaskByIdArgument: UUID?

    var getAllTasksResult: [Task] = []
    var getAllTasksCalled = false

    var updateTaskResult: Task?
    var updateTaskCalled = false
    var updateTaskArgument: Task?

    var deleteTaskCalled = false
    var deleteTaskArgument: UUID?

    func createTask(task: domain.Task) async throws -> domain.Task {
        createTaskCalled = true
        if let createTaskResult = createTaskResult {
            return createTaskResult
        } else {
            throw MockRepositoryError.creationFailed
        }
    }

    func getTaskById(id: UUID) async throws -> domain.Task? {
        getTaskByIdCalled = true
        getTaskByIdArgument = id
        return getTaskByIdResult
    }

    func getAllTasks() async throws -> [domain.Task] {
        getAllTasksCalled = true
        return getAllTasksResult
    }

    func updateTask(task: domain.Task) async throws -> domain.Task {
        updateTaskCalled = true
        updateTaskArgument = task
        if let updateTaskResult = updateTaskResult {
            return updateTaskResult
        } else {
            throw MockRepositoryError.updateFailed
        }
    }

    func deleteTask(id: UUID) async throws {
        deleteTaskCalled = true
        deleteTaskArgument = id
    }

    enum MockRepositoryError: Error {
        case creationFailed
        case updateFailed
    }
}
