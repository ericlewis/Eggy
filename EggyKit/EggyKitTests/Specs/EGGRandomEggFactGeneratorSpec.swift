//
//  EGGRandomEggFactGeneratorSpec.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
@testable import EggyKit

class EGGRandomEggFactGeneratorSpec: XCTestCase {
    var subject: EGGRandomEggFactGenerator!
    
    override func setUp() {
        subject = EGGRandomEggFactGenerator()
    }
    
    func testGenerate() {
        let face = subject.fact
        subject.generate(timer: Timer.init(timeInterval: 0.1, repeats: false, block: { _ in }))
        XCTAssert(face != subject.fact)
    }
    
    func testFactReturned() {
        XCTAssert(subject.fact.count > 0)
    }
    
    func testTearDown() {
        subject.tearDown()
        XCTAssert(subject.timer == nil)
    }
}
