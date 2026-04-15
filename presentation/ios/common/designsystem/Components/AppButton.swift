//
//  AppButton.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

struct AppButton: View {
    enum Style {
        case primary
        case secondary
        case tertiary
        case outline
        case plain
    }

    let title: String
    let style: Style
    let action: () -> Void

    @Environment(\.appTheme) var theme: AppTheme

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(theme.font(.interSemiBold, size: 16))
                .padding(.vertical, theme.spacing.medium.value)
                .padding(.horizontal, theme.spacing.large.value)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(theme.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: theme.cornerRadius)
                        .stroke(borderColor, lineWidth: 1)
                )
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary:
            return theme.primary
        case .secondary:
            return theme.secondary
        case .tertiary:
            return theme.tertiaryFixed
        case .outline:
            return .clear
        case .plain:
            return .clear
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:
            return theme.onPrimary
        case .secondary:
            return theme.onSecondaryFixed
        case .tertiary:
            return theme.tertiaryFixedDim // Assuming a darker text for tertiary fixed
        case .outline:
            return theme.primary
        case .plain:
            return theme.primary
        }
    }

    private var borderColor: Color {
        switch style {
        case .primary, .secondary, .tertiary:
            return .clear
        case .outline:
            return theme.primary
        case .plain:
            return .clear
        }
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppThemeProvider {
            VStack(spacing: 20) {
                AppButton(title: "Primary Button", style: .primary) { print("Primary tapped") }
                AppButton(title: "Secondary Button", style: .secondary) { print("Secondary tapped") }
                AppButton(title: "Tertiary Button", style: .tertiary) { print("Tertiary tapped") }
                AppButton(title: "Outline Button", style: .outline) { print("Outline tapped") }
                AppButton(title: "Plain Button", style: .plain) { print("Plain tapped") }
            }
            .padding()
        }
    }
}
