//
//  EGGCookTimeCalculatorSpec.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
@testable import EggyKit

class EGGCookTimeCalculatorSpec: XCTestCase, EGGCookTimeCalculator {
    var egg: EGGEgg!
    
    override func setUp() {
        egg = EGGEgg()
    }
    
    func testDefault() {
        XCTAssert(calculateCookTime(withEgg: egg) == 270.2168907625191)
    }
}
