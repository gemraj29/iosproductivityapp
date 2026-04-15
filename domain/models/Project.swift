import Foundation

struct Project: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var color: String? // Hex color string, e.g., "#FF0000"
    var creationDate: Date

    init(id: UUID = UUID(), name: String, color: String? = nil, creationDate: Date = Date()) {
        self.id = id
        self.name = name
        self.color = color
        self.creationDate = creationDate
    }
}
