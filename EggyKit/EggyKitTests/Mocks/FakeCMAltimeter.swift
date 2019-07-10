//
//  FakeCMAltimeterClient.swift
//  EggyKitTests
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import CoreMotion
import EggyKit

class FakeCMAltimeter: EGGCMAltimeterProtocol {
    
    // MARK: Captured properties
    
    var capturedStartRelativeAltitudeUpdates: Bool
    var capturedStopRelativeAltitudeUpdates: Bool
    var firedEvent: Bool

    init(isRelativeAltitudeAvailable: Bool) {
        self.isRelativeAltitudeAvailable = isRelativeAltitudeAvailable
        capturedStopRelativeAltitudeUpdates = false
        capturedStartRelativeAltitudeUpdates = false
        firedEvent = false
    }
    
    
    // MARK: EGGCMAltimeterProtocol
    
    var isRelativeAltitudeAvailable: Bool
    
    func startRelativeAltitudeUpdates(to queue: OperationQueue, withHandler handler: @escaping CMAltitudeHandler) {
        capturedStartRelativeAltitudeUpdates = true
        if isRelativeAltitudeAvailable {
            handler(nil, nil)
        }
    }
    
    func stopRelativeAltitudeUpdates() {
        capturedStopRelativeAltitudeUpdates = true
    }
    
}
