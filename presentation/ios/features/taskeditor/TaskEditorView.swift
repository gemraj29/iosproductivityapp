```swift
import SwiftUI

struct TaskEditorView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: TaskPriority = .medium

    // Enum for task priority, matching potential backend/domain models
    enum TaskPriority: String, CaseIterable, Identifiable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"

        var id: String { self.rawValue }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Task Title Input
                TextField("Task Title", text: $taskTitle)
                    .padding()
                    .background(Color.surface)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .font(.inter(.body))
                    .foregroundColor(.onPrimary) // Assuming onPrimary for text input

                // Task Description Input
                TextEditor(text: $taskDescription)
                    .padding()
                    .frame(minHeight: 100, alignment: .topLeading)
                    .background(Color.surface)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .font(.inter(.body))
                    .foregroundColor(.onPrimary) // Assuming onPrimary for text input

                // Due Date Picker
                DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical)
                    .accentColor(.primary) // Use primary color for accent
                    .font(.inter(.body))
                    .padding(.vertical, 8)
                    .background(Color.surface)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)

                // Priority Picker
                Picker("Priority", selection: $priority) {
                    ForEach(TaskPriority.allCases) { p in
                        Text(p.rawValue).tag(p)
                    }
                }
                .pickerStyle(.menu)
                .font(.inter(.body))
                .padding(.vertical, 8)
                .background(Color.surface)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                .accentColor(.primary) // Use primary color for accent

                Spacer()

                // Save Button
                Button {
                    // TODO: Implement save logic
                    print("Saving task: \(taskTitle)")
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save Task")
                        .font(.inter(.headline))
                        .foregroundColor(.onPrimary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primary)
                        .cornerRadius(8)
                }
                .padding(.top)
            }
            .padding()
            .background(Color.bg.ignoresSafeArea())
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.secondary)
                }
            }
        }
    }
}

// MARK: - Preview

struct TaskEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditorView()
    }
}

// MARK: - Helper Extensions for Font

extension Font {
    enum InterWeight: String {
        case black = "Inter-Black"
        case bold = "Inter-Bold"
        case extraBold = "Inter-ExtraBold"
        case extraLight = "Inter-ExtraLight"
        case light = "Inter-Light"
        case medium = "Inter-Medium"
        case regular = "Inter-Regular"
        case semiBold = "Inter-SemiBold"
        case thin = "Inter-Thin"
    }

    static func inter(_ weight: InterWeight = .regular, size: CGFloat = 16) -> Font {
        return .custom(weight.rawValue, size: size)
    }

    // Convenience for common sizes
    static func inter(_ style: FontStyle) -> Font {
        switch style {
        case .headline:
            return .inter(.semiBold, size: 20)
        case .body:
            return .inter(.regular, size: 16)
        case .caption:
            return .inter(.regular, size: 12)
        }
    }

    enum FontStyle {
        case headline
        case body
        case caption
    }
}

// MARK: - Helper Extensions for Color

extension Color {
    // Design Tokens
    static let primary = Color("primary") // #00334d
    static let secondary = Color("secondary") // #53606b
    static let bg = Color("bg") // #f7f9fc
    static let surface = Color("surface") // #f7f9fc
    static let onPrimary = Color("onPrimary") // #ffffff
    static let outline = Color("outline") // #71787f
    static let tertiaryFixed = Color("tertiaryFixed") // #ffdbd2
    static let errorContainer = Color("errorContainer") // #ffdad6
    static let onSecondaryFixed = Color("onSecondaryFixed") // #101d26
    static let onError = Color("onError") // #ffffff
    static let primaryContainer = Color("primaryContainer") // #004b6e
    static let onPrimaryFixedVariant = Color("onPrimaryFixedVariant") // #014b6e
    static let secondaryFixedDim = Color("secondaryFixedDim") // #bbc8d5
    static let tertiaryFixedDim = Color("tertiaryFixedDim") // #ffb4a1

    // Initialize from hex (for easier token definition if needed)
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
```
