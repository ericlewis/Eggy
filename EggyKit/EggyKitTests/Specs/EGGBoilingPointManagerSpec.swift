//
//  EGGCMAltimeterProtocolSpec.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
@testable import EggyKit

class EGGBoilingPointManagerSpec: XCTestCase {
    func testStartUpdates() {
        let fakeAltimeterClient = FakeCMAltimeter(isRelativeAltitudeAvailable: true)
        let subject = EGGBoilingPointManager(isContinuous: true, altimeterClient: fakeAltimeterClient)
        subject.startUpdates()
        
        XCTAssert(fakeAltimeterClient.capturedStartRelativeAltitudeUpdates)
    }
    
    func testStartUpdatesAltitudeUnavailable() {
        let fakeAltimeterClient = FakeCMAltimeter(isRelativeAltitudeAvailable: false)
        let subject = EGGBoilingPointManager(isContinuous: true, altimeterClient: fakeAltimeterClient)
        subject.startUpdates()
        
        XCTAssert(!fakeAltimeterClient.capturedStartRelativeAltitudeUpdates)
    }
    
    func testStopUpdates() {
        let fakeAltimeterClient = FakeCMAltimeter(isRelativeAltitudeAvailable: true)
        let subject = EGGBoilingPointManager(isContinuous: true, altimeterClient: fakeAltimeterClient)
        subject.startUpdates()
        XCTAssert(fakeAltimeterClient.capturedStartRelativeAltitudeUpdates)
        
        subject.stopUpdates()
        XCTAssert(fakeAltimeterClient.capturedStopRelativeAltitudeUpdates)
    }
}
