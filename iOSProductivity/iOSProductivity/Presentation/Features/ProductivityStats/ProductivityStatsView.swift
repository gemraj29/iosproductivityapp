import SwiftUI

// MARK: - Productivity Stats View

struct ProductivityStatsView: View {
    @State private var selectedPeriod: StatsPeriod = .week

    var body: some View {
        VStack(spacing: 0) {
            DSAppBar()

            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    pageHeader
                    metricCardsGrid
                    trendChart
                    detailsGrid
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 120)
            }
        }
        .background(Color.dsBackground.ignoresSafeArea())
    }

    // MARK: - Header

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("PERFORMANCE ANALYTICS")
                .font(.system(size: 11, weight: .semibold, design: .default))
                .foregroundColor(Color.dsOnSurfaceVariant)
                .tracking(2)

            Text("Productivity Stats")
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundColor(Color.dsOnSurface)
                .tracking(-0.5)

            // Accent underline
            LinearGradient.dsActionGradient
                .frame(width: 60, height: 4)
                .clipShape(Capsule())
        }
    }

    // MARK: - Metric Cards Grid

    private var metricCardsGrid: some View {
        VStack(spacing: 14) {
            HStack(spacing: 14) {
                StatMetricCard(
                    icon:       "checkmark.circle.fill",
                    iconColor:  Color.dsPrimary,
                    iconBg:     Color.dsPrimaryFixed,
                    title:      "Total Tasks Completed",
                    value:      "142",
                    unit:       nil,
                    badge:      "+12%",
                    badgeColor: .green
                )
                StatMetricCard(
                    icon:       "chart.line.uptrend.xyaxis",
                    iconColor:  Color.dsPrimary,
                    iconBg:     Color.dsSecondaryContainer.opacity(0.5),
                    title:      "Avg. Daily Productivity",
                    value:      "8.4",
                    unit:       "tasks / day",
                    badge:      nil,
                    badgeColor: .clear
                )
            }
            StatMetricCard(
                icon:       "flame.fill",
                iconColor:  Color.dsTertiaryContainer,
                iconBg:     Color.dsTertiaryFixed,
                title:      "Longest Streak",
                value:      "18",
                unit:       "days",
                badge:      nil,
                badgeColor: .clear
            )
        }
    }

    // MARK: - Trend Chart

    private var trendChart: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Task Completion Trends")
                        .font(.dsHeadlineSm)
                        .foregroundColor(Color.dsOnSurface)
                    Text("Weekly performance overview")
                        .font(.dsBodySm)
                        .foregroundColor(Color.dsOnSurfaceVariant)
                }

                Spacer()

                PeriodToggle(selected: $selectedPeriod)
            }

            WeeklyBarChart(selectedPeriod: selectedPeriod)
        }
        .padding(24)
        .background(Color.dsSurfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    // MARK: - Details Grid (Efficiency + Daily Insight)

    private var detailsGrid: some View {
        VStack(spacing: 16) {
            EfficiencyPulseCard()
            DailyInsightCard()
        }
    }
}

// MARK: - Stat Metric Card

private struct StatMetricCard: View {
    let icon: String
    let iconColor: Color
    let iconBg: Color
    let title: String
    let value: String
    let unit: String?
    let badge: String?
    let badgeColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(iconColor)
                .frame(width: 40, height: 40)
                .background(iconBg)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            Text(title)
                .font(.dsLabelMd.weight(.semibold))
                .foregroundColor(Color.dsOnSurfaceVariant)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            HStack(alignment: .lastTextBaseline, spacing: 6) {
                Text(value)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(Color.dsOnSurface)

                if let unit {
                    Text(unit)
                        .font(.dsBodySm.italic())
                        .foregroundColor(Color.dsOnSurfaceVariant)
                }

                if let badge {
                    Text(badge)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.green)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(Color.green.opacity(0.12))
                        .clipShape(Capsule())
                }
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.dsSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .dsPrimaryShadow(radius: 10, y: 4)
    }
}

// MARK: - Period Toggle

enum StatsPeriod { case week, month }

private struct PeriodToggle: View {
    @Binding var selected: StatsPeriod

    var body: some View {
        HStack(spacing: 0) {
            PillButton(label: "Week",  isOn: selected == .week)  { selected = .week  }
            PillButton(label: "Month", isOn: selected == .month) { selected = .month }
        }
        .padding(3)
        .background(Color.dsSurfaceContainerHighest)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

private struct PillButton: View {
    let label: String
    let isOn: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.dsLabelSm.weight(isOn ? .semibold : .medium))
                .foregroundColor(isOn ? Color.dsPrimary : Color.dsOnSurfaceVariant)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isOn ? Color.dsSurfaceContainerLowest : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                .shadow(color: isOn ? Color.dsPrimary.opacity(0.06) : .clear, radius: 3)
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.25), value: isOn)
    }
}

// MARK: - Weekly Bar Chart

