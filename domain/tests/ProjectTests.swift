import XCTest
@testable import domain

final class ProjectTests: XCTestCase {

    func testProjectInitialization() {
        let id = UUID()
        let name = "iOS Productivity App"
        let colorHex = "#00334d"
        let tasks: [Task] = []

        let project = Project(
            id: id,
            name: name,
            colorHex: colorHex,
            tasks: tasks
        )

        XCTAssertEqual(project.id, id)
        XCTAssertEqual(project.name, name)
        XCTAssertEqual(project.colorHex, colorHex)
        XCTAssertEqual(project.tasks, tasks)
    }

    func testProjectEquality() {
        let id = UUID()
        let project1 = Project(
            id: id,
            name: "Project Alpha",
            colorHex: "#FF0000",
            tasks: []
        )
        let project2 = Project(
            id: id,
            name: "Project Beta",
            colorHex: "#00FF00",
            tasks: [Task.sample]
        )
        let project3 = Project(
            id: UUID(),
            name: "Project Gamma",
            colorHex: "#0000FF",
            tasks: []
        )

        XCTAssertEqual(project1, project2)
        XCTAssertNotEqual(project1, project3)
    }

    func testProjectCodable() throws {
        let project = Project(
            id: UUID(),
            name: "Codable Project",
            colorHex: "#123456",
            tasks: [Task.sample]
        )

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let encodedData = try encoder.encode(project)
        let decodedProject = try decoder.decode(Project.self, from: encodedData)

        XCTAssertEqual(project, decodedProject)
    }
}
