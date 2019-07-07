//
//  EggManager+Calculate.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol CalculateProtocol {
    static func calculateCookTime(t: Double, d: Double, s: Double, b: Double) -> Double
}

extension CalculateProtocol {
    static func calculateCookTime(t: Double, d: Double, s: Double, b: Double) -> Double {
        let heatCoeff = 31.0
        let yolkWhiteRatio = 0.86
        
        let eggTemp = Measurement(value: t, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
        
        let weight = Measurement(value: s, unit: UnitMass.ounces).converted(to: .grams).value
        
        return pow(weight, 2/3) * heatCoeff * log(yolkWhiteRatio * (eggTemp - b) / (d - b))
    }
    
}
