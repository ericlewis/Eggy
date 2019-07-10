//
//  EGGCMAAltimeterProtocol.swift
//  EggyKit
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import CoreMotion

public protocol EGGCMAAltimeterProtocol {
    var isRelativeAltitudeAvailable: Bool {get}
    
    func startRelativeAltitudeUpdates(to queue: OperationQueue, withHandler handler: @escaping CMAltitudeHandler)
    func stopRelativeAltitudeUpdates()
}

public struct EGGCMAAltimeterClient : EGGCMAAltimeterProtocol {
    private(set) var altimeter = CMAltimeter()
    
    public init() {}
    
    public var isRelativeAltitudeAvailable: Bool {
        CMAltimeter.isRelativeAltitudeAvailable()
    }
    
    public func startRelativeAltitudeUpdates(to queue: OperationQueue, withHandler handler: @escaping CMAltitudeHandler) {
        altimeter.startRelativeAltitudeUpdates(to: queue, withHandler: handler)
    }
    
    public func stopRelativeAltitudeUpdates() {
        altimeter.stopRelativeAltitudeUpdates()
    }
}
