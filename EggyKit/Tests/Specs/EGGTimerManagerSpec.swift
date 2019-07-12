//
//  EGGTimerManagerSpec.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/12/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
@testable import EggyKit

class EGGTimerManagerSpec: XCTestCase {
  var subject: EGGTimerManager!
  
  @TimerState()
  var test: EGGTimerState
  
  override func setUp() {
    let notification = EGGLocalNotification(title: "", message: "", userNotificationCenter: FakeUNUserNotificationCenter())
    subject = EGGTimerManager(egg: EGGEgg(), state: .stopped, notificationScheduler: EGGNotificationScheduler(settingsManager: EGGSettings(), doneNotice: notification, warningNotice: notification), boilingPointManager: EGGBoilingPointManager(isContinuous: true, altimeterClient: FakeCMAltimeter(isRelativeAltitudeAvailable: true)), notification: nil, timer: nil)
  }
  
  func testGetDefaultValue() {
    let userDefaults = UserDefaults.makeClearedInstance()
    $test.userDefaults = userDefaults
    XCTAssertEqual(test, .stopped)
    XCTAssertEqual(userDefaults.string(forKey: "kTimerState"), nil)
  }
  
  func testGet() {
    let userDefaults = UserDefaults.makeClearedInstance()
    userDefaults.set(0, forKey: "test")
    $test.userDefaults = userDefaults
    
    XCTAssertEqual(test, .stopped)
    XCTAssertEqual(userDefaults.integer(forKey: "test"), 0)
  }
  
  func testStart() {
    subject.start()
    XCTAssert(subject.state == .running)
  }
  
  func testStop() {
    subject.stop()
    XCTAssert(subject.state == .stopped)
  }
}

fileprivate extension UserDefaults {
  static func makeClearedInstance(
    for functionName: StaticString = #function,
    inFile fileName: StaticString = #file
    ) -> UserDefaults {
    let className = "\(fileName)".split(separator: ".")[0]
    let testName = "\(functionName)".split(separator: "(")[0]
    let suiteName = "\(className).\(testName)"
    
    let defaults = self.init(suiteName: suiteName)!
    defaults.removePersistentDomain(forName: suiteName)
    return defaults
  }
}
