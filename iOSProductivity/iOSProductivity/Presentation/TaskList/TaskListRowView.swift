import SwiftUI

struct TaskListRowView: View {
    let taskTitle: String
    let dueDate: String
    let isCompleted: Bool

    var body: some View {
        HStack {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isCompleted ? .green : .secondary)
                .font(.title2)

            VStack(alignment: .leading) {
                Text(taskTitle)
                    .font(.body)
                    .foregroundColor(.primary)
                    .strikethrough(isCompleted, color: .secondary)

                Text(dueDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct TaskListRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListRowView(taskTitle: "Buy groceries", dueDate: "Tomorrow", isCompleted: false)
            .previewLayout(.sizeThatFits)
            .padding()
        TaskListRowView(taskTitle: "Finish report", dueDate: "Today", isCompleted: true)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
