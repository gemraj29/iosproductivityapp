//
//  AppCard.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

struct AppCard<Content: View>: View {
    let content: Content

    @Environment(\.appTheme) var theme: AppTheme

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(theme.spacing.medium.value)
            .background(theme.appSurface) // Using appSurface for card background
            .cornerRadius(theme.cornerRadius)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2) // Subtle shadow
    }
}

struct AppCard_Previews: PreviewProvider {
    static var previews: some View {
        AppThemeProvider {
            VStack {
                AppCard {
                    VStack(alignment: .leading) {
                        Text("Card Title")
                            .font(theme.font(.interSemiBold, size: 18))
                            .foregroundColor(theme.primary)
                        Text("This is some content inside the card.")
                            .font(theme.font(.interRegular, size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
        }
    }
}
