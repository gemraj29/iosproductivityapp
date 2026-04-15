//
//  AppThemeProvider.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

struct AppThemeProvider<Content: View>: View {
    let theme: AppTheme
    let content: Content

    init(theme: AppTheme = .default, @ViewBuilder content: () -> Content) {
        self.theme = theme
        self.content = content()
    }

    var body: some View {
        content
            .environment(\.appTheme, theme)
    }
}
