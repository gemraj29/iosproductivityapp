import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Placeholder for Productivity Stats
                    ProductivityStatsView()
                        .padding(.horizontal)

                    // Placeholder for Upcoming Tasks
                    UpcomingTasksView()
                        .padding(.horizontal)

                    // Placeholder for Calendar Events
                    CalendarEventsView()
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color.surface)
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Action for settings
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.onPrimary)
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

// Placeholder for ProductivityStatsView
struct ProductivityStatsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Productivity Stats")
                .font(.headline)
                .foregroundColor(.onPrimary)

            HStack {
                StatCard(title: "Tasks Completed", value: "15", icon: "checkmark.circle.fill")
                StatCard(title: "Focus Time", value: "2h 30m", icon: "clock.fill")
            }
        }
        .padding()
        .background(Color.primaryContainer)
        .cornerRadius(8)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.onPrimary)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.onPrimary)
            }
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.onPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.primary.opacity(0.2))
        .cornerRadius(8)
    }
}

// Placeholder for UpcomingTasksView
struct UpcomingTasksView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Upcoming Tasks")
                    .font(.headline)
                    .foregroundColor(.onPrimary)
                Spacer()
                Button("See All") {
                    // Action to see all tasks
                }
                .foregroundColor(.secondary)
            }

            // Example Task Rows
            TaskRow(taskName: "Design new feature", dueDate: "Tomorrow", priority: .high)
            TaskRow(taskName: "Implement API endpoint", dueDate: "In 2 days", priority: .medium)
            TaskRow(taskName: "Write documentation", dueDate: "Friday", priority: .low)
        }
        .padding()
        .background(Color.primaryContainer)
        .cornerRadius(8)
    }
}

struct TaskRow: View {
    let taskName: String
    let dueDate: String
    let priority: TaskPriority

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(taskName)
                    .font(.body)
                    .foregroundColor(.onPrimary)
                Text(dueDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Circle()
                .fill(priority.color)
                .frame(width: 12, height: 12)
        }
        .padding(.vertical, 4)
    }
}

enum TaskPriority {
    case high, medium, low

    var color: Color {
        switch self {
        case .high:
            return .red // Using a distinct color, could be mapped from design tokens if available
        case .medium:
            return .orange // Using a distinct color
        case .low:
            return .green // Using a distinct color
        }
    }
}

// Placeholder for CalendarEventsView
struct CalendarEventsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Upcoming Events")
                    .font(.headline)
                    .foregroundColor(.onPrimary)
                Spacer()
                Button("Calendar") {
                    // Action to open calendar
                }
                .foregroundColor(.secondary)
            }

            // Example Event Rows
            EventRow(eventName: "Team Meeting", time: "10:00 AM", color: .blue)
            EventRow(eventName: "Client Call", time: "2:00 PM", color: .purple)
        }
        .padding()
        .background(Color.primaryContainer)
        .cornerRadius(8)
    }
}

struct EventRow: View {
    let eventName: String
    let time: String
    let color: Color

    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            VStack(alignment: .leading) {
                Text(eventName)
                    .font(.body)
                    .foregroundColor(.onPrimary)
                Text(time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
