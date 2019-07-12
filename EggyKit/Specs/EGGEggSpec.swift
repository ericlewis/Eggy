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

  func testTemperatureUpperBound() {
    subject.temperature = 10_000
    XCTAssert(subject.temperature == EGGEggPropertyRanges.temperatureRange.upperBound)
  }

  func testTemperatureLowerBound() {
    subject.temperature = -10_000
    XCTAssert(subject.temperature == EGGEggPropertyRanges.temperatureRange.lowerBound)
  }

  func testDonenessUpperBound() {
    subject.doneness = 10_000
    XCTAssert(subject.doneness == EGGEggPropertyRanges.donenessRange.upperBound)
  }

  func testDonenessLowerBound() {
    subject.doneness = -10_000
    XCTAssert(subject.doneness == EGGEggPropertyRanges.donenessRange.lowerBound)
  }

  func testSizeUpperBound() {
    subject.size = 10_000
    XCTAssert(subject.size == EGGEggPropertyRanges.sizeRange.upperBound)
  }

  func testSizeLowerBound() {
    subject.size = -10_000
    XCTAssert(subject.size == EGGEggPropertyRanges.sizeRange.lowerBound)
  }
}
