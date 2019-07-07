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

class EggManager : BindableObject {
  lazy var altimeter = CMAltimeter()
  lazy var dateFormatter = DateFormatter()
  lazy var select = UISelectionFeedbackGenerator()
  lazy var feedback = UIImpactFeedbackGenerator(style: .heavy)
  lazy var feedbackNoti = UINotificationFeedbackGenerator()
  lazy var didChange = PassthroughSubject<Void, Never>()
  
  @UserDefault("temp", defaultValue: 37.0) var temp: Temperature
    {didSet {
      changed()
    }}
  
  @UserDefault("doneness", defaultValue: 56.0) var doneness: Doneness
    {didSet {changed()}}
  
  @UserDefault("size", defaultValue: 1.87) var size: Size
    {didSet {changed()}}
  
  @UserDefault("boilingPoint", defaultValue: 100.0) var boilingPoint: BoilingPoint
    {didSet {changed()}}
  
  @UserDefault("isRunning", defaultValue: false) var isRunning: Bool {didSet {changed()}}
  
  @UserDefault("endDate", defaultValue: Date()) var endDate: Date {didSet {changed()}}
  
  @UserDefault("prefersCelcius", defaultValue: false) var prefersCelcius: Bool {didSet {changed()}}

  var timerComplete = false {didSet{changed()}}
  var needsConfirmStop = false {didSet{changed()}}

  var isFinished: Bool {
    endDate <= Date()
  }
  
  func changed() {
    didChange.send()
  }
  
  var endDateString: String {
    dateFormatter.string(from: endDate)
  }
  
  init() {
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    
    startAltimeter()
  }
}

extension EggManager {
  func start() {
    endDate = Date().addingTimeInterval(rawCookTime)
    createNotification()
    self.isRunning = true
  }
  
  func stop() {
    feedbackNoti.notificationOccurred(.error)
    endDate = .distantFuture
    deleteNotification()
    needsConfirmStop = false
    isRunning = false
    feedbackNoti.prepare()
  }
  
  func toggleRunning() {

    if isRunning {
      needsConfirmStop = true
      feedback.impactOccurred()
    } else {
      start()
      feedbackNoti.notificationOccurred(.success)
    }
    
    feedback.prepare()
  }
}

extension EggManager {
  var rawCookTime: Double {
    EggManager.calculateCookTime(t: temp, d: doneness, s: size, b: boilingPoint)
  }
  
  var rawTimeRemaining: Double {
    let remaining = max(0.0, endDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate)
    
    if remaining == 0.0 && isRunning {
      timerComplete = true
      stop()
    }
    
    return remaining
  }
  
  var cookTime: String {
    if isRunning {
      return rawTimeRemaining.stringFromTimeInterval()
    } else {
      return rawCookTime.stringFromTimeInterval()
    }
  }
}

extension EggManager {
  func createNotification() {
    let startTime = CACurrentMediaTime()
    
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
      let endTime = CACurrentMediaTime() - startTime
      
      let restartAction = UNNotificationAction(
        identifier: "restart",
        title: "Restart",
        options: [])
      let categoryIdentifier = "timer.category.action";
      // TODO: localize?
      let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [restartAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "A timer has finished!", options: [])
      UNUserNotificationCenter.current().setNotificationCategories([category])
      
      let content = UNMutableNotificationContent()
      // TODO: localize me
      content.title = "Timer is done"
      content.body = self.cookTime
      content.sound = .default
      content.categoryIdentifier = categoryIdentifier
      content.userInfo = ["identifier": "timer"]
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.rawCookTime + endTime, repeats: false)
      
      let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
      
      UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
        if let error = error {
          print("Unable to Create Notice")
          print("\(error), \(error.localizedDescription)")
        }
      })
    }
  }
  
  func deleteNotification() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer"])
  }
}

extension EggManager {
  static func calculateCookTime(t: Double, d: Double, s: Double, b: Double) -> Double {
    let heatCoeff = 31.0
    let yolkWhiteRatio = 0.86
    
    let eggTemp = Measurement(value: t, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
    
    let weight = Measurement(value: s, unit: UnitMass.ounces).converted(to: .grams).value
    
    return pow(weight, 2/3) * heatCoeff * log(yolkWhiteRatio * (eggTemp - b) / (d - b))
  }
  
}

extension EggManager {
  func startAltimeter() {
    if CMAltimeter.isRelativeAltitudeAvailable() {
      altimeter.startRelativeAltitudeUpdates(to: .main) { data, err in
        if let rawPressure = data?.pressure.doubleValue {
          let pressure = Measurement(value: rawPressure, unit: UnitPressure.kilopascals).converted(to: .inchesOfMercury).value
          
          let res = Measurement(value: 49.161 * log(pressure) + 44, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
          self.boilingPoint = res
        }
        
        self.altimeter.stopRelativeAltitudeUpdates()
      }
    }
  }
  
}
