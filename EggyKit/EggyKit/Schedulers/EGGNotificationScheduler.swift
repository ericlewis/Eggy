//
//  EGGLocalNotificationManager.swift
//  EggyKit
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

public protocol EGGNotificationSchedulerProtocol {
    var doneNotice: EGGLocalNotification {get set}
    var warningNotice: EGGLocalNotification? {get set}
    
    init(settingsManager: EGGSettingsProtocol, doneNotice: EGGLocalNotification, warningNotice: EGGLocalNotification?)
    
    func schedule(cookTime: TimeInterval)
    func clear()
}

public struct EGGNotificationScheduler : EGGNotificationSchedulerProtocol {
    public var settingsManager: EGGSettingsProtocol
    public var doneNotice: EGGLocalNotification
    public var warningNotice: EGGLocalNotification?
    
    public init(settingsManager: EGGSettingsProtocol = EGGSettings(), doneNotice: EGGLocalNotification = EGGEggFinishedNotification(), warningNotice: EGGLocalNotification? = EGGEggThirtySecondsRemainingNotification()) {
        self.settingsManager = settingsManager
        self.doneNotice = doneNotice
        self.warningNotice = warningNotice
    }
    
    public func schedule(cookTime: TimeInterval) {
        if cookTime < 1.0 {
            return
        }
        
        self.doneNotice.fire(triggerOffset: cookTime)
        
        if settingsManager.warningNotificationEnabled {
            self.warningNotice?.fire(triggerOffset: cookTime)
        }
    }
    
    public func clear() {
        self.doneNotice.delete()
        self.warningNotice?.delete()
    }
}
