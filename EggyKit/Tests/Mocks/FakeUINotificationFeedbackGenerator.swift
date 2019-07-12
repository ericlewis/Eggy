//
//  FakeUINotificationFeedbackGenerator.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/11/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import UIKit

class FakeUINotificationFeedbackGenerator: UINotificationFeedbackGenerator {
    var capturedFeedbackType: UINotificationFeedbackGenerator.FeedbackType!

    override func notificationOccurred(_ notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        capturedFeedbackType = notificationType
    }
}
