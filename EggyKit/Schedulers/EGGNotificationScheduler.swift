//
//  EGGLocalNotificationManager.swift
//  EggyKit
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

public protocol EGGNotificationSchedulerProtocol {
    var doneNotice: EGGEggFinishedNotification {get set}
    var warningNotice: EGGEggThirtySecondsRemainingNotification? {get set}
    
    init(settingsManager: EGGSettingsProtocol, doneNotice: EGGEggFinishedNotification, warningNotice: EGGEggThirtySecondsRemainingNotification?)
    
    func schedule(cookTime: TimeInterval)
    func clear()
}

public struct EGGNotificationScheduler : EGGNotificationSchedulerProtocol {
    public var settingsManager: EGGSettingsProtocol
    public var doneNotice = EGGEggFinishedNotification()
    public var warningNotice: EGGEggThirtySecondsRemainingNotification?
    
    public init(settingsManager: EGGSettingsProtocol = EGGSettings(), doneNotice: EGGEggFinishedNotification = EGGEggFinishedNotification(), warningNotice: EGGEggThirtySecondsRemainingNotification? = EGGEggThirtySecondsRemainingNotification()) {
        self.settingsManager = settingsManager
        self.doneNotice = doneNotice
        self.warningNotice = warningNotice
    }
    
    public func schedule(cookTime: TimeInterval) {
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
