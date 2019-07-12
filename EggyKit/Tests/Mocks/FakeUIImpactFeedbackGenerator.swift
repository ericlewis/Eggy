//
//  FakeUIImpactFeedbackGenerator.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/11/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import UIKit

class FakeUIImpactFeedbackGenerator : UIImpactFeedbackGenerator {
    var didCaptureImpactOccurred = false
    var capturedImpactIntensity: CGFloat = -10_000

    override func impactOccurred() {
        didCaptureImpactOccurred = true
    }
    
    override func impactOccurred(withIntensity intensity: CGFloat) {
        didCaptureImpactOccurred = true
        capturedImpactIntensity = intensity
    }
}
