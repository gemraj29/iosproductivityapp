import SwiftUI

// MARK: - Focus Mode View

struct FocusModeView: View {
    // Timer state
    @State private var selectedDuration: FocusDuration = .lagoon
    @State private var timeRemaining: Int = 25 * 60
    @State private var isRunning: Bool = false
    @State private var selectedAmbience: AmbienceTrack = .gentleCurrents

    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 0) {
            DSAppBar()

            ScrollView {
                VStack(spacing: 20) {
                    timerSection
                    sessionDepthSection
                    oceanAmbienceSection
                    bottomInfoRow
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 120)
            }
        }
        .background(Color.dsBackground.ignoresSafeArea())
        .onReceive(ticker) { _ in
            guard isRunning else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isRunning = false
            }
        }
    }

    // MARK: - Timer Section

    private var timerSection: some View {
        ZStack {
            // Wave decoration background
            Color.dsSurfaceContainerLow

            VStack(spacing: 32) {
                CircularTimerView(
                    progress: timerProgress,
                    timeRemaining: timeRemaining
                )

                controlButtons
            }
            .padding(.vertical, 40)
        }
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
    }

    private var timerProgress: Double {
        let total = Double(selectedDuration.seconds)
        return total > 0 ? Double(timeRemaining) / total : 0
    }

    private var controlButtons: some View {
        HStack(spacing: 16) {
            // Primary — Deep Dive
            Button {
                withAnimation(.spring(response: 0.3)) {
                    if !isRunning { timeRemaining = selectedDuration.seconds }
                    isRunning.toggle()
                }
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 18))
                    Text(isRunning ? "Pause" : "Deep Dive")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 28)
                .padding(.vertical, 18)
                .background(LinearGradient.dsActionGradient)
                .clipShape(Capsule())
                .shadow(color: Color.dsPrimary.opacity(0.2), radius: 12, x: 0, y: 6)
            }
            .buttonStyle(.plain)

            // Secondary — Resurface (reset)
            Button {
                withAnimation(.spring(response: 0.3)) {
                    isRunning = false
                    timeRemaining = selectedDuration.seconds
                }
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 16))
                    Text("Resurface")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                }
                .foregroundColor(Color.dsOnSurfaceVariant)
                .padding(.horizontal, 22)
                .padding(.vertical, 18)
                .background(Color.dsSurfaceContainerHighest)
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: - Session Depth Section

    private var sessionDepthSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Session Depth")
                    .font(.dsHeadlineSm)
                    .foregroundColor(Color.dsOnSurface)
                Spacer()
                Text("MINUTES")
                    .font(.dsLabelSm.weight(.semibold))
                    .foregroundColor(Color.dsPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(Color.dsPrimaryFixed)
                    .clipShape(Capsule())
            }

            HStack(spacing: 12) {
                ForEach(FocusDuration.allCases) { duration in
                    DurationButton(
                        duration: duration,
                        isSelected: selectedDuration == duration
                    ) {
                        withAnimation(.spring(response: 0.3)) {
                            selectedDuration = duration
                            if !isRunning { timeRemaining = duration.seconds }
                        }
                    }
                }
            }
        }
        .padding(24)
        .background(Color.dsSurfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    // MARK: - Ocean Ambience Section

    private var oceanAmbienceSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ocean Ambience")
                .font(.dsHeadlineSm)
                .foregroundColor(Color.dsOnSurface)

            VStack(spacing: 10) {
                ForEach(AmbienceTrack.allCases) { track in
                    AmbienceRow(
                        track: track,
                        isSelected: selectedAmbience == track
                    ) {
                        withAnimation { selectedAmbience = track }
                    }
                }
            }
        }
        .padding(24)
        .background(Color.dsSurfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    // MARK: - Bottom Info Row

    private var bottomInfoRow: some View {
        HStack(spacing: 12) {
            InfoCard(
                icon:       "trophy.fill",
                iconColor:  Color.dsTertiary,
                iconBg:     Color.dsTertiaryFixed,
                title:      "Current Streak",
                subtitle:   "4 days of deep focus"
            )
            InfoCard(
                icon:       "lightbulb.fill",
                iconColor:  Color.dsOnPrimaryFixedVariant,
                iconBg:     Color.dsPrimaryFixed,
                title:      "Pro Tip",
                subtitle:   "Mute notifications before diving."
            )
        }
    }
}

// MARK: - Circular Timer View

private struct CircularTimerView: View {
    let progress: Double
    let timeRemaining: Int

