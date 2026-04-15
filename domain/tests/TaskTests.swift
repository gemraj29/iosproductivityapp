import XCTest
@testable import domain

final class TaskTests: XCTestCase {

    func testTaskInitialization() {
        let id = UUID()
        let title = "Buy Groceries"
        let description = "Milk, Eggs, Bread"
        let dueDate = Date()
        let isCompleted = false
        let priority = TaskPriority.high

        let task = Task(
            id: id,
            title: title,
            description: description,
            dueDate: dueDate,
            isCompleted: isCompleted,
            priority: priority
        )

        XCTAssertEqual(task.id, id)
        XCTAssertEqual(task.title, title)
        XCTAssertEqual(task.description, description)
        XCTAssertEqual(task.dueDate, dueDate)
        XCTAssertEqual(task.isCompleted, isCompleted)
        XCTAssertEqual(task.priority, priority)
    }

    func testTaskEquality() {
        let id = UUID()
        let date = Date()
        let task1 = Task(
            id: id,
            title: "Task 1",
            description: "Desc 1",
            dueDate: date,
            isCompleted: false,
            priority: .medium
        )
        let task2 = Task(
            id: id,
            title: "Task 2",
            description: "Desc 2",
            dueDate: date,
            isCompleted: true,
            priority: .low
        )
        let task3 = Task(
            id: UUID(),
            title: "Task 3",
            description: "Desc 3",
            dueDate: date,
            isCompleted: false,
            priority: .high
        )

        XCTAssertEqual(task1, task2)
        XCTAssertNotEqual(task1, task3)
    }

    func testTaskCodable() throws {
        let date = Date()
        let task = Task(
            id: UUID(),
            title: "Codable Task",
            description: "Test description",
            dueDate: date,
            isCompleted: true,
            priority: .low
        )

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let encodedData = try encoder.encode(task)
        let decodedTask = try decoder.decode(Task.self, from: encodedData)

        XCTAssertEqual(task, decodedTask)
    }

    func testTaskPriorityEnum() {
        XCTAssertEqual(TaskPriority.low.rawValue, 0)
        XCTAssertEqual(TaskPriority.medium.rawValue, 1)
        XCTAssertEqual(TaskPriority.high.rawValue, 2)

        let lowPriority = TaskPriority(rawValue: 0)
        let mediumPriority = TaskPriority(rawValue: 1)
        let highPriority = TaskPriority(rawValue: 2)
        let invalidPriority = TaskPriority(rawValue: 10)

        XCTAssertEqual(lowPriority, .low)
        XCTAssertEqual(mediumPriority, .medium)
        XCTAssertEqual(highPriority, .high)
        XCTAssertNil(invalidPriority)
    }
}
