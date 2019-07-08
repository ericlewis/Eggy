//
//  EggManager.swift
//  Eggy
//
//  Created by Eric Lewis on 7/6/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine
import CoreMotion

class EggManager : EasyBindableObject, FormattersProtocol, EggStateProtocol, CookTimeProtocol, LocalNotificationsProtocol, ViewModelProtocol, BoilingPointManagerProtocolDelegate, EggDefaultsProtocol {
    
    lazy var ticker = Timer.publish(every: 1.0, tolerance: 0.1, on: .main, in: .common).autoconnect()
    
    // MARK: Static Properties
    
    static var shared = EggManager()
    
    // MARK: Managers
    
    lazy var feedback = FeedbackManager()
    
    // TODO: navigation store?
    var confirmResetTimer = false {didSet{changed()}}
    
    // MARK: Initialization
    
    override init() {
        super.init()
      
        setupFormatters()
        
        if SettingsManager.shared.enableAltimeter {
            setupBoilingPointManager()
        }
    }
    
    // MARK: Egg Protocol
    
    @Cloud("temp", defaultValue: EggManager.eggDefaults.temp) var temp: Temperature {didSet{changed()}}
    
    @Cloud("doneness", defaultValue: EggManager.eggDefaults.doneness) var doneness: Doneness
        {didSet {changed()}}
    
    @Cloud("size", defaultValue: EggManager.eggDefaults.size) var size: Size
        {didSet {changed()}}
    
    @Cloud("boilingPoint", defaultValue: EggManager.eggDefaults.boilingPoint) var boilingPoint: BoilingPoint
        {didSet {changed()}}
    
    // MARK: Egg State Protocol
    
    @Cloud("isRunning", defaultValue: false) var isRunning: Bool {didSet {changed()}}
    
    @Cloud("endDate", defaultValue: Date()) var endDate: Date {didSet {changed()}}
    
    func stopped(needsConfirm: Bool) {
        if needsConfirm {
            feedback.buzz(type: .lightImpact) {
                self.confirmResetTimer = true
            }
        } else {
            feedback.buzz(type: .success) {
                self.confirmResetTimer = false
                self.deleteNotifications()
            }
        }
    }
    
    func started() {
        feedback.buzz(type: .success, action: createNotifications)
    }
    
    func reset() {
        temp = eggDefaults.temp
        doneness = eggDefaults.doneness
        size = eggDefaults.size
        boilingPoint = eggDefaults.boilingPoint
    }
    
    // MARK: Boiling Point Protocol
    
    lazy var boilingPointManager = BoilingPointManager()
    
    func setupBoilingPointManager() {
        boilingPointManager.delegate = self
        boilingPointManager.startUpdates()
    }
    
    // MARK: Boiling Point Delegate
    
    func changed(boilingPoint: BoilingPoint) {
        self.boilingPoint = boilingPoint
    }
}
