//
//  EGGSettingsProtocolSpec.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import XCTest
@testable import EggyKit

class EGGSettingsProtocolTest: XCTestCase {
    var subject: EGGSettingsContainer!
    var createdNotificationRequest: UNNotificationRequest!
    
    override func setUp() {
        subject = EGGSettingsContainer()
    }

    func testReset() {
        subject.current.warningNotificationEnabled = !EGGSettingsToggleDefaults.warningNotificationEnabled.boolValue
        subject.reset()
        XCTAssert(subject.current.warningNotificationEnabled == EGGSettingsToggleDefaults.warningNotificationEnabled.boolValue)
    }
}
