import UserNotifications

open class EGGLocalNotification : NSObject {
    
    // MARK: Private Props
    
    private(set) var userNotificationCenter: EGGUNUserNotificationCenterProtocol
    
    // MARK: Public Props
    
    public var title: String?
    public var message: String?
    
    // MARK: Initializers
    
    public init(title: String?, message: String?, userNotificationCenter: EGGUNUserNotificationCenterProtocol = EGGUNUserNotificationCenterClient()) {
        self.userNotificationCenter = userNotificationCenter
        self.title = title
        self.message = message
    }
    
    // MARK: Actions
    
    open func fire(triggerOffset: TimeInterval) {
        guard let title = title else {
            return
        }
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        
        if let message = message {
            notificationContent.body = message
        }
        
        notificationContent.sound = UNNotificationSound.default
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: triggerOffset,
                                                                    repeats: false)
        
        let notificationRequest = UNNotificationRequest(identifier: title,
                                                        content: notificationContent,
                                                        trigger: notificationTrigger)
        
        userNotificationCenter.add(notificationRequest, withCompletionHandler: nil)
    }
    
    open func delete() {
        guard let title = title else {
            return
        }
        
        userNotificationCenter.delete(id: title)
    }
}

public class EGGEggFinishedNotification : EGGLocalNotification {
    override public init(title: String? = "Your egg is done!", message: String? = nil, userNotificationCenter: EGGUNUserNotificationCenterProtocol = EGGUNUserNotificationCenterClient()) {
        super.init(title: title, message: message, userNotificationCenter: userNotificationCenter)
    }
}

public class EGGEggThirtySecondsRemainingNotification : EGGLocalNotification {
    override public init(title: String? = "Your egg will be done in 30 seconds!", message: String? = nil, userNotificationCenter: EGGUNUserNotificationCenterProtocol = EGGUNUserNotificationCenterClient()) {
        super.init(title: title, message: message, userNotificationCenter: userNotificationCenter)
    }
    
    override public func fire(triggerOffset: TimeInterval) {
        super.fire(triggerOffset: triggerOffset - 30)
    }
}
