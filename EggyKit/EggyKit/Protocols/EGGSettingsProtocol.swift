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

  var prefersGrams: Bool {get set}
  var prefersCelcius: Bool {get set}
  var preventAutoLock: Bool {get set}
  var warningNotificationEnabled: Bool {get set}
  var enableAltimeter: Bool {get set}
  var appIconIsDark: Bool {get set}
}

enum EGGSettingsKeys: String {
  case warningNotificationEnabled
  case prefersGrams
  case preferCelcius
  case preventAutoLock
  case enableAltimeter
  case appIconIsDark
}

// this is probably a bad idea, tests don't like it, and i don't think cases can be the same. wont scale
public struct EGGSettingsDefaults {
  public struct Toggles {
    public static var warningNotificationEnabled = true
    public static var prefersGrams = NSLocale.current.usesMetricSystem
    public static var prefersCelcius = NSLocale.current.usesMetricSystem
    public static var preventAutoLock = false
    public static var enableAltimeter = true
    public static var appIconIsDark = false
  }
}

public struct EGGSettings: EGGSettingsProtocol {
  public var userDefaults: UserDefaults

  @WarningNotificationEnabled()
  public var warningNotificationEnabled: Bool

  @PrefersGrams()
  public var prefersGrams: Bool

  @PrefersCelcius()
  public var prefersCelcius: Bool

  @PreventAutoLock()
  public var preventAutoLock: Bool

  @AltimeterEnabled()
  public var enableAltimeter: Bool

  @AppIconIsDark()
  public var appIconIsDark: Bool

  public init(userDefaults: UserDefaults = UserDefaults.standard,
              warningNotificationEnabled: Bool = EGGSettingsDefaults.Toggles.warningNotificationEnabled,
              prefersGrams: Bool = EGGSettingsDefaults.Toggles.prefersGrams,
              prefersCelcius: Bool = EGGSettingsDefaults.Toggles.prefersCelcius,
              preventAutoLock: Bool = EGGSettingsDefaults.Toggles.preventAutoLock,
              enableAltimeter: Bool = EGGSettingsDefaults.Toggles.enableAltimeter,
              appIconIsDark: Bool = EGGSettingsDefaults.Toggles.appIconIsDark) {
    self.userDefaults = userDefaults
    self.warningNotificationEnabled = warningNotificationEnabled
    self.prefersGrams = prefersGrams
    self.prefersCelcius = prefersCelcius
    self.preventAutoLock = preventAutoLock
    self.enableAltimeter = enableAltimeter
    self.appIconIsDark = appIconIsDark
  }
}

public class EGGSettingsContainer: EasyBindableObject {
  public override init() {
    super.init()
  }

  public var current: EGGSettings = EGGSettings() {
    didSet {
      changed()
    }
  }

  public func reset() {
    current.warningNotificationEnabled = EGGSettingsDefaults.Toggles.warningNotificationEnabled
    current.enableAltimeter = EGGSettingsDefaults.Toggles.enableAltimeter
    current.preventAutoLock = EGGSettingsDefaults.Toggles.preventAutoLock
    current.appIconIsDark = EGGSettingsDefaults.Toggles.appIconIsDark
    current.prefersCelcius = EGGSettingsDefaults.Toggles.prefersCelcius
    current.prefersGrams = EGGSettingsDefaults.Toggles.prefersGrams
    changed()
  }
}
