import SwiftUI

struct TaskListScreen: View {
    // Placeholder for actual task data
    @State private var tasks: [TaskItem] = [
        TaskItem(id: UUID(), title: "Schedule meeting with team", dueDate: "Today", isCompleted: false),
        TaskItem(id: UUID(), title: "Review design mockups", dueDate: "Tomorrow", isCompleted: false),
        TaskItem(id: UUID(), title: "Prepare presentation slides", dueDate: "Friday", isCompleted: false),
        TaskItem(id: UUID(), title: "Submit expense report", dueDate: "Yesterday", isCompleted: true),
        TaskItem(id: UUID(), title: "Call client about project update", dueDate: "Next Monday", isCompleted: false)
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    TaskListRowView(
                        taskTitle: task.title,
                        dueDate: task.dueDate,
                        isCompleted: task.isCompleted
                    )
                    .listRowSeparator(.hidden) // Hiding default separators for custom styling
                }
                .onDelete(perform: deleteTask)
            }
            .listStyle(.plain) // Use plain list style to better control row appearance
            .background(Color(.designTokens.bg)) // Apply background color from design tokens
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Action to add a new task
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.primary) // Use primary color for the button
                    }
                }
            }
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        // In a real app, this would also trigger a backend/database update
    }
}

// Simple struct to represent a task item for previewing
struct TaskItem: Identifiable {
    let id: UUID
    let title: String
    let dueDate: String
    var isCompleted: Bool
}

struct TaskListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskListScreen()
    }
}

// Extension to access design tokens - assuming these are defined elsewhere
extension Color {
    static let designTokens = DesignTokens()
}

struct DesignTokens {
    let primary: Color = Color(red: 0/255, green: 51/255, blue: 77/255) // #00334d
    let secondary: Color = Color(red: 83/255, green: 96/255, blue: 107/255) // #53606b
    let bg: Color = Color(red: 247/255, green: 249/255, blue: 252/255) // #f7f9fc
    let surface: Color = Color(red: 247/255, green: 249/255, blue: 252/255) // #f7f9fc
    let onPrimary: Color = .white // #ffffff
    let outline: Color = Color(red: 113/255, green: 122/255, blue: 127/255) // #71787f
    let tertiaryFixed: Color = Color(red: 255/255, green: 219/255, blue: 209/255) // #ffdbd2
    let errorContainer: Color = Color(red: 255/255, green: 209/255, blue: 209/255) // #ffdad6
    let onSecondaryFixed: Color = Color(red: 16/255, green: 29/255, blue: 38/255) // #101d26
    let onError: Color = .white // #ffffff
    let primaryContainer: Color = Color(red: 0/255, green: 75/255, blue: 110/255) // #004b6e
    let onPrimaryFixedVariant: Color = Color(red: 1/255, green: 75/255, blue: 110/255) // #014b6e
    let secondaryFixedDim: Color = Color(red: 187/255, green: 200/255, blue: 213/255) // #bbc8d5
    let tertiaryFixedDim: Color = Color(red: 255/255, green: 180/255, blue: 161/255) // #ffb4a1
}
