//
//  SceneDelegate.swift
//  Eggy
//
//  Created by Eric Lewis on 7/5/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import UIKit
import SwiftUI
import EggyKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    if let windowScene = scene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView:
          RootView().linkStores()
      )
        self.window = window
        window.makeKeyAndVisible()
    }
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    UIApplication.shared.applicationIconBadgeNumber = 0
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    UserDefaults.standard.synchronize()
  }

  func windowScene(_ windowScene: UIWindowScene,
                   performActionFor shortcutItem: UIApplicationShortcutItem,
                   completionHandler: @escaping (Bool) -> Void) {
    let manager = EGGTimerManager.shared
    manager.start()
    completionHandler(true)
  }

}
