//
//  EGGCMAltimeterProtocolSpec.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
import CoreMotion
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

    func testOneOffUpdates() {
        let fakeAltimeterClient = FakeCMAltimeter(isRelativeAltitudeAvailable: true)
        let subject = EGGBoilingPointManager(isContinuous: false, altimeterClient: fakeAltimeterClient)
        subject.startUpdates()
        XCTAssert(fakeAltimeterClient.capturedStartRelativeAltitudeUpdates)
        XCTAssert(fakeAltimeterClient.capturedStopRelativeAltitudeUpdates)
    }

    func testContinuousUpdates() {
        let fakeAltimeterClient = FakeCMAltimeter(isRelativeAltitudeAvailable: true)
        let subject = EGGBoilingPointManager(isContinuous: true, altimeterClient: fakeAltimeterClient)
        subject.startUpdates()
        XCTAssert(fakeAltimeterClient.capturedStartRelativeAltitudeUpdates)
        XCTAssert(!fakeAltimeterClient.capturedStopRelativeAltitudeUpdates)
    }

    func testBoilingPointCorrect() {
        let fakeAltimeterClient = FakeCMAltimeter(isRelativeAltitudeAvailable: true)
        let subject = EGGBoilingPointManager(isContinuous: false, altimeterClient: fakeAltimeterClient)

        let data = FakeCMAltitudeData()
        subject.update(data, nil)
        XCTAssert(subject.boilingPoint == 98.57596985386516)
    }
}
