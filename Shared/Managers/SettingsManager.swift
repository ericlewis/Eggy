//
//  SettingsManager.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine

class SettingsManager : EasyBindableObject, SettingsProtocol, SettingsDefaultsProtocol {
    static let shared = SettingsManager()
    
    @Cloud("prefersGrams", defaultValue: SettingsManager.settingsDefaults.prefersGrams) var prefersGrams: Bool {didSet {changed()}}
    
    @Cloud("prefersCelcius", defaultValue: SettingsManager.settingsDefaults.prefersCelcius) var prefersCelcius: Bool {didSet {changed()}}
    
    @Cloud("preventAutoLock", defaultValue: SettingsManager.settingsDefaults.preventAutoLock) var preventAutoLock: Bool {didSet {changed()}}
    
    @Cloud("thirtySecondWarning", defaultValue: SettingsManager.settingsDefaults.thirtySecondWarning) var thirtySecondWarning: Bool {didSet {changed()}}
    
    @Cloud("enableAltimeter", defaultValue: SettingsManager.settingsDefaults.enableAltimeter) var enableAltimeter: Bool {
        didSet {
            let manager = EggManager.shared.boilingPointManager
            if enableAltimeter {
                manager.startUpdates()
            } else {
                manager.stopUpdates()
            }
        }
    }
    
    @Cloud("appIconIsDark", defaultValue: SettingsManager.settingsDefaults.appIconIsDark) var appIconIsDark: Bool {didSet{
        UIApplication.shared.setAlternateIconName(appIconIsDark ? "AppIcon-Dark" : nil, completionHandler: { (error) in
            if error != nil {
                self.appIconIsDark.toggle()
            }
        })
        changed()
        }}
    
    func reset() {
        prefersGrams = SettingsManager.settingsDefaults.prefersGrams
        prefersCelcius = SettingsManager.settingsDefaults.prefersCelcius
        preventAutoLock = SettingsManager.settingsDefaults.preventAutoLock
        thirtySecondWarning = SettingsManager.settingsDefaults.thirtySecondWarning
        enableAltimeter = SettingsManager.settingsDefaults.enableAltimeter
    }
}
