//
//  AppTheme.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

struct AppTheme {
    // MARK: - Colors
    let primary: Color
    let onPrimary: Color
    let primaryContainer: Color
    let onPrimaryFixed: Color
    let onPrimaryFixedVariant: Color

    let secondary: Color
    let onSecondaryFixed: Color
    let secondaryFixedDim: Color

    let tertiaryFixed: Color
    let tertiaryFixedDim: Color

    let errorContainer: Color
    let onError: Color

    let background: Color
    let surface: Color
    let outline: Color

    let appBackground: Color
    let appSurface: Color

    // MARK: - Typography
    func font(_ style: AppFont, size: CGFloat) -> Font {
        style.size(size)
    }

    // MARK: - Spacing
    var spacing: AppSpacing { AppSpacing.self }

    // MARK: - Corner Radius
    let cornerRadius: CGFloat = 4 // 0.25rem equivalent

    // MARK: - Default Theme
    static let `default` = AppTheme(
        primary: .primary,
        onPrimary: .onPrimary,
        primaryContainer: .primaryContainer,
        onPrimaryFixed: .onPrimaryFixed,
        onPrimaryFixedVariant: .onPrimaryFixedVariant,
        secondary: .secondary,
        onSecondaryFixed: .onSecondaryFixed,
        secondaryFixedDim: .secondaryFixedDim,
        tertiaryFixed: .tertiaryFixed,
        tertiaryFixedDim: .tertiaryFixedDim,
        errorContainer: .errorContainer,
        onError: .onError,
        background: .background,
        surface: .surface,
        outline: .outline,
        appBackground: .appBackground,
        appSurface: .appSurface
    )
}

// MARK: - Environment Key
struct AppThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = .default
    static func reduce(value: inout AppTheme, next: () -> AppTheme) {
        // In a real app, you might merge or prioritize themes here.
        // For this scaffold, we'll just use the default.
    }
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}