private struct WeeklyBarChart: View {
    let selectedPeriod: StatsPeriod

    // (day label, task count, isHighlighted)
    private let weekData: [(String, Int, Bool)] = [
        ("MON", 6,  false),
        ("TUE", 9,  false),
        ("WED", 12, true),
        ("THU", 8,  false),
        ("FRI", 10, false),
        ("SAT", 4,  false),
        ("SUN", 3,  false),
    ]
    private let maxCount = 12

    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(weekData, id: \.0) { day, count, highlighted in
                    VStack(spacing: 6) {
                        // Task count label above bar
                        Text("\(count)")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(highlighted ? Color.dsPrimary : Color.dsOnSurfaceVariant)
                            .opacity(0.8)

                        // Bar
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(
                                highlighted
                                    ? AnyShapeStyle(LinearGradient.dsActionGradient)
                                    : AnyShapeStyle(Color.dsSecondaryContainer)
                            )
                            .frame(height: barHeight(for: count, in: geo.size.height - 44))
                            .shadow(
                                color: highlighted ? Color.dsPrimary.opacity(0.2) : .clear,
                                radius: 8, x: 0, y: 4
                            )

                        // Day label
                        Text(day)
                            .font(.system(size: 10, weight: highlighted ? .bold : .medium))
                            .foregroundColor(highlighted ? Color.dsPrimary : Color.dsOnSurfaceVariant)
                    }
                    .frame(maxWidth: .infinity)
                    .animation(.spring(response: 0.5), value: selectedPeriod)
                }
            }
        }
        .frame(height: 200)
    }

    private func barHeight(for count: Int, in maxH: CGFloat) -> CGFloat {
        guard maxCount > 0 else { return 4 }
        return max(4, CGFloat(count) / CGFloat(maxCount) * maxH)
    }
}

// MARK: - Efficiency Pulse Card

private struct EfficiencyPulseCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Efficiency Pulse")
                .font(.dsHeadlineSm)
                .foregroundColor(Color.dsOnSurface)

            EfficiencyRow(
                icon:      "bolt.fill",
                iconBg:    Color.dsPrimaryFixed,
                iconColor: Color.dsPrimary,
                label:     "Deep Focus Ratio",
                percent:   0.78,
                gradient:  LinearGradient(
                    colors: [Color.dsPrimary, Color.dsPrimaryContainer],
                    startPoint: .leading, endPoint: .trailing
                )
            )

            EfficiencyRow(
                icon:      "clock.fill",
                iconBg:    Color.dsTertiaryFixed,
                iconColor: Color.dsTertiaryContainer,
                label:     "Time Estimation Accuracy",
                percent:   0.92,
                gradient:  LinearGradient(
                    colors: [Color.dsTertiary, Color.dsTertiaryContainer],
                    startPoint: .leading, endPoint: .trailing
                )
            )
        }
        .padding(22)
        .background(Color.dsSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .dsPrimaryShadow(radius: 10, y: 4)
    }
}

private struct EfficiencyRow: View {
    let icon: String
    let iconBg: Color
    let iconColor: Color
    let label: String
    let percent: Double
    let gradient: LinearGradient

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(iconColor)
                .frame(width: 44, height: 44)
                .background(iconBg)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(label)
                        .font(.dsTitleSm)
                        .foregroundColor(Color.dsOnSurface)
                    Spacer()
                    Text("\(Int(percent * 100))%")
                        .font(.dsBodySm.weight(.bold))
                        .foregroundColor(Color.dsOnSurface)
                }

                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.dsSurfaceVariant)
                            .frame(height: 6)

                        Capsule()
                            .fill(gradient)
                            .frame(width: geo.size.width * percent, height: 6)
                            .animation(.spring(response: 0.8), value: percent)
                    }
                }
                .frame(height: 6)
            }
        }
    }
}

// MARK: - Daily Insight Card

private struct DailyInsightCard: View {
    var body: some View {
        ZStack {
            LinearGradient.dsActionGradient

            // Decorative glow blob
            Circle()
                .fill(Color.dsPrimaryContainer.opacity(0.4))
                .frame(width: 180, height: 180)
                .blur(radius: 40)
                .offset(x: 80, y: 60)

            VStack(alignment: .leading, spacing: 16) {
                Text("Daily Insight")
                    .font(.dsHeadlineSm)
                    .foregroundColor(.white)

                Text("\"Your peak productivity window is **9:00 AM – 11:30 AM**. Scheduling high-impact tasks here has boosted completion rates by 24% this week.\"")
                    .font(.dsBodyMd)
                    .foregroundColor(Color.dsOnPrimaryContainer)
                    .lineSpacing(4)

                Button {
                    // Optimize schedule
                } label: {
                    Text("Optimize Schedule")
                        .font(.dsLabelMd.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(.white.opacity(0.15))
                        .overlay(
                            Capsule()
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        )
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(24)
        }
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}

// MARK: - Preview

struct ProductivityStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductivityStatsView()
    }
}
