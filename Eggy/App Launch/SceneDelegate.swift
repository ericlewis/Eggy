import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate, EggStoreDelegate {
    var shortcutToProcess: UIApplicationShortcutItem?
    var window: UIWindow?
    var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    lazy var timer: TimerStore = TimerStore()
    lazy var egg: EggStore = EggStore()
    var store: Store!
    var shortcuts: HomeActionManager!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        store = Store(timer: timer, egg: egg)
        egg.delegate = self
        
        #if !targetEnvironment(macCatalyst)
        if let shortcutItem = connectionOptions.shortcutItem {
            shortcutToProcess = shortcutItem
        }
        #endif
        
        shortcuts = HomeActionManager(store: store)

        let contentView = RootView()
            .environmentObject(store)
            .environmentObject(timer)
            .environmentObject(egg)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func updated() {
        guard let size = egg.settings?.size, let doneness = egg.settings?.doneness, let temp = egg.settings?.temp else {
            return
        }
        
        if size != store.size {
            store.size = size
        }
        
        if doneness != store.doneness {
            store.doneness = doneness
        }
        
        if temp != store.temp {
            store.temp = temp
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        if let shortcutItem = shortcutToProcess {
            shortcuts.handleAction(shortcutItem)
            shortcutToProcess = nil
        }
        
        NotificationStore.shared.refresh()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        shortcuts.setActions()
        egg.saveContext()
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        shortcuts.handleAction(shortcutItem)
        completionHandler(false)
    }
}

