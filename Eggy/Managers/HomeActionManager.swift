import UIKit

class HomeActionManager {
    var store: Store
    
    init(store: Store) {
        self.store = store
    }
    
    var start: UIApplicationShortcutItem {
        UIApplicationShortcutItem(type: "start",
        localizedTitle: "Start Timer",
        localizedSubtitle: store.donenessDetail,
        icon: UIApplicationShortcutIcon(systemImageName: "play.fill"), userInfo: nil)
    }
    
    var stop: UIApplicationShortcutItem {
           UIApplicationShortcutItem(type: "stop",
           localizedTitle: "Stop Timer",
           localizedSubtitle: nil,
           icon: UIApplicationShortcutIcon(systemImageName: "stop.fill"), userInfo: nil)
       }
    
    func setActions() {
        UIApplication.shared.shortcutItems = [
            start,
            stop
        ]
    }
    
    func handleAction(_ action: UIApplicationShortcutItem) {
        switch action.type {
        case "start":
            store.startTimer()
        case "stop":
            store.requestStopTimer()
        default:
            break
        }
    }
}
