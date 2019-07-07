//
//  EggManager+Altimeter.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import CoreMotion

protocol AlitmeterProtocolDelegate {
    func changed(boilingPoint: BoilingPoint)
}

protocol AltimeterProtocol: class {
    var altimeter: CMAltimeter {get}
    func startAltimeter()
    
    var delegate: AlitmeterProtocolDelegate? {get set}
}

class Altimeter : AltimeterProtocol {
    lazy var altimeter = CMAltimeter()
    
    var delegate: AlitmeterProtocolDelegate?

    func startAltimeter() {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: .main) { data, err in
                if let rawPressure = data?.pressure.doubleValue {
                    let pressure = Measurement(value: rawPressure, unit: UnitPressure.kilopascals).converted(to: .inchesOfMercury).value
                    
                    let res = Measurement(value: 49.161 * log(pressure) + 44, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
                    self.delegate?.changed(boilingPoint: res)
                }
                
                self.altimeter.stopRelativeAltitudeUpdates()
            }
        }
    }
}
