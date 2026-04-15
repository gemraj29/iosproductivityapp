import SwiftUI

@main
struct iOSProductivityApp: App {
    /// Shared task store — lives for the lifetime of the app and is shared
    /// across all tabs via the environment.
    @StateObject private var taskStore = TaskStore()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(taskStore)
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Home",  systemImage: "house.fill") }

            TaskListScreen()
                .tabItem { Label("Tasks", systemImage: "list.bullet.rectangle") }

            FocusModeView()
                .tabItem { Label("Focus", systemImage: "timer") }

            ProductivityStatsView()
                .tabItem { Label("Stats", systemImage: "chart.bar.fill") }
        }
        .tint(Color.dsPrimary)
    }
}
