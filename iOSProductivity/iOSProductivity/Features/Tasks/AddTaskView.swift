import SwiftUI

// MARK: - Add Task Sheet

struct AddTaskView: View {
    @EnvironmentObject private var store: TaskStore
    @Environment(\.dismiss) private var dismiss

    // Form fields
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var hasDueDate: Bool = false
    @State private var dueDate: Date = Calendar.current.startOfDay(for: Date())

    // UI state
    @State private var isSaving: Bool = false
    @FocusState private var titleFocused: Bool

    private var canSave: Bool { !title.trimmingCharacters(in: .whitespaces).isEmpty }

    var body: some View {
        NavigationView {
            ZStack {
                Color.dsBackground.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        titleField
                        descriptionField
                        dueDateSection
                        Spacer(minLength: 40)
                    }
                    .padding(24)
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(Color.dsOnSurfaceVariant)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
            .onAppear { titleFocused = true }
        }
    }

    // MARK: - Title Field

    private var titleField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Title")
                .font(.dsLabelMd.weight(.semibold))
                .foregroundColor(Color.dsOnSurfaceVariant)

            TextField("What needs to be done?", text: $title)
                .font(.dsTitleMd)
                .foregroundColor(Color.dsOnSurface)
                .padding(16)
                .background(Color.dsSurfaceContainerLowest)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(
                            titleFocused ? Color.dsPrimary.opacity(0.3) : Color.clear,
                            lineWidth: 1.5
                        )
                )
                .focused($titleFocused)
                .submitLabel(.next)
                .accessibilityLabel("Task title")
        }
    }

    // MARK: - Description Field

    private var descriptionField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.dsLabelMd.weight(.semibold))
                .foregroundColor(Color.dsOnSurfaceVariant)

            // TextEditor is available since iOS 14 and supports multiline natively.
            ZStack(alignment: .topLeading) {
                // Placeholder text (TextEditor has no built-in placeholder)
                if description.isEmpty {
                    Text("Add notes (optional)")
                        .font(.dsBodyMd)
                        .foregroundColor(Color.dsOnSurfaceVariant.opacity(0.6))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                        .allowsHitTesting(false)
                }
                TextEditor(text: $description)
                    .font(.dsBodyMd)
                    .foregroundColor(Color.dsOnSurface)
                    .frame(minHeight: 88, maxHeight: 140)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .onAppear { UITextView.appearance().backgroundColor = .clear }
                    .onDisappear { UITextView.appearance().backgroundColor = nil }
            }
            .background(Color.dsSurfaceContainerLowest)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .accessibilityLabel("Task description")
        }
    }

    // MARK: - Due Date Section

    private var dueDateSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Due Date")
                .font(.dsLabelMd.weight(.semibold))
                .foregroundColor(Color.dsOnSurfaceVariant)

            // Toggle row
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 16))
                    .foregroundColor(hasDueDate ? Color.dsPrimary : Color.dsOnSurfaceVariant)
                    .frame(width: 32)

                Text(hasDueDate ? "Set for \(formattedDate)" : "No due date")
                    .font(.dsTitleSm)
                    .foregroundColor(hasDueDate ? Color.dsOnSurface : Color.dsOnSurfaceVariant)

                Spacer()

                Toggle("", isOn: $hasDueDate)
                    .tint(Color.dsPrimary)
                    .labelsHidden()
            }
            .padding(16)
            .background(Color.dsSurfaceContainerLowest)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

            // Date picker — shown when toggle is on
            if hasDueDate {
                DatePicker(
                    "Due date",
                    selection: $dueDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .tint(Color.dsPrimary)
                .padding(16)
                .background(Color.dsSurfaceContainerLowest)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .labelsHidden()
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.3), value: hasDueDate)
    }

    // MARK: - Save Button

    private var saveButton: some View {
        Button {
            Task { await save() }
        } label: {
            Group {
                if isSaving {
                    ProgressView()
                        .tint(.white)
                        .frame(width: 60)
                } else {
                    Text("Save")
                        .font(.dsLabelMd.weight(.semibold))
                        .frame(width: 60)
                }
            }
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .background(canSave
                ? AnyView(LinearGradient.dsActionGradient)
                : AnyView(Color.dsOutlineVariant))
            .clipShape(Capsule())
        }
        .disabled(!canSave || isSaving)
        .animation(.spring(response: 0.2), value: canSave)
    }

    // MARK: - Helpers

    private var formattedDate: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: dueDate)
    }

    private func save() async {
        guard canSave else { return }
        isSaving = true
        await store.createTask(
            title: title.trimmingCharacters(in: .whitespaces),
            description: description.trimmingCharacters(in: .whitespaces).isEmpty ? nil : description,
            dueDate: hasDueDate ? dueDate : nil
        )
        isSaving = false
        dismiss()
    }
}

// MARK: - Preview

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(TaskStore())
    }
}
