import XCTest
@testable import domain

final class FocusSessionTests: XCTestCase {

    func testFocusSessionInitialization() {
        let id = UUID()
        let startTime = Date()
        let endTime = Calendar.current.date(byAdding: .minute, value: 30, to: startTime)!
        let durationInMinutes = 30
        let associatedTaskId: UUID? = UUID()

        let session = FocusSession(
            id: id,
            startTime: startTime,
            endTime: endTime,
            durationInMinutes: durationInMinutes,
            associatedTaskId: associatedTaskId
        )

        XCTAssertEqual(session.id, id)
        XCTAssertEqual(session.startTime, startTime)
        XCTAssertEqual(session.endTime, endTime)
        XCTAssertEqual(session.durationInMinutes, durationInMinutes)
        XCTAssertEqual(session.associatedTaskId, associatedTaskId)
    }

    func testFocusSessionEquality() {
        let id = UUID()
        let startTime = Date()
        let endTime = Calendar.current.date(byAdding: .minute, value: 60, to: startTime)!
        let session1 = FocusSession(
            id: id,
            startTime: startTime,
            endTime: endTime,
            durationInMinutes: 60,
            associatedTaskId: UUID()
        )
        let session2 = FocusSession(
            id: id,
            startTime: startTime,
            endTime: endTime,
            durationInMinutes: 60,
            associatedTaskId: UUID()
        )
        let session3 = FocusSession(
            id: UUID(),
            startTime: startTime,
            endTime: endTime,
            durationInMinutes: 60,
            associatedTaskId: nil
        )

        XCTAssertEqual(session1, session2)
        XCTAssertNotEqual(session1, session3)
    }

    func testFocusSessionCodable() throws {
        let startTime = Date()
        let endTime = Calendar.current.date(byAdding: .hour, value: 1, to: startTime)!
        let session = FocusSession(
            id: UUID(),
            startTime: startTime,
            endTime: endTime,
            durationInMinutes: 60,
            associatedTaskId: UUID()
        )

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let encodedData = try encoder.encode(session)
        let decodedSession = try decoder.decode(FocusSession.self, from: encodedData)

        XCTAssertEqual(session, decodedSession)
    }
}
