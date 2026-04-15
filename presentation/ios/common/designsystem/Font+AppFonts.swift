//
//  Font+AppFonts.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

enum AppFont {
    case interRegular
    case interMedium
    case interSemiBold
    case interBold

    var name: String {
        switch self {
        case .interRegular:
            return "Inter-Regular"
        case .interMedium:
            return "Inter-Medium"
        case .interSemiBold:
            return "Inter-SemiBold"
        case .interBold:
            return "Inter-Bold"
        }
    }

    func size(_ size: CGFloat) -> Font {
        return .custom(name, size: size)
    }
}
