import SwiftUI
import UserNotifications

class NotificationStore: ObservableObject {
    static let shared = NotificationStore()
    
    @Published var enabled = false
    @Published var warning = true

    var center: UNUserNotificationCenter = .current()

    init() {
        center.getNotificationSettings {
            self.enabled = $0.authorizationStatus == .authorized
        }
    }
    
    func scheduleNotifications(endDate: Date) {
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            let timeRemaining = endDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
            if timeRemaining > 0, granted {
                self.scheduleNormie(timeRemaining)
                
                if self.warning {
                    self.scheduleWarning(timeRemaining)
                }
            }
        }
    }
    
    private func scheduleNormie(_ triggerTime: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Your egg is finished!"
        content.body = "Mmmmm, eggs."
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: triggerTime, repeats: false)
        let request = UNNotificationRequest(identifier: "egg", content: content, trigger: trigger)
        self.center.add(request, withCompletionHandler: nil)
    }
    private func scheduleWarning(_ triggerTime: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Your egg is almost done."
        content.body = "30 more seconds until delicious beautiful eggs."
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: triggerTime - 30, repeats: false)
        let request = UNNotificationRequest(identifier: "warning", content: content, trigger: trigger)
        self.center.add(request, withCompletionHandler: nil)
    }
    
    func cancelNotifications() {
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
}
