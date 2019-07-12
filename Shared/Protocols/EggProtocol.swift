//
//  EggProtocol.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

typealias Temperature = Double
typealias Size = Double
typealias Doneness = Double
typealias BoilingPoint = Double

protocol EggProtocol {
    var temp: Temperature {get set}
    var doneness: Doneness {get set}
    var size: Size {get set}
    var boilingPoint: BoilingPoint {get set}
    var rawCookTime: TimeInterval {get}

    func reset()
}

extension EggProtocol {
    var rawCookTime: TimeInterval {
        EggManager.calculateCookTime(t: temp, d: doneness, s: size, b: boilingPoint)
    }
}
