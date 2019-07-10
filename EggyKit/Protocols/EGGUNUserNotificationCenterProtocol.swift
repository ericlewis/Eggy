//
//  EGGUNUserNotificationCenterProtocol.swift
//  Eggy
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import UserNotifications

public protocol EGGUNUserNotificationCenterProtocol {
    func add(_ request: UNNotificationRequest,
             withCompletionHandler completionHandler: ((Error?) -> Void)?)
    func delete(id: String)
}

public struct EGGUNUserNotificationCenterClient: EGGUNUserNotificationCenterProtocol {
    
    // MARK: - Public properties
    
    public var userNotificationCenter: UNUserNotificationCenter
    
    // MARK: - Public methods
    
    public func add(_ request: UNNotificationRequest,
                    withCompletionHandler completionHandler: ((Error?) -> Void)?) {
        userNotificationCenter.add(request,
                                   withCompletionHandler: completionHandler)
    }
    
    public func delete(id: String) {
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    public init(userNotificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.userNotificationCenter = userNotificationCenter
    }
}
