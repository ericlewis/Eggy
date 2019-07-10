//
//  EGGSettingsProtocol.swift
//  EggyKit
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

public protocol EGGSettingsProtocol {
    var userDefaults: UserDefaults {get}
    var warningNotificationEnabled: Bool {get set}
}

enum EGGSettingsKeys : String {
    case warningNotificationEnabled = "warningNotificationEnabled"
}

public struct EGGSettingsDefaults {
    public enum Toggles : Int {
        case warningNotificationEnabled = 1
        
        public var boolValue: Bool {
            if rawValue == 0 {
                return false
            } else {
                return true
            }
        }
    }
}

public struct EGGSettings : EGGSettingsProtocol {
    public var userDefaults: UserDefaults
    
    @WarningNotificationEnabled()
    public var warningNotificationEnabled: Bool
    
    // TODO: some sort of way to actually mock this.. maybe we fake it? prop wrappers don't have a great way to grab this stuff
    public init(userDefaults: UserDefaults = UserDefaults.standard,
                warningNotificationEnabled: Bool = EGGSettingsDefaults.Toggles.warningNotificationEnabled.boolValue) {
        self.userDefaults = userDefaults
        self.warningNotificationEnabled = warningNotificationEnabled
    }
}

public class EGGSettingsContainer {
    public var current: EGGSettings = EGGSettings()
    public func reset() {
        current.warningNotificationEnabled = EGGSettingsDefaults.Toggles.warningNotificationEnabled.boolValue
    }
}
