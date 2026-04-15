import SwiftUI

struct ProductivityStatsView: View {
    @State private var selectedTab: ProductivityStatsTab = .weekly

    enum ProductivityStatsTab: String, CaseIterable, Identifiable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"

        var id: String { self.rawValue }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Picker("Stats Period", selection: $selectedTab) {
                    ForEach(ProductivityStatsTab.allCases) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.surface)

                Divider()

                TabView(selection: $selectedTab) {
                    ProductivityStatsDetailView(period: .daily)
                        .tag(ProductivityStatsTab.daily)

                    ProductivityStatsDetailView(period: .weekly)
                        .tag(ProductivityStatsTab.weekly)

                    ProductivityStatsDetailView(period: .monthly)
                        .tag(ProductivityStatsTab.monthly)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .background(Color.bg.ignoresSafeArea())
            .navigationTitle("Productivity Stats")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // Action for back button
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.onPrimary)
                    }
                }
            }
        }
    }
}

struct ProductivityStatsDetailView: View {
    let period: ProductivityStatsView.ProductivityStatsTab

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("\(period.rawValue) Overview")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.onPrimary)
                    .padding(.top)

                StatsCardView(title: "Total Tasks Completed", value: "125", icon: "checkmark.circle.fill")
                StatsCardView(title: "Average Focus Time", value: "45 min", icon: "clock.fill")
                StatsCardView(title: "Tasks Overdue", value: "3", icon: "exclamationmark.triangle.fill", isWarning: true)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Completion Rate")
                        .font(.headline)
                        .foregroundColor(.onPrimary)

                    ProgressView(value: 0.75) {
                        Text("75%")
                            .font(.caption)
                            .foregroundColor(.onSecondaryFixed)
                    }
                    .progressViewStyle(LinearProgressViewStyle(tint: .primary))
                    .frame(height: 12)
                }
                .padding()
                .background(Color.surface)
                .cornerRadius(8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Activity Breakdown")
                        .font(.headline)
                        .foregroundColor(.onPrimary)

                    HStack {
                        ActivityItemView(label: "High Priority", value: 50, color: .primary)
                        ActivityItemView(label: "Medium Priority", value: 30, color: .secondary)
                        ActivityItemView(label: "Low Priority", value: 20, color: .tertiaryFixed)
                    }
                }
                .padding()
                .background(Color.surface)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.bg.ignoresSafeArea())
    }
}

struct StatsCardView: View {
    let title: String
    let value: String
    let icon: String
    var isWarning: Bool = false

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(isWarning ? .tertiaryFixed : .onPrimary)
                .frame(width: 40)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.onSecondaryFixed)
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(isWarning ? .tertiaryFixed : .onPrimary)
            }
            Spacer()
        }
        .padding()
        .background(Color.surface)
        .cornerRadius(8)
    }
}

struct ActivityItemView: View {
    let label: String
    let value: Int
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(value)%")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.onPrimary)
            Text(label)
                .font(.caption)
                .foregroundColor(.onSecondaryFixed)
            Capsule()
                .fill(color)
                .frame(height: 6)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProductivityStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductivityStatsView()
    }
}
