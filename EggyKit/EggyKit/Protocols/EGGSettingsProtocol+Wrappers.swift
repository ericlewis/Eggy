//
//  EGGSettingsProtocol+Wrappers.swift
//  EggyKit
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

@propertyWrapper
public struct WarningNotificationEnabled {
    @Cloud(EGGSettingsKeys.warningNotificationEnabled.rawValue,
           defaultValue: EGGSettingsDefaults.Toggles.warningNotificationEnabled)
    public var wrappedValue: Bool

    public init(_ initialValue: Bool = EGGSettingsDefaults.Toggles.warningNotificationEnabled) {
        wrappedValue = initialValue
    }
}
