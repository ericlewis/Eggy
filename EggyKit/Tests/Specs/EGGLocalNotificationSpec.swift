//
//  EggyKitTests.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
@testable import EggyKit

class EGGLocalNotificationTests: XCTestCase {
    var fakeUserNotificationCenter: FakeUNUserNotificationCenter!
    var subject: EGGLocalNotification!
    var createdNotificationRequest: UNNotificationRequest!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fakeUserNotificationCenter = FakeUNUserNotificationCenter()
        subject = EGGLocalNotification(title: "Hello", message: "World", userNotificationCenter: fakeUserNotificationCenter)
        subject.fire(triggerOffset: 100)
        createdNotificationRequest = fakeUserNotificationCenter.capturedAddRequest
    }

    func testHasCorrectContent() {
        XCTAssert(subject.title == "Hello")
        XCTAssert(subject.message == "World")
    }
    
    func testHasCorrectTrigger() {
        let timeIntervalTrigger = createdNotificationRequest.trigger as! UNTimeIntervalNotificationTrigger
        XCTAssert(timeIntervalTrigger.timeInterval == 100)
    }
    
    func testDoesntDoAnythingWhenFinished() {
        XCTAssert(fakeUserNotificationCenter.capturedAddCompletionHandler == nil)
    }
    
    func testDoesntFireWithoutTitle() {
        let fakeUserNotificationCenter = FakeUNUserNotificationCenter()
        let subject = EGGLocalNotification(title: "Hello", message: "World", userNotificationCenter: fakeUserNotificationCenter)
        let createdNotificationRequest = fakeUserNotificationCenter.capturedAddRequest
        
        subject.title = nil
        subject.fire(triggerOffset: 100)
        
        XCTAssert(createdNotificationRequest == nil)
    }
    
    func testDeleteWithoutTitle() {
        subject.title = nil
        subject.delete()
        XCTAssert(fakeUserNotificationCenter.capturedDeleteId == nil)
    }
    
    func testDelete() {
        subject.delete()
        XCTAssert(fakeUserNotificationCenter.capturedDeleteId == subject.title)
    }
}

class EGGEggThirtySecondsRemainingNotificationTests: XCTestCase {
    var fakeUserNotificationCenter: FakeUNUserNotificationCenter!
    var subject: EGGEggThirtySecondsRemainingNotification!
    var createdNotificationRequest: UNNotificationRequest!

    override func setUp() {
        fakeUserNotificationCenter = FakeUNUserNotificationCenter()
        subject = EGGEggThirtySecondsRemainingNotification(userNotificationCenter: fakeUserNotificationCenter)
        subject.fire(triggerOffset: 100)
        
        createdNotificationRequest = fakeUserNotificationCenter.capturedAddRequest
    }
    
    func testHasCorrectContent() {
        XCTAssert(subject.title == "Your egg will be done in 30 seconds!")
        XCTAssert(subject.message == nil)
    }
    
    func testHasCorrectTrigger() {
        let timeIntervalTrigger = createdNotificationRequest.trigger as! UNTimeIntervalNotificationTrigger
        
        // Fire automatically shaves off the needed 30 seconds, so no manual work is required
        
        XCTAssert(timeIntervalTrigger.timeInterval == 70)
    }
    
    func testDoesntDoAnythingWhenFinished() {
        XCTAssert(fakeUserNotificationCenter.capturedAddCompletionHandler == nil)
    }
}


class EGGFinishedNotificationTests: XCTestCase {
    var fakeUserNotificationCenter: FakeUNUserNotificationCenter!
    var subject: EGGEggFinishedNotification!
    var createdNotificationRequest: UNNotificationRequest!

    override func setUp() {
        fakeUserNotificationCenter = FakeUNUserNotificationCenter()
        subject = EGGEggFinishedNotification(userNotificationCenter: fakeUserNotificationCenter)
        subject.fire(triggerOffset: 100)
        
        createdNotificationRequest = fakeUserNotificationCenter.capturedAddRequest
    }

    func testHasCorrectContent() {
        XCTAssert(subject.title == "Your egg is done!")
        XCTAssert(subject.message == nil)
    }
    
    func testHasCorrectTrigger() {
        let timeIntervalTrigger = createdNotificationRequest.trigger as! UNTimeIntervalNotificationTrigger
        XCTAssert(timeIntervalTrigger.timeInterval == 100)
    }
    
    func testDoesntDoAnythingWhenFinished() {
        XCTAssert(fakeUserNotificationCenter.capturedAddCompletionHandler == nil)
    }
}
