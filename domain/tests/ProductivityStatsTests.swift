import XCTest
@testable import domain

final class ProductivityStatsTests: XCTestCase {

    func testProductivityStatsInitialization() {
        let totalTasksCompleted = 150
        let averageCompletionTimeInHours = 2.5
        let tasksCompletedToday = 10
        let tasksCompletedThisWeek = 75

        let stats = ProductivityStats(
            totalTasksCompleted: totalTasksCompleted,
            averageCompletionTimeInHours: averageCompletionTimeInHours,
            tasksCompletedToday: tasksCompletedToday,
            tasksCompletedThisWeek: tasksCompletedThisWeek
        )

        XCTAssertEqual(stats.totalTasksCompleted, totalTasksCompleted)
        XCTAssertEqual(stats.averageCompletionTimeInHours, averageCompletionTimeInHours)
        XCTAssertEqual(stats.tasksCompletedToday, tasksCompletedToday)
        XCTAssertEqual(stats.tasksCompletedThisWeek, tasksCompletedThisWeek)
    }

    func testProductivityStatsEquality() {
        let stats1 = ProductivityStats(
            totalTasksCompleted: 100,
            averageCompletionTimeInHours: 3.0,
            tasksCompletedToday: 5,
            tasksCompletedThisWeek: 50
        )
        let stats2 = ProductivityStats(
            totalTasksCompleted: 100,
            averageCompletionTimeInHours: 3.0,
            tasksCompletedToday: 5,
            tasksCompletedThisWeek: 50
        )
        let stats3 = ProductivityStats(
            totalTasksCompleted: 200,
            averageCompletionTimeInHours: 2.0,
            tasksCompletedToday: 15,
            tasksCompletedThisWeek: 100
        )

        XCTAssertEqual(stats1, stats2)
        XCTAssertNotEqual(stats1, stats3)
    }

    func testProductivityStatsCodable() throws {
        let stats = ProductivityStats(
            totalTasksCompleted: 50,
            averageCompletionTimeInHours: 1.5,
            tasksCompletedToday: 3,
            tasksCompletedThisWeek: 25
        )

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let encodedData = try encoder.encode(stats)
        let decodedStats = try decoder.decode(ProductivityStats.self, from: encodedData)

        XCTAssertEqual(stats, decodedStats)
    }
}
