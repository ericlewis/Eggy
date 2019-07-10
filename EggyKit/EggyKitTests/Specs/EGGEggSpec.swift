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
        XCTAssert(subject.endDate.timeIntervalSinceReferenceDate.rounded() == Date().addingTimeInterval(subject.cookTime).timeIntervalSinceReferenceDate.rounded())
    }
}
