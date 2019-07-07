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

// TODO: put this somewhere
let userDefaults = UserDefaults(suiteName: "group.eel.eggs")!

class EggManager : EasyBindableObject, FormattersProtocol, EggStateProtocol, CookTimeProtocol, LocalNotificationsProtocol, ViewModelProtocol, BoilingPointManagerProtocolDelegate, EggDefaultsProtocol {
    
    var ticker = Timer.publish(every: 1.0, tolerance: 0.1, on: .main, in: .common).autoconnect()
    
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
        setupBoilingPointManager()
    }
    
    // MARK: Egg Protocol
    
    @UserDefault("temp", defaultValue: EggManager.eggDefaults.temp, userDefaults: userDefaults) var temp: Temperature {didSet{changed()}}
    
    @UserDefault("doneness", defaultValue: EggManager.eggDefaults.doneness, userDefaults: userDefaults) var doneness: Doneness
        {didSet {changed()}}
    
    @UserDefault("size", defaultValue: EggManager.eggDefaults.size, userDefaults: userDefaults) var size: Size
        {didSet {changed()}}
    
    @UserDefault("boilingPoint", defaultValue: EggManager.eggDefaults.boilingPoint, userDefaults: userDefaults) var boilingPoint: BoilingPoint
        {didSet {changed()}}
    
    // MARK: Egg State Protocol
    
    @UserDefault("isRunning", defaultValue: false, userDefaults: userDefaults) var isRunning: Bool {didSet {changed()}}
    
    @UserDefault("endDate", defaultValue: Date(), userDefaults: userDefaults) var endDate: Date {didSet {changed()}}
    
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
