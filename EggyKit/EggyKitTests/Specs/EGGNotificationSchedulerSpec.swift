//
//  EGGNotificationSchedulerSpec.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
@testable import EggyKit

class EGGNotificationSchedulerSpec: XCTestCase {
    let fakeDoneNotice = FakeEGGEggLocalNotification()
    let fakeWarningNotice = FakeEGGEggLocalNotification()
    
    func testWarningEnabled() {
        let settingsManager = EGGSettings()
        let subject = EGGNotificationScheduler(settingsManager: settingsManager, doneNotice: fakeDoneNotice, warningNotice: fakeWarningNotice)
        subject.schedule(cookTime: 10)
        
        XCTAssert(fakeDoneNotice.capturedFire)
        XCTAssert(fakeWarningNotice.capturedFire)
    }
    
    func testWarningDisabled() {
        let settingsManager = EGGSettings(userDefaults: UserDefaults.standard, warningNotificationEnabled: false)
        let subject = EGGNotificationScheduler(settingsManager: settingsManager, doneNotice: fakeDoneNotice, warningNotice: fakeWarningNotice)
        subject.schedule(cookTime: 10)
        
        XCTAssert(fakeDoneNotice.capturedFire)
        XCTAssert(!fakeWarningNotice.capturedFire)
    }
    
    func testInvalidCookTime() {
        let settingsManager = EGGSettings(userDefaults: UserDefaults.standard, warningNotificationEnabled: false)
        let subject = EGGNotificationScheduler(settingsManager: settingsManager, doneNotice: fakeDoneNotice, warningNotice: fakeWarningNotice)
        subject.schedule(cookTime: -10)
        
        XCTAssert(!fakeDoneNotice.capturedFire)
        XCTAssert(!fakeWarningNotice.capturedFire)
    }
    
    func testClear() {
        let settingsManager = EGGSettings()
        let subject = EGGNotificationScheduler(settingsManager: settingsManager, doneNotice: fakeDoneNotice, warningNotice: fakeWarningNotice)
        subject.schedule(cookTime: 10)
        
        XCTAssert(fakeDoneNotice.capturedFire)
        XCTAssert(fakeWarningNotice.capturedFire)
        
        subject.clear()
        XCTAssert(fakeDoneNotice.capturedDelete)
        XCTAssert(fakeWarningNotice.capturedDelete)
    }
}
