import SwiftUI

// MARK: - Deep Sea Design System
// Color tokens from the "Deep Sea" Stitch design system.
// Exact hex values preserved from the HTML reference files.

extension Color {

    // MARK: Primary
    static let dsPrimary              = Color(hex: "00334d")
    static let dsPrimaryContainer     = Color(hex: "004b6e")
    static let dsPrimaryFixed         = Color(hex: "c9e6ff")
    static let dsPrimaryFixedDim      = Color(hex: "97cdf6")
    static let dsOnPrimary            = Color.white
    static let dsOnPrimaryFixed       = Color(hex: "001e2f")
    static let dsOnPrimaryFixedVariant = Color(hex: "014b6e")
    static let dsOnPrimaryContainer   = Color(hex: "85bae3")
    static let dsInversePrimary       = Color(hex: "97cdf6")

    // MARK: Secondary
    static let dsSecondary            = Color(hex: "53606b")
    static let dsSecondaryContainer   = Color(hex: "d4e1ee")
    static let dsSecondaryFixed       = Color(hex: "d7e4f1")
    static let dsSecondaryFixedDim    = Color(hex: "bbc8d5")
    static let dsOnSecondary          = Color.white
    static let dsOnSecondaryContainer = Color(hex: "57646f")
    static let dsOnSecondaryFixed     = Color(hex: "101d26")
    static let dsOnSecondaryFixedVariant = Color(hex: "3b4853")

    // MARK: Tertiary
    static let dsTertiary             = Color(hex: "601200")
    static let dsTertiaryContainer    = Color(hex: "852205")
    static let dsTertiaryFixed        = Color(hex: "ffdbd2")
    static let dsTertiaryFixedDim     = Color(hex: "ffb4a1")
    static let dsOnTertiary           = Color.white
    static let dsOnTertiaryContainer  = Color(hex: "ff9a7f")
    static let dsOnTertiaryFixed      = Color(hex: "3c0800")
    static let dsOnTertiaryFixedVariant = Color(hex: "862206")

    // MARK: Surface & Background
    static let dsBackground           = Color(hex: "f7f9fc")
    static let dsSurface              = Color(hex: "f7f9fc")
    static let dsSurfaceBright        = Color(hex: "f7f9fc")
    static let dsSurfaceDim           = Color(hex: "d8dadd")
    static let dsSurfaceVariant       = Color(hex: "e0e3e6")
    static let dsSurfaceTint          = Color(hex: "296388")
    static let dsInverseSurface       = Color(hex: "2d3133")
    static let dsInverseOnSurface     = Color(hex: "eff1f4")

    // MARK: Surface Containers (hierarchy)
    static let dsSurfaceContainerLowest  = Color(hex: "ffffff")
    static let dsSurfaceContainerLow     = Color(hex: "f2f4f7")
    static let dsSurfaceContainer        = Color(hex: "eceef1")
    static let dsSurfaceContainerHigh    = Color(hex: "e6e8eb")
    static let dsSurfaceContainerHighest = Color(hex: "e0e3e6")

    // MARK: On-Surface
    static let dsOnSurface        = Color(hex: "191c1e")
    static let dsOnSurfaceVariant = Color(hex: "41484e")
    static let dsOnBackground     = Color(hex: "191c1e")

    // MARK: Outline
    static let dsOutline        = Color(hex: "71787f")
    static let dsOutlineVariant = Color(hex: "c1c7cf")

    // MARK: Error
    static let dsError          = Color(hex: "ba1a1a")
    static let dsErrorContainer = Color(hex: "ffdad6")
    static let dsOnError        = Color.white
    static let dsOnErrorContainer = Color(hex: "93000a")

    // MARK: Legacy aliases kept for backward compatibility
    static let appPrimary         = Color(hex: "00334d")
    static let appSecondary       = Color(hex: "53606b")
    static let bg                 = Color(hex: "f7f9fc")
    static let surface            = Color(hex: "f7f9fc")
    static let onPrimary          = Color.white
    static let onSecondaryFixed   = Color(hex: "101d26")
    static let tertiaryFixed      = Color(hex: "ffdbd2")
    static let tertiaryFixedDim   = Color(hex: "ffb4a1")
    static let outline            = Color(hex: "71787f")
    static let primaryContainer   = Color(hex: "004b6e")
    static let errorContainer     = Color(hex: "ffdad6")
    static let secondaryFixedDim  = Color(hex: "bbc8d5")

    // MARK: - Hex initialiser
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red:     Double(r) / 255,
            green:   Double(g) / 255,
            blue:    Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Typography Scale
// Manrope → .rounded design (closest SF Pro match)
// Inter   → .default design

extension Font {
    // Display — Manrope-style geometric bold
    static let dsDisplayLg   = Font.system(size: 56, weight: .bold,     design: .rounded)
    static let dsDisplayMd   = Font.system(size: 45, weight: .bold,     design: .rounded)

    // Headline — Manrope-style semibold
    static let dsHeadlineLg  = Font.system(size: 32, weight: .semibold, design: .rounded)
    static let dsHeadlineMd  = Font.system(size: 28, weight: .semibold, design: .rounded)
    static let dsHeadlineSm  = Font.system(size: 24, weight: .semibold, design: .rounded)

    // Title — Inter semibold
    static let dsTitleLg     = Font.system(size: 22, weight: .semibold, design: .default)
    static let dsTitleMd     = Font.system(size: 16, weight: .semibold, design: .default)
    static let dsTitleSm     = Font.system(size: 14, weight: .semibold, design: .default)

    // Body — Inter regular / medium
    static let dsBodyLg      = Font.system(size: 16, weight: .regular,  design: .default)
    static let dsBodyMd      = Font.system(size: 14, weight: .regular,  design: .default)
    static let dsBodySm      = Font.system(size: 12, weight: .regular,  design: .default)

    // Label — Inter medium / semibold
    static let dsLabelLg     = Font.system(size: 14, weight: .medium,   design: .default)
    static let dsLabelMd     = Font.system(size: 12, weight: .medium,   design: .default)
    static let dsLabelSm     = Font.system(size: 11, weight: .medium,   design: .default)
}

// MARK: - Gradient Helpers

extension LinearGradient {
    /// The signature "Deep Sea" action gradient: #00334d → #004b6e at 135°
    static let dsActionGradient = LinearGradient(
        colors: [Color.dsPrimary, Color.dsPrimaryContainer],
        startPoint: UnitPoint(x: 0.15, y: 0.15),
        endPoint:   UnitPoint(x: 0.85, y: 0.85)
    )
}

// MARK: - Shadow Helpers

extension View {
    /// Ambient primary-tinted shadow per the Deep Sea elevation spec.
    func dsPrimaryShadow(radius: CGFloat = 15, y: CGFloat = 10) -> some View {
        self.shadow(color: Color.dsPrimary.opacity(0.08), radius: radius, x: 0, y: y)
    }
}

// MARK: - Shared App Bar

struct DSAppBar: View {
    var body: some View {
        HStack(spacing: 12) {
            // Avatar placeholder
            Circle()
                .fill(Color.dsSecondaryContainer)
                .frame(width: 40, height: 40)
                .overlay(
                    Text("A")
                        .font(.dsLabelLg)
                        .foregroundColor(Color.dsOnSecondaryContainer)
                )

            Text("Deep Sea Productivity")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(Color.dsPrimaryContainer)

            Spacer()

            Button {
                // Search
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color.dsOnSurfaceVariant)
                    .frame(width: 40, height: 40)
                    .background(Color.dsSurfaceContainerHighest.opacity(0.5))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(Color.dsBackground)
    }
}
