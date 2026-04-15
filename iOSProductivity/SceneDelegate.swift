import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UI to the
        // provided UIWindowScene.
        // If using a storyboard, the UI is automatically created and attached
        // to the scene.
        // This property will be nil if the scene is being discarded later.

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its
        // session is otherwise discarded. If the scene was previously in the
        // background, optionally re-create the scene with the same state information
        // to launch it back into a foreground state.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from the background to the foreground.
        // Use this method to undo any changes made on entering the background.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene is about to move from the foreground to the background.
        // Use this method to pause ongoing tasks, disable timers, and throttle down
        // OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and invalidate
        // timers that were not needed when the app was running in the background.
        // If there's an upcoming scene transition, you can save the state of the
        // scene here.
    }
}
