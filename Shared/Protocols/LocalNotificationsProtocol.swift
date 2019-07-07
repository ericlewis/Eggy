//
//  NotificationsProtocol.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import UserNotifications

protocol LocalNotificationsProtocol : EggProtocol {
    func createNotifications()
    func deleteNotifications()
    
    func createWarningNotification()
    func createDoneNotification()
}

extension LocalNotificationsProtocol {
    func createNotifications() {
        // TODO: offset the permission time
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
            self.createDoneNotification()
            
            if self.rawCookTime > 60 {
                self.createWarningNotification()
            }
        }
    }
    
    func createWarningNotification() {
        let content = UNMutableNotificationContent()
        // TODO: localize me
        content.title = "Your egg will be ready in 30 seconds!"
        content.body = ""
        content.sound = .default
        content.badge = 1
        content.userInfo = ["identifier": "timer2"]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.rawCookTime - 30, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timer2", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("Unable to Create Notice")
                print("\(error), \(error.localizedDescription)")
            }
        })
    }
    
    func createDoneNotification() {
        let content = UNMutableNotificationContent()
        // TODO: localize me
        content.title = "Your egg is done!"
        content.body = ""
        content.sound = .default
        content.badge = 1
        content.userInfo = ["identifier": "timer"]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.rawCookTime, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("Unable to Create Notice")
                print("\(error), \(error.localizedDescription)")
            }
        })
    }
    
    func deleteNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer", "timer2"])
    }
}
