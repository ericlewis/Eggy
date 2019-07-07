//
//  SettingsManager.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine

class SettingsManager : BindableObject {
  
  @UserDefault("prefersCelcius", defaultValue: Locale.current.usesMetricSystem, userDefaults: userDefaults) var prefersCelcius: Bool {didSet {changed()}}
  
  @UserDefault("preventAutoLock", defaultValue: false, userDefaults: userDefaults) var preventAutoLock: Bool {didSet {changed()}}
  
  @UserDefault("thirtySecondWarning", defaultValue: true, userDefaults: userDefaults) var thirtySecondWarning: Bool {didSet {changed()}}
  
  @UserDefault("disableAltimeter", defaultValue: false, userDefaults: userDefaults) var disableAltimeter: Bool {didSet {changed()}}
  
  func changed() {
    didChange.send()
  }
  
  var didChange = PassthroughSubject<Void, Never>()
}
