//
//  SceneDelegate.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/12/23.
//


import UIKit
import SwiftUI
import Firebase
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).


        // Create the SwiftUI view that provides the window contents.
        let contentView = MotherView()
            .environmentObject(CurrentUserViewModel())
            .environmentObject(MatchViewModel())
            .environmentObject(Notifications())

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = MyHostingController(rootView: AnyView(contentView))
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        if(uid != nil) {
            db.collection("users").document(uid!).setData(["isOnline": false], merge: true)
            print("User disconnected")
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        if(uid != nil) {
            db.collection("users").document(uid!).setData(["isOnline": true], merge: true)
            print("User is active")
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        if(uid != nil) {
            db.collection("users").document(uid!).setData(["isOnline": false], merge: true)
            print("App entered background")
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        URLContexts.forEach { context in

        }
    }

    class HostingViewController: UIHostingController<AnyView> {

        @objc override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    }
}

class LocalStatusBarStyle { // style proxy to be stored in Environment
    fileprivate var getter: () -> UIStatusBarStyle = { .default }
    fileprivate var setter: (UIStatusBarStyle) -> Void = {_ in}

    var currentStyle: UIStatusBarStyle {
        get { self.getter() }
        set { self.setter(newValue) }
    }
}

// Custom Environment key, as it is set once, it can be accessed from anywhere
// of SwiftUI view hierarchy
struct LocalStatusBarStyleKey: EnvironmentKey {
    static let defaultValue: LocalStatusBarStyle = LocalStatusBarStyle()
}


// Custom hosting controller that update status bar style
class MyHostingController<Content>: UIHostingController<Content> where Content: View {
    private var internalStyle = UIStatusBarStyle.default

    @objc override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            internalStyle
        }
        set {
            internalStyle = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    override init(rootView: Content) {
        super.init(rootView:rootView)

        LocalStatusBarStyleKey.defaultValue.getter = { self.preferredStatusBarStyle }
        LocalStatusBarStyleKey.defaultValue.setter = { self.preferredStatusBarStyle = $0 }
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

