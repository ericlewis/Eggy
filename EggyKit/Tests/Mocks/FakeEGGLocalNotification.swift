//
//  FakeEGGEggFinishedNotification.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import EggyKit

public class FakeEGGEggLocalNotification: EGGLocalNotification {

    var capturedFire: Bool = false
    var capturedDelete: Bool = false

    public init() {
        super.init(title: "testing", message: nil, userNotificationCenter: FakeUNUserNotificationCenter())
    }

    override public func fire(triggerOffset: TimeInterval) {
        capturedFire = true
    }

    override public func delete() {
        capturedDelete = true
    }
}
