//
//  FakeUISelectionFeedbackGenerator.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/11/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import UIKit

class FakeUISelectionFeedbackGenerator : UISelectionFeedbackGenerator {
    var didCaptureSelectionChanged = false
    
    override func selectionChanged() {
        didCaptureSelectionChanged = true
    }
}
