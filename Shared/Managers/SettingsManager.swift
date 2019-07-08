//
//  SettingsManager.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine

class SettingsManager : EasyBindableObject {
  static let shared = SettingsManager()
    
  @Cloud("prefersCelcius", defaultValue: Locale.current.usesMetricSystem) var prefersCelcius: Bool {didSet {changed()}}
  
  @Cloud("preventAutoLock", defaultValue: false) var preventAutoLock: Bool {didSet {changed()}}
  
  @Cloud("thirtySecondWarning", defaultValue: true) var thirtySecondWarning: Bool {didSet {changed()}}
  
  @Cloud("disableAltimeter", defaultValue: false) var disableAltimeter: Bool {didSet {changed()}}
}
