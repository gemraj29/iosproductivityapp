//
//  AppTextField.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

struct AppTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    @Environment(\.appTheme) var theme: AppTheme

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .font(theme.font(.interRegular, size: 16))
        .padding(.vertical, theme.spacing.medium.value)
        .padding(.horizontal, theme.spacing.medium.value)
        .background(
            RoundedRectangle(cornerRadius: theme.cornerRadius)
                .fill(theme.appSurface) // Using appSurface for text field background
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.cornerRadius)
                .stroke(theme.outline, lineWidth: 1)
        )
        .foregroundColor(theme.primary) // Text color
    }
}

struct AppTextField_Previews: PreviewProvider {
    @State static var sampleText: String = ""
    @State static var secureText: String = ""

    static var previews: some View {
        AppThemeProvider {
            VStack(spacing: 20) {
                AppTextField(placeholder: "Enter text", text: $sampleText)
                AppTextField(placeholder: "Enter password", text: $secureText, isSecure: true)
            }
            .padding()
        }
    }
}
