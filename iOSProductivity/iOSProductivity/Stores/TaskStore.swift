import Foundation
import SwiftUI

// MARK: - Task Store
// Single source of truth for all task data.
// Injected as an @EnvironmentObject from the root so every tab shares the same state.

@MainActor
final class TaskStore: ObservableObject {

    // MARK: - Published State

    @Published private(set) var tasks: [APITask] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false

    // MARK: - Derived views

    var activeTasks: [APITask]    { tasks.filter { !$0.isCompleted } }
    var completedTasks: [APITask] { tasks.filter {  $0.isCompleted } }

    // MARK: - Dependencies

    private let service: TaskServiceProtocol

    init(service: TaskServiceProtocol = TaskService.shared) {
        self.service = service
    }

    // MARK: - Actions

    /// Loads all tasks from the backend. Call once on app start and on pull-to-refresh.
    func fetchTasks() async {
        isLoading = true
        defer { isLoading = false }
        do {
            tasks = try await service.fetchTasks()
        } catch {
            present(error: error)
        }
    }

    /// Creates a new task and inserts it at the front of the list optimistically.
    func createTask(title: String, description: String? = nil, dueDate: Date? = nil) async {
        let request = TaskCreateRequest.make(title: title, description: description, dueDate: dueDate)
        do {
            let created = try await service.createTask(request)
            tasks.insert(created, at: 0)
        } catch {
            present(error: error)
        }
    }

    /// Toggles the isCompleted flag on a task and syncs to the backend.
    func toggleComplete(_ task: APITask) async {
        // Optimistic update — APITask is a value type (struct with let properties),
        // so we build a new copy and replace the element in the array.
        let toggled = APITask(
            id:          task.id,
            title:       task.title,
            description: task.description,
            dueDate:     task.dueDate,
            isCompleted: !task.isCompleted
        )
        replace(with: toggled)
        do {
            let updated = try await service.updateTask(
                id: task.id,
                request: .toggleCompleted(!task.isCompleted)
            )
            replace(with: updated)
        } catch {
            replace(with: task)   // rollback to original
            present(error: error)
        }
    }

    /// Deletes a task from the backend and removes it from the list optimistically.
    func deleteTask(_ task: APITask) async {
        // Optimistic removal
        tasks.removeAll { $0.id == task.id }
        do {
            _ = try await service.deleteTask(id: task.id)
        } catch {
            // Rollback — re-insert at original position (approximate: append)
            tasks.append(task)
            present(error: error)
        }
    }

    // MARK: - Private Helpers

    private func replace(with updated: APITask) {
        if let index = tasks.firstIndex(where: { $0.id == updated.id }) {
            tasks[index] = updated
        }
    }

    private func present(error: Error) {
        errorMessage = error.localizedDescription
        showError = true
    }
}
