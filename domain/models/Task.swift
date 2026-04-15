import Foundation

struct Task: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var description: String?
    var dueDate: Date?
    var isCompleted: Bool
    var priority: Priority
    var projectID: UUID? // Optional, if tasks can belong to projects

    enum Priority: String, Codable, Equatable, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
    }

    init(id: UUID = UUID(), title: String, description: String? = nil, dueDate: Date? = nil, isCompleted: Bool = false, priority: Priority = .medium, projectID: UUID? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.priority = priority
        self.projectID = projectID
    }
}
