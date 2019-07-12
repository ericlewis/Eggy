//
//  EGGEggSpec.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
@testable import EggyKit

class EGGEggSpec: XCTestCase {
    var subject: EGGEgg!

    override func setUp() {
        subject = EGGEgg()
    }

    func testCookTime() {
        XCTAssert(subject.cookTime != 0)
    }

    func testEndDate() {
        let endTime = Date().addingTimeInterval(subject.cookTime)
        let endTimeSeconds = endTime.timeIntervalSinceReferenceDate
        XCTAssert(subject.endDate.timeIntervalSinceReferenceDate.rounded() == endTimeSeconds.rounded())
    }
}
