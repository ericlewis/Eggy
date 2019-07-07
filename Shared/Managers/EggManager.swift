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

typealias Temperature = Double
typealias Size = Double
typealias Doneness = Double
typealias BoilingPoint = Double

let userDefaults = UserDefaults(suiteName: "group.eel.eggs")!

class EggManager : EasyBindableObject, FormattersProtocol, EggProtocol, CalculateProtocol, ActionsProtocol, NotificationsProtocol, ViewModelProtocol, AlitmeterProtocolDelegate {
    
    // MARK: Static Properties
    
    static var shared = EggManager()

    // MARK: Managers
    
    lazy var feedback = FeedbackManager()

    var timerComplete = false {didSet{changed()}}
    
    // TODO: navigation store?
    var needsConfirmStop = false {didSet{changed()}}
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        setupFormatters()
        setupAltimeter()
    }
    
    // MARK: Formatters Protocol
    lazy var dateFormatter = DateFormatter()
    lazy var numberFormatter: NumberFormatter = NumberFormatter()

    
    // MARK: Egg Protocol
    
    @UserDefault("temp", defaultValue: 37.0, userDefaults: userDefaults) var temp: Temperature {didSet{changed()}}
    @UserDefault("doneness", defaultValue: 56.0, userDefaults: userDefaults) var doneness: Doneness
        {didSet {changed()}}
    @UserDefault("size", defaultValue: 1.87, userDefaults: userDefaults) var size: Size
        {didSet {changed()}}
    @UserDefault("boilingPoint", defaultValue: 100.0, userDefaults: userDefaults) var boilingPoint: BoilingPoint
        {didSet {changed()}}
    @UserDefault("isRunning", defaultValue: false, userDefaults: userDefaults) var isRunning: Bool {didSet {changed()}}
    @UserDefault("endDate", defaultValue: Date(), userDefaults: userDefaults) var endDate: Date {didSet {changed()}}
    
    // MARK: Alitmeter Protocol
    lazy var altimeter = Altimeter()

    func setupAltimeter() {
        altimeter.delegate = self
        altimeter.startAltimeter()
    }
    
    // MARK: Alitmeter Delegate
    
    func changed(boilingPoint: BoilingPoint) {
        self.boilingPoint = boilingPoint
    }
}
