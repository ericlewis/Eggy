//
//  Defaults.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol EggDefaultsProtocol : EggProtocol {
    static var eggDefaults: EggDefaults {get}
    var eggDefaults: EggDefaults {get}
}

struct EggDefaults : EggProtocol {
    var temp: Temperature = 37
    var tempRange = Range<Double>.temperature
    
    var doneness: Doneness = 56
    var donenessRange = Range<Double>.doneness

    var size: Size = 1.87
    var sizeRange = Range<Double>.size

    var boilingPoint: BoilingPoint = 100
}

extension Range {
    static var temperature: ClosedRange<Double> {
        return 37...73
    }
    
    static var doneness: ClosedRange<Double> {
        return 56...85
    }
    
    static var size: ClosedRange<Double> {
        return 1.37...2.8
    }
}

extension EggDefaultsProtocol {
    static var eggDefaults: EggDefaults {
        EggDefaults()
    }
    
    var eggDefaults: EggDefaults {
        EggDefaults()
    }
}
