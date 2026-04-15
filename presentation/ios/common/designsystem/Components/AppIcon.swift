//
//  AppIcon.swift
//  iOSProductivity
//
//  Created by [Your Name] on [Date].
//

import SwiftUI

enum AppIcon {
    case home
    case tasks
    case calendar
    case settings
    case add
    case edit
    case delete
    case checkmark
    case close
    case star
    case user

    var systemName: String {
        switch self {
        case .home: return "house.fill"
        case .tasks: return "checklist"
        case .calendar: return "calendar"
        case .settings: return "gearshape.fill"
        case .add: return "plus.circle.fill"
        case .edit: return "pencil.circle.fill"
        case .delete: return "trash.circle.fill"
        case .checkmark: return "checkmark.circle.fill"
        case .close: return "xmark.circle.fill"
        case .star: return "star.fill"
        case .user: return "person.fill"
        }
    }

    func image(size: CGFloat = 24, color: Color = .primary) -> Image {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(color)
    }
}

struct AppIcon_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            AppIcon.home.image()
            AppIcon.tasks.image(size: 32, color: .secondary)
            AppIcon.add.image(size: 48, color: .tertiaryFixed)
            AppIcon.checkmark.image(color: .green) // Example of using a non-theme color
        }
    }
}
