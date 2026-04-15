import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var email: String
    var registrationDate: Date

    init(id: UUID = UUID(), name: String, email: String, registrationDate: Date = Date()) {
        self.id = id
        self.name = name
        self.email = email
        self.registrationDate = registrationDate
    }
}
