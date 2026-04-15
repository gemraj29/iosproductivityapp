//
//  Spacing+AppSpacing.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

enum AppSpacing {
    case extraSmall
    case small
    case medium
    case large
    case extraLarge

    var value: CGFloat {
        switch self {
        case .extraSmall:
            return 4 // 1x
        case .small:
            return 8 // 2x
        case .medium:
            return 16 // 4x
        case .large:
            return 24 // 6x
        case .extraLarge:
            return 32 // 8x
        }
    }

    // Helper to create a Spacer with this value
    func spacer() -> some View {
        Spacer().frame(height: value)
    }

    // Helper to create a Divider with this value
    func divider() -> some View {
        Divider().frame(height: value)
    }
}
