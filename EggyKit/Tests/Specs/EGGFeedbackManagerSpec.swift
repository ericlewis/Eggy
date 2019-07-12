//
//  EGGFeedbackManagerSpec.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/11/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
@testable import EggyKit

class EGGFeedbackManagerSpec: XCTestCase {
    var fakeSelectionFeedbackGenerator = FakeUISelectionFeedbackGenerator()
    var fakeImpactFeedbackGenerator = FakeUIImpactFeedbackGenerator()
    var fakeNotificationFeedbackGenerator = FakeUINotificationFeedbackGenerator()
    
    var subject: EGGFeedbackManager!
    
    override func setUp() {
        subject = EGGFeedbackManager(select: fakeSelectionFeedbackGenerator, impact: fakeImpactFeedbackGenerator, notice: fakeNotificationFeedbackGenerator)
    }
    
    func testSelectionFeedback() {
        subject.buzz(type: .select)
        XCTAssert(fakeSelectionFeedbackGenerator.didCaptureSelectionChanged)
    }
    
    func testImpactFeedback() {
        subject.buzz(type: .impact)
        XCTAssert(fakeImpactFeedbackGenerator.didCaptureImpactOccurred)
        XCTAssert(fakeImpactFeedbackGenerator.capturedImpactIntensity < 0)
    }
    
    func testLightImpactFeedback() {
        subject.buzz(type: .lightImpact)
        XCTAssert(fakeImpactFeedbackGenerator.didCaptureImpactOccurred)
        XCTAssert(fakeImpactFeedbackGenerator.capturedImpactIntensity == 0.5)
    }
    
    func testSuccessFeedback() {
        subject.buzz(type: .success)
        XCTAssert(fakeNotificationFeedbackGenerator.capturedFeedbackType == .success)
    }
    
    func testFailureFeedback() {
        subject.buzz(type: .failure)
         XCTAssert(fakeNotificationFeedbackGenerator.capturedFeedbackType == .error)
    }
}