    private var minutes: Int { timeRemaining / 60 }
    private var seconds: Int { timeRemaining % 60 }

    var body: some View {
        ZStack {
            // Track ring
            Circle()
                .stroke(Color.dsSurfaceContainerHighest, lineWidth: 10)

            // Progress arc
            Circle()
                .trim(from: 0, to: max(0.001, progress))
                .stroke(
                    LinearGradient.dsActionGradient,
                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: progress)

            // Center content
            VStack(spacing: 6) {
                Text(String(format: "%02d:%02d", minutes, seconds))
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .foregroundColor(Color.dsPrimary)
                    .monospacedDigit()

                Text("DEEP FOCUS")
                    .font(.system(size: 12, weight: .semibold, design: .default))
                    .foregroundColor(Color.dsOnSurfaceVariant)
                    .tracking(3)
            }
        }
        .frame(width: 260, height: 260)
        .padding(20)
    }
}

// MARK: - Duration Button

private struct DurationButton: View {
    let duration: FocusDuration
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text("\(duration.minutes)")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(isSelected ? .white : Color.dsPrimary)

                Text(duration.label)
                    .font(.dsLabelSm)
                    .foregroundColor(isSelected ? .white.opacity(0.8) : Color.dsOnSurfaceVariant)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                isSelected
                    ? AnyView(LinearGradient.dsActionGradient)
                    : AnyView(Color.dsSurfaceContainerLowest)
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(
                color: isSelected ? Color.dsPrimary.opacity(0.2) : .clear,
                radius: 8, x: 0, y: 4
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Ambience Row

private struct AmbienceRow: View {
    let track: AmbienceTrack
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                // Icon bubble
                Image(systemName: track.icon)
                    .font(.system(size: 18))
                    .foregroundColor(isSelected ? Color.dsOnSecondaryContainer : Color.dsOnSurfaceVariant)
                    .frame(width: 46, height: 46)
                    .background(isSelected ? Color.dsSecondaryContainer : Color.dsSurfaceContainerHighest)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                VStack(alignment: .leading, spacing: 2) {
                    Text(track.title)
                        .font(.dsTitleSm)
                        .foregroundColor(Color.dsOnSurface)
                    Text(track.subtitle)
                        .font(.dsLabelSm)
                        .foregroundColor(Color.dsOnSurfaceVariant)
                }

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "play.circle")
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? Color.dsPrimary : Color.dsOutlineVariant)
            }
            .padding(14)
            .background(isSelected ? Color.dsSurfaceContainerLowest : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.25), value: isSelected)
    }
}

// MARK: - Info Card

private struct InfoCard: View {
    let icon: String
    let iconColor: Color
    let iconBg: Color
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(iconColor)
                .frame(width: 48, height: 48)
                .background(iconBg)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.dsTitleSm)
                    .foregroundColor(Color.dsOnSurface)
                Text(subtitle)
                    .font(.dsLabelSm)
                    .foregroundColor(Color.dsOnSurfaceVariant)
                    .lineLimit(2)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.dsSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .dsPrimaryShadow(radius: 8, y: 3)
    }
}

// MARK: - Supporting Enums

enum FocusDuration: Int, CaseIterable, Identifiable {
    case reef     = 15
    case lagoon   = 25
    case abyss    = 45
    case trenches = 60

    var id: Int { rawValue }
    var minutes: Int { rawValue }
    var seconds: Int { rawValue * 60 }
    var label: String {
        switch self {
        case .reef:     return "Reef"
        case .lagoon:   return "Lagoon"
        case .abyss:    return "Abyss"
        case .trenches: return "Trenches"
        }
    }
}

enum AmbienceTrack: String, CaseIterable, Identifiable {
    case gentleCurrents = "Gentle Currents"
    case whaleSongs     = "Whale Songs"
    case currentBreak   = "Current Break"
    case proTip         = "Pro Tip"

    var id: String { rawValue }
    var title: String { rawValue }
    var subtitle: String {
        switch self {
        case .gentleCurrents: return "Soft rhythmic flows"
        case .whaleSongs:     return "Distant haunting melodies"
        case .currentBreak:   return "Mid-tide ambient texture"
        case .proTip:         return "Binaural focus beats"
        }
    }
    var icon: String {
        switch self {
        case .gentleCurrents: return "drop.fill"
        case .whaleSongs:     return "waveform"
        case .currentBreak:   return "wind"
        case .proTip:         return "music.note"
        }
    }
}

// MARK: - Preview

struct FocusModeView_Previews: PreviewProvider {
    static var previews: some View {
        FocusModeView()
    }
}
