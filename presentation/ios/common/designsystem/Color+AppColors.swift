//
//  Color+AppColors.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

extension Color {
    // MARK: - Primary Palette
    static let primary = Color(hex: "00334d") // Primary
    static let onPrimary = Color(hex: "ffffff") // On Primary
    static let primaryContainer = Color(hex: "004b6e") // Primary Container
    static let onPrimaryFixed = Color(hex: "ffffff") // On Primary Fixed
    static let onPrimaryFixedVariant = Color(hex: "014b6d") // On Primary Fixed Variant

    // MARK: - Secondary Palette
    static let secondary = Color(hex: "53606b") // Secondary
    static let onSecondaryFixed = Color(hex: "101d26") // On Secondary Fixed
    static let secondaryFixedDim = Color(hex: "bbc8d5") // Secondary Fixed Dim

    // MARK: - Tertiary Palette
    static let tertiaryFixed = Color(hex: "ffdbd2") // Tertiary Fixed
    static let tertiaryFixedDim = Color(hex: "ffb4a1") // Tertiary Fixed Dim

    // MARK: - Error Palette
    static let errorContainer = Color(hex: "ffdad6") // Error Container
    static let onError = Color(hex: "ffffff") // On Error

    // MARK: - Neutral Palette
    static let background = Color(hex: "f7f7f7") // Background (using a slightly off-white for better contrast)
    static let surface = Color(hex: "f7f7f7") // Surface (matching background for simplicity as per design)
    static let outline = Color(hex: "71787f") // Outline

    // MARK: - Custom Colors
    static let appBackground = Color("f7f9fc") // App Background from design tokens
    static let appSurface = Color("f7f9fc") // App Surface from design tokens
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted())
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            a = 255
            r = (int >> 8) * 17
            g = ((int >> 4) & 0xF) * 17
            b = (int & 0xF) * 17
        case 6: // RGB (24-bit)
            a = 255
            r = int >> 16
            g = (int >> 8) & 0xFF
            b = int & 0xFF
        case 8: // ARGB (32-bit)
            a = (int >> 24) & 0xFF
            r = (int >> 16) & 0xFF
            g = (int >> 8) & 0xFF
            b = int & 0xFF
        default:
            fatalError("Invalid hex string")
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
