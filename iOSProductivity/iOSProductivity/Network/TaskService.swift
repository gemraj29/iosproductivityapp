import Foundation

// MARK: - Task Service Protocol

protocol TaskServiceProtocol: Sendable {
    func fetchTasks() async throws -> [APITask]
    func createTask(_ request: TaskCreateRequest) async throws -> APITask
    func updateTask(id: Int, request: TaskUpdateRequest) async throws -> APITask
    func deleteTask(id: Int) async throws -> APITask
}

// MARK: - Live Implementation

final class TaskService: TaskServiceProtocol, @unchecked Sendable {

    static let shared = TaskService()

    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = NetworkClient.shared) {
        self.client = client
    }

    func fetchTasks() async throws -> [APITask] {
        try await client.get(path: "tasks/")
    }

    func createTask(_ request: TaskCreateRequest) async throws -> APITask {
        try await client.post(path: "tasks/", body: request)
    }

    func updateTask(id: Int, request: TaskUpdateRequest) async throws -> APITask {
        try await client.put(path: "tasks/\(id)", body: request)
    }

    func deleteTask(id: Int) async throws -> APITask {
        try await client.delete(path: "tasks/\(id)")
    }
}
