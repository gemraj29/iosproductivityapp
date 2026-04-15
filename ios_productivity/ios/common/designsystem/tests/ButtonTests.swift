import XCTest
import SwiftUI
@testable import IosProductivity

final class ButtonTests: XCTestCase {

    func testPrimaryButtonAppearance() {
        let button = PrimaryButton(title: "Test Button") {}
        let hostingController = UIHostingController(rootView: button)

        // Check background color
        XCTAssertEqual(hostingController.view.backgroundColor, UIColor(Color.primary), "Primary button background color should be primary.")

        // Check text color
        let label = hostingController.view.subviews.first as? UILabel
        XCTAssertEqual(label?.textColor, UIColor(Color.onPrimary), "Primary button text color should be onPrimary.")

        // Check corner radius
        XCTAssertEqual(hostingController.view.layer.cornerRadius, 4, "Primary button corner radius should be 4.")
    }

    func testSecondaryButtonAppearance() {
        let button = SecondaryButton(title: "Test Button") {}
        let hostingController = UIHostingController(rootView: button)

        // Check background color
        XCTAssertEqual(hostingController.view.backgroundColor, UIColor(Color.secondary), "Secondary button background color should be secondary.")

        // Check text color
        let label = hostingController.view.subviews.first as? UILabel
        XCTAssertEqual(label?.textColor, UIColor(Color.onPrimary), "Secondary button text color should be onPrimary.")

        // Check corner radius
        XCTAssertEqual(hostingController.view.layer.cornerRadius, 4, "Secondary button corner radius should be 4.")
    }

    func testTertiaryButtonAppearance() {
        let button = TertiaryButton(title: "Test Button") {}
        let hostingController = UIHostingController(rootView: button)

        // Check background color
        XCTAssertEqual(hostingController.view.backgroundColor, UIColor(Color.tertiaryFixed), "Tertiary button background color should be tertiaryFixed.")

        // Check text color
        let label = hostingController.view.subviews.first as? UILabel
        XCTAssertEqual(label?.textColor, UIColor(Color.onPrimary), "Tertiary button text color should be onPrimary.")

        // Check corner radius
        XCTAssertEqual(hostingController.view.layer.cornerRadius, 4, "Tertiary button corner radius should be 4.")
    }

    func testOutlineButtonAppearance() {
        let button = OutlineButton(title: "Test Button") {}
        let hostingController = UIHostingController(rootView: button)

        // Check border color
        XCTAssertEqual(hostingController.view.layer.borderColor, UIColor(Color.outline).cgColor, "Outline button border color should be outline.")

        // Check border width
        XCTAssertEqual(hostingController.view.layer.borderWidth, 1, "Outline button border width should be 1.")

        // Check text color
        let label = hostingController.view.subviews.first as? UILabel
        XCTAssertEqual(label?.textColor, UIColor(Color.onPrimary), "Outline button text color should be onPrimary.")

        // Check corner radius
        XCTAssertEqual(hostingController.view.layer.cornerRadius, 4, "Outline button corner radius should be 4.")
    }

    func testPrimaryButtonAction() {
        var buttonTapped = false
        let button = PrimaryButton(title: "Test Button") {
            buttonTapped = true
        }
        let hostingController = UIHostingController(rootView: button)

        // Simulate a tap
        hostingController.view.simulateTap()

        // Check if the action was performed
        XCTAssertTrue(buttonTapped, "Primary button action should be executed.")
    }

    func testSecondaryButtonAction() {
        var buttonTapped = false
        let button = SecondaryButton(title: "Test Button") {
            buttonTapped = true
        }
        let hostingController = UIHostingController(rootView: button)

        // Simulate a tap
        hostingController.view.simulateTap()

        // Check if the action was performed
        XCTAssertTrue(buttonTapped, "Secondary button action should be executed.")
    }

    func testTertiaryButtonAction() {
        var buttonTapped = false
        let button = TertiaryButton(title: "Test Button") {
            buttonTapped = true
        }
        let hostingController = UIHostingController(rootView: button)

        // Simulate a tap
        hostingController.view.simulateTap()

        // Check if the action was performed
        XCTAssertTrue(buttonTapped, "Tertiary button action should be executed.")
    }

    func testOutlineButtonAction() {
        var buttonTapped = false
        let button = OutlineButton(title: "Test Button") {
            buttonTapped = true
        }
        let hostingController = UIHostingController(rootView: button)

        // Simulate a tap
        hostingController.view.simulateTap()

        // Check if the action was performed
        XCTAssertTrue(buttonTapped, "Outline button action should be executed.")
    }
}

extension UIView {
    func simulateTap() {
        sendActions(for: .touchUpInside)
    }
}
