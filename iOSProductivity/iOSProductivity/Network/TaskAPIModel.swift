import Foundation

// MARK: - API Response Model
// Mirrors the FastAPI Task schema exactly.
// Snake_case ↔ camelCase conversion is handled by NetworkClient's JSONDecoder.

struct APITask: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let description: String?
    let dueDate: String?       // "yyyy-MM-dd" — decoded as String, converted locally
    let isCompleted: Bool

    // MARK: - Local convenience

    /// Converts the API date string to a `Date` for display.
    var dueDateValue: Date? {
        guard let raw = dueDate else { return nil }
        return APITask.dateFormatter.date(from: raw)
    }

    var dueDateDisplay: String {
        guard let date = dueDateValue else { return "" }
        let cal = Calendar.current
        if cal.isDateInToday(date)     { return "Today" }
        if cal.isDateInTomorrow(date)  { return "Tomorrow" }
        if cal.isDateInYesterday(date) { return "Yesterday" }
        let fmt = DateFormatter()
        fmt.dateStyle = .medium
        return fmt.string(from: date)
    }

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        f.locale = Locale(identifier: "en_US_POSIX")
        f.timeZone = TimeZone(secondsFromGMT: 0)
        return f
    }()
}

// MARK: - Create Request

struct TaskCreateRequest: Encodable {
    let title: String
    let description: String?
    let dueDate: String?       // "yyyy-MM-dd"
    let isCompleted: Bool

    static func make(
        title: String,
        description: String? = nil,
        dueDate: Date? = nil
    ) -> TaskCreateRequest {
        TaskCreateRequest(
            title: title,
            description: description?.isEmpty == true ? nil : description,
            dueDate: dueDate.map { TaskCreateRequest.dateFormatter.string(from: $0) },
            isCompleted: false
        )
    }

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        f.locale = Locale(identifier: "en_US_POSIX")
        f.timeZone = TimeZone(secondsFromGMT: 0)
        return f
    }()
}

// MARK: - Update Request

struct TaskUpdateRequest: Encodable {
    let title: String?
    let description: String?
    let dueDate: String?
    let isCompleted: Bool?

    /// Convenience: build a patch that only flips isCompleted.
    static func toggleCompleted(_ isCompleted: Bool) -> TaskUpdateRequest {
        TaskUpdateRequest(title: nil, description: nil, dueDate: nil, isCompleted: isCompleted)
    }
}
