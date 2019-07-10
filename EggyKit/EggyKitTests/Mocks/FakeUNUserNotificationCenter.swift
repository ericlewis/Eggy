//
//  EGGLocalNotificationMock.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import UserNotifications
import EggyKit

class FakeUNUserNotificationCenter: EGGUNUserNotificationCenterProtocol {
    
    // MARK: Captured properties
    
    var capturedAddRequest: UNNotificationRequest?
    var capturedAddCompletionHandler: ((Error?) -> Void)?

    var capturedDeleteId: String?

    
    // MARK: EGGUNUserNotificationCenterProtocol
    
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)?) {
        capturedAddRequest = request
        capturedAddCompletionHandler = completionHandler
    }
    
    func delete(id: String) {
        capturedDeleteId = id
    }
}
