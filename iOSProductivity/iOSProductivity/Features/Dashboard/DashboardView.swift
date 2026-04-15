import SwiftUI

// MARK: - Dashboard View

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                DSAppBar()

                VStack(alignment: .leading, spacing: 28) {
                    GreetingSection()
                    FocusSessionBannerView()
                    DailyObjectiveSection()
                    UpNextSection()
                    ActivityInsightsSection()
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 32)
            }
        }
        .background(Color.dsBackground.ignoresSafeArea())
    }
}

// MARK: - Greeting Section

private struct GreetingSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Good Morning,")
                .font(.dsBodyMd)
                .foregroundColor(Color.dsOnSurfaceVariant)
            Text("Alexander.")
                .font(.dsDisplayMd)
                .foregroundColor(Color.dsOnSurface)
                .tracking(-0.5)
        }
    }
}

// MARK: - Focus Session Banner

private struct FocusSessionBannerView: View {
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Focus Session")
                    .font(.dsTitleMd)
                    .foregroundColor(.white)
                Text("Next: Deep Work — 25 min")
                    .font(.dsBodySm)
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()
            Image(systemName: "timer")
                .font(.system(size: 28))
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(20)
        .background(LinearGradient.dsActionGradient)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .dsPrimaryShadow()
    }
}

// MARK: - Daily Objective Section

private struct DailyObjectiveSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Daily Objective")
                .font(.dsHeadlineSm)
                .foregroundColor(Color.dsOnSurface)

            HStack(spacing: 20) {
                // Progress ring
                ProgressRingView(progress: 0.72, size: 100)

                VStack(alignment: .leading, spacing: 8) {
                    Text("72% Complete")
                        .font(.dsTitleMd)
                        .foregroundColor(Color.dsOnSurface)
                    Text("9 of 12 tasks done")
                        .font(.dsBodyMd)
                        .foregroundColor(Color.dsOnSurfaceVariant)

                    HStack(spacing: 8) {
                        StatPill(label: "3 left", icon: "clock")
                        StatPill(label: "2 high", icon: "exclamationmark")
                    }
                }

                Spacer()
            }
            .padding(20)
            .background(Color.dsSurfaceContainerLow)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
}

private struct ProgressRingView: View {
    let progress: Double
    let size: CGFloat

    var body: some View {
        ZStack {
            // Track
            Circle()
                .stroke(Color.dsSurfaceContainerHighest, lineWidth: 8)

            // Progress arc
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient.dsActionGradient,
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1.0), value: progress)

            // Center label
            VStack(spacing: 0) {
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.dsPrimary)
            }
        }
        .frame(width: size, height: size)
    }
}

private struct StatPill: View {
    let label: String
    let icon: String

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 10))
            Text(label)
                .font(.dsLabelSm)
        }
        .foregroundColor(Color.dsOnSurfaceVariant)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.dsSurfaceContainerLowest)
        .clipShape(Capsule())
    }
}

// MARK: - Up Next Section

private struct UpNextSection: View {
    private let upNextTasks: [UpNextTask] = [
        UpNextTask(title: "Redesign Client Dashboard",  time: "5:00 PM",  priority: .high),
        UpNextTask(title: "Prepare Q3 Fiscal Report",   time: "Tomorrow", priority: .medium),
        UpNextTask(title: "Weekly Team Sync",            time: "10:00 AM", priority: .low),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Up Next")
                    .font(.dsHeadlineSm)
                    .foregroundColor(Color.dsOnSurface)
                Spacer()
                Text("See all")
                    .font(.dsLabelMd)
                    .foregroundColor(Color.dsPrimary)
            }

            VStack(spacing: 10) {
                ForEach(upNextTasks) { task in
                    UpNextTaskRow(task: task)
                }
            }
        }
    }
}

private struct UpNextTask: Identifiable {
    enum Priority { case high, medium, low }
    let id = UUID()
    let title: String
    let time: String
    let priority: Priority
}

private struct UpNextTaskRow: View {
    let task: UpNextTask

    private var accentColor: Color {
        switch task.priority {
        case .high:   return Color.dsTertiaryContainer
        case .medium: return Color.dsSecondaryFixedDim
        case .low:    return Color.dsPrimaryFixed
        }
    }

    private var priorityLabel: String {
        switch task.priority {
        case .high:   return "High"
        case .medium: return "Med"
        case .low:    return "Low"
        }
    }

    private var pillTextColor: Color {
        switch task.priority {
        case .high:   return Color.dsOnTertiaryFixed
        case .medium: return Color.dsOnSecondaryFixedVariant
        case .low:    return Color.dsOnPrimaryFixedVariant
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            // Left accent bar
            Rectangle()
                .fill(accentColor)
                .frame(width: 4)
                .clipShape(RoundedRectangle(cornerRadius: 2))

            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.dsTitleSm)
                        .foregroundColor(Color.dsOnSurface)
                        .lineLimit(1)

                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 10))
                        Text(task.time)
                            .font(.dsLabelSm)
                    }
                    .foregroundColor(Color.dsOnSurfaceVariant)
                }

                Spacer()

                Text(priorityLabel)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(pillTextColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(accentColor)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(Color.dsSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .dsPrimaryShadow(radius: 8, y: 4)
    }
}

// MARK: - Activity Insights Section

private struct ActivityInsightsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Activity Insights")
                .font(.dsHeadlineSm)
                .foregroundColor(Color.dsOnSurface)

            HStack(spacing: 12) {
                InsightCard(
                    icon:       "brain.head.profile",
                    label:      "Focus Score",
                    value:      "89",
                    unit:       "/100",
                    background: Color.dsPrimaryFixed
                )
                InsightCard(
                    icon:       "clock.fill",
                    label:      "Deep Work",
                    value:      "4.2",
                    unit:       "hrs",
                    background: Color.dsTertiaryFixed
                )
            }
        }
    }
}

private struct InsightCard: View {
    let icon: String
    let label: String
    let value: String
    let unit: String
    let background: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Color.dsPrimary)
                .frame(width: 40, height: 40)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.dsLabelSm)
                    .foregroundColor(Color.dsOnSurfaceVariant)
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    Text(value)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color.dsOnSurface)
                    Text(unit)
                        .font(.dsBodySm)
                        .foregroundColor(Color.dsOnSurfaceVariant)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.dsSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .dsPrimaryShadow(radius: 10, y: 4)
    }
}

// MARK: - Preview

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
