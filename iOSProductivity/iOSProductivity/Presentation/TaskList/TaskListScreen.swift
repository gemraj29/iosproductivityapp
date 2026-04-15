import SwiftUI

// MARK: - Task List Screen

struct TaskListScreen: View {
    @EnvironmentObject private var store: TaskStore
    @State private var activeTab: TaskTab = .active
    @State private var showAddTask: Bool = false

    enum TaskTab { case active, completed }

    private var displayedTasks: [APITask] {
        activeTab == .active ? store.activeTasks : store.completedTasks
    }

    var body: some View {
        VStack(spacing: 0) {
            DSAppBar()

            ZStack {
                Color.dsBackground.ignoresSafeArea()

                if store.isLoading && store.tasks.isEmpty {
                    loadingView
                } else {
                    taskContent
                }
            }
        }
        .background(Color.dsBackground.ignoresSafeArea())
        .overlay(alignment: .bottomTrailing) { fabButton }
        .sheet(isPresented: $showAddTask) {
            AddTaskView()
                .environmentObject(store)
        }
        .alert("Something went wrong", isPresented: $store.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(store.errorMessage ?? "Unknown error")
        }
        .task {
            if store.tasks.isEmpty {
                await store.fetchTasks()
            }
        }
        .refreshable {
            await store.fetchTasks()
        }
    }

    // MARK: - Content

    private var taskContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                heroSection
                tabToggle.padding(.bottom, 28)

                if displayedTasks.isEmpty {
                    emptyState
                        .padding(.top, 40)
                } else {
                    taskList
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 120)
        }
    }

    // MARK: - Hero

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Daily Flow")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(Color.dsOnSurface)
                .tracking(-0.8)

            Text("You have \(store.activeTasks.count) active task\(store.activeTasks.count == 1 ? "" : "s").")
                .font(.dsBodyMd)
                .foregroundColor(Color.dsOnSurfaceVariant)
        }
        .padding(.bottom, 24)
    }

    // MARK: - Tab Toggle

    private var tabToggle: some View {
        HStack(spacing: 0) {
            TabPill(
                label: "Active",
                count: store.activeTasks.count,
                isSelected: activeTab == .active
            ) {
                withAnimation(.spring(response: 0.3)) { activeTab = .active }
            }
            TabPill(
                label: "Completed",
                count: store.completedTasks.count,
                isSelected: activeTab == .completed
            ) {
                withAnimation(.spring(response: 0.3)) { activeTab = .completed }
            }
        }
        .padding(4)
        .background(Color.dsSurfaceContainerHigh)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    // MARK: - Task List

    private var taskList: some View {
        VStack(spacing: 12) {
            ForEach(displayedTasks) { task in
                LiveTaskCard(task: task)
                    .environmentObject(store)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal:   .move(edge: .leading).combined(with: .opacity)
                    ))
            }
        }
        .animation(.spring(response: 0.35), value: displayedTasks.map(\.id))
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: activeTab == .active ? "tray" : "checkmark.seal")
                .font(.system(size: 48))
                .foregroundColor(Color.dsOutlineVariant)

            Text(activeTab == .active ? "No active tasks" : "Nothing completed yet")
                .font(.dsHeadlineSm)
                .foregroundColor(Color.dsOnSurfaceVariant)

            if activeTab == .active {
                Text("Tap + to add your first task")
                    .font(.dsBodyMd)
                    .foregroundColor(Color.dsOutlineVariant)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }

    // MARK: - Loading

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.3)
                .tint(Color.dsPrimary)
            Text("Loading tasks…")
                .font(.dsBodyMd)
                .foregroundColor(Color.dsOnSurfaceVariant)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - FAB

    private var fabButton: some View {
        Button {
            showAddTask = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(LinearGradient.dsActionGradient)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .dsPrimaryShadow(radius: 20, y: 10)
        }
        .padding(.trailing, 24)
        .padding(.bottom, 100)
        .buttonStyle(.plain)
        .accessibilityLabel("Add new task")
    }
}

// MARK: - Tab Pill

private struct TabPill: View {
    let label: String
    let count: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Text(label)
                    .font(isSelected
                          ? .dsLabelMd.weight(.semibold)
                          : .dsLabelMd.weight(.medium))
                    .foregroundColor(isSelected ? Color.dsPrimary : Color.dsOnSurfaceVariant)

                Text("\(count)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(isSelected ? Color.dsPrimary : Color.dsOnSurfaceVariant)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(isSelected ? Color.dsPrimaryFixed : Color.dsSurfaceContainerHighest)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 9)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.dsSurfaceContainerLowest : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: isSelected ? Color.dsPrimary.opacity(0.06) : .clear,
                    radius: 4, x: 0, y: 2)
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.25), value: isSelected)
    }
}

// MARK: - Live Task Card

private struct LiveTaskCard: View {
    @EnvironmentObject private var store: TaskStore
    let task: APITask

    var body: some View {
        HStack(spacing: 0) {
            // Left priority bar — use tertiary (deep red) for visual anchor
            Rectangle()
                .fill(task.isCompleted ? Color.dsOutlineVariant : Color.dsPrimary)
                .frame(width: 4)
                .clipShape(RoundedRectangle(cornerRadius: 2))

            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(task.title)
                        .font(.dsTitleSm)
                        .foregroundColor(Color.dsOnSurface)
                        .strikethrough(task.isCompleted, color: Color.dsOutlineVariant)
                        .lineLimit(2)

                    if !task.dueDateDisplay.isEmpty {
                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                                .font(.system(size: 10))
                            Text(task.dueDateDisplay)
                                .font(.dsLabelSm)
                        }
                        .foregroundColor(Color.dsOnSurfaceVariant)
                    }

                    if let desc = task.description, !desc.isEmpty {
                        Text(desc)
                            .font(.dsBodySm)
                            .foregroundColor(Color.dsOnSurfaceVariant)
                            .lineLimit(2)
                    }
                }

                Spacer()

                // Completion toggle button
                Button {
                    Task { await store.toggleComplete(task) }
                } label: {
                    ZStack {
                        Circle()
                            .strokeBorder(
                                task.isCompleted ? Color.dsPrimary : Color.dsOutlineVariant,
                                lineWidth: 1.5
                            )
                            .background(
                                Circle()
                                    .fill(task.isCompleted ? Color.dsPrimary : Color.clear)
                            )
                            .frame(width: 26, height: 26)

                        if task.isCompleted {
                            Image(systemName: "checkmark")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .buttonStyle(.plain)
                .accessibilityLabel(task.isCompleted ? "Mark incomplete" : "Mark complete")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(Color.dsSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .dsPrimaryShadow(radius: 8, y: 3)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                Task { await store.deleteTask(task) }
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

// MARK: - Preview

struct TaskListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskListScreen()
            .environmentObject(TaskStore())
    }
}
