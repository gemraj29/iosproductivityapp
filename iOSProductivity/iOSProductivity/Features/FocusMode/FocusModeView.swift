```swift
import SwiftUI

struct FocusModeView: View {
    @State private var timeRemaining = 1500 // Default to 25 minutes
    @State private var isTimerRunning = false
    @State private var selectedTask: String? = nil // Placeholder for task selection

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()

                // Timer Display
                Text(formatTime(timeRemaining))
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "#00334d")) // Primary color

                // Task Selection (Placeholder)
                if let task = selectedTask {
                    Text("Focusing on: \(task)")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#53606b")) // Secondary color
                } else {
                    Text("No task selected")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#53606b")) // Secondary color
                }

                Spacer()

                // Control Buttons
                HStack(spacing: 20) {
                    Button {
                        if isTimerRunning {
                            // Stop timer logic
                            isTimerRunning = false
                        } else {
                            // Start timer logic
                            isTimerRunning = true
                        }
                    } label: {
                        Text(isTimerRunning ? "Pause" : "Start")
                            .font(.title2.weight(.semibold))
                            .frame(minWidth: 120)
                            .padding()
                            .background(isTimerRunning ? Color(hex: "#53606b") : Color(hex: "#00334d")) // Secondary or Primary
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button {
                        // Reset timer logic
                        timeRemaining = 1500
                        isTimerRunning = false
                    } label: {
                        Text("Reset")
                            .font(.title2.weight(.semibold))
                            .frame(minWidth: 120)
                            .padding()
                            .background(Color(hex: "#ffdbd2")) // Tertiary fixed
                            .foregroundColor(Color(hex: "#00334d")) // Primary
                            .cornerRadius(8)
                    }
                }
                .padding(.bottom, 40)
            }
            .padding()
            .navigationTitle("Focus Mode")
            .onReceive(timer) { _ in
                guard isTimerRunning else { return }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    isTimerRunning = false
                    // Timer finished logic (e.g., play sound, show notification)
                }
            }
        }
    }

    // Helper function to format time into MM:SS
    func formatTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// Helper extension for UIColor to convert hex strings
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, (int >> 8) & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
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

struct FocusModeView_Previews: PreviewProvider {
    static var previews: some View {
        FocusModeView()
    }
}
```
