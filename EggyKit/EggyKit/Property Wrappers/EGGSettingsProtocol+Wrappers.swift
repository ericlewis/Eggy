//
//  EGGSettingsProtocol+Wrappers.swift
//  EggyKit
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

@propertyWrapper
public struct AltimeterEnabled {
  @Cloud(EGGSettingsKeys.enableAltimeter.rawValue,
         defaultValue: EGGSettingsDefaults.Toggles.enableAltimeter)
  public var wrappedValue: Bool

  public init(_ initialValue: Bool = EGGSettingsDefaults.Toggles.enableAltimeter) {
    wrappedValue = initialValue
  }
}

@propertyWrapper
public struct PreventAutoLock {
  @Cloud(EGGSettingsKeys.preventAutoLock.rawValue,
         defaultValue: EGGSettingsDefaults.Toggles.preventAutoLock)
  public var wrappedValue: Bool

  public init(_ initialValue: Bool = EGGSettingsDefaults.Toggles.preventAutoLock) {
    wrappedValue = initialValue
  }
}

@propertyWrapper
public struct WarningNotificationEnabled {
    @Cloud(EGGSettingsKeys.warningNotificationEnabled.rawValue,
           defaultValue: EGGSettingsDefaults.Toggles.warningNotificationEnabled)
    public var wrappedValue: Bool

    public init(_ initialValue: Bool = EGGSettingsDefaults.Toggles.warningNotificationEnabled) {
        wrappedValue = initialValue
    }
}

@propertyWrapper
public struct PrefersGrams {
  @Cloud(EGGSettingsKeys.prefersGrams.rawValue,
         defaultValue: EGGSettingsDefaults.Toggles.prefersGrams)
  public var wrappedValue: Bool

  public init(_ initialValue: Bool = EGGSettingsDefaults.Toggles.prefersGrams) {
    wrappedValue = initialValue
  }
}

@propertyWrapper
public struct PrefersCelcius {
  @Cloud(EGGSettingsKeys.preferCelcius.rawValue,
         defaultValue: EGGSettingsDefaults.Toggles.prefersCelcius)
  public var wrappedValue: Bool

  public init(_ initialValue: Bool = EGGSettingsDefaults.Toggles.prefersCelcius) {
    wrappedValue = initialValue
  }
}

@propertyWrapper
public struct AppIconIsDark {
  @Cloud(EGGSettingsKeys.appIconIsDark.rawValue,
         defaultValue: EGGSettingsDefaults.Toggles.appIconIsDark)
  public var wrappedValue: Bool

  public init(_ initialValue: Bool = EGGSettingsDefaults.Toggles.appIconIsDark) {
    wrappedValue = initialValue
  }
}
