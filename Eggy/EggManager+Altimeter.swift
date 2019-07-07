//
//  EggManager+Altimeter.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

#if canImport(CoreMotion)
import CoreMotion

extension EggManager {  
  func startAltimeter() {
    if CMAltimeter.isRelativeAltitudeAvailable() {
      altimeter.startRelativeAltitudeUpdates(to: .main) { data, err in
        if let rawPressure = data?.pressure.doubleValue {
          let pressure = Measurement(value: rawPressure, unit: UnitPressure.kilopascals).converted(to: .inchesOfMercury).value
          
          let res = Measurement(value: 49.161 * log(pressure) + 44, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
          self.boilingPoint = res
        }
        
        self.altimeter.stopRelativeAltitudeUpdates()
      }
    }
  }
}
#else
extension EggManager {
  func startAltimeter() {
    // no-op
  }
}
#endif

