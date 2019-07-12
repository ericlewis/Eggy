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
    func delete(identifier: String)
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

    public func delete(identifier: String) {
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }

    public init(userNotificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.userNotificationCenter = userNotificationCenter
    }
}
