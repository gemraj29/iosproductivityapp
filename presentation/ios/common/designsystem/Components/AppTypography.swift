//
//  AppTypography.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

struct AppTypography {
    // MARK: - Headings
    static func heading1(_ text: String, theme: AppTheme) -> some View {
        Text(text)
            .font(theme.font(.interBold, size: 32))
            .foregroundColor(theme.primary)
    }

    static func heading2(_ text: String, theme: AppTheme) -> some View {
        Text(text)
            .font(theme.font(.interSemiBold, size: 24))
            .foregroundColor(theme.primary)
    }

    static func heading3(_ text: String, theme: AppTheme) -> some View {
        Text(text)
            .font(theme.font(.interSemiBold, size: 20))
            .foregroundColor(theme.primary)
    }

    // MARK: - Body Text
    static func bodyLarge(_ text: String, theme: AppTheme) -> some View {
        Text(text)
            .font(theme.font(.interRegular, size: 16))
            .foregroundColor(theme.primary)
    }

    static func bodyMedium(_ text: String, theme: AppTheme) -> some View {
        Text(text)
            .font(theme.font(.interRegular, size: 14))
            .foregroundColor(theme.primary)
    }

    static func bodySmall(_ text: String, theme: AppTheme) -> some View {
        Text(text)
            .font(theme.font(.interRegular, size: 12))
            .foregroundColor(theme.primary)
    }

    // MARK: - Labels
    static func labelLarge(_ text: String, theme: AppTheme) -> some View {
        Text(text)
            .font(theme.font(.interMedium, size: 16))
            .foregroundColor(theme.primary)
    }

    static func labelMedium(_ text: String, theme: AppTheme) -> some View {
        Text(text)
            .font(theme.font(.interMedium, size: 14))
            .foregroundColor(theme.primary)
    }

    static func labelSmall(_ text: String, theme: AppTheme) -> some View {
        Text(text)
            .font(theme.font(.interMedium, size: 12))
            .foregroundColor(theme.primary)
    }
}

struct AppTypography_Previews: PreviewProvider {
    static var previews: some View {
        AppThemeProvider { theme in
            VStack(alignment: .leading, spacing: 16) {
                AppTypography.heading1("Heading 1", theme: theme)
                AppTypography.heading2("Heading 2", theme: theme)
                AppTypography.heading3("Heading 3", theme: theme)
                AppTypography.bodyLarge("Body Large Text", theme: theme)
                AppTypography.bodyMedium("Body Medium Text", theme: theme)
                AppTypography.bodySmall("Body Small Text", theme: theme)
                AppTypography.labelLarge("Label Large", theme: theme)
                AppTypography.labelMedium("Label Medium", theme: theme)
                AppTypography.labelSmall("Label Small", theme: theme)
            }
            .padding()
        }
    }
}
