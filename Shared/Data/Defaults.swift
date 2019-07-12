//
//  Defaults.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol SettingsDefaultsProtocol: SettingsProtocol {
    static var settingsDefaults: SettingsDefaults {get}
    var settingsDefaults: SettingsDefaults {get}
}

class SettingsDefaults: SettingsDefaultsProtocol {
    var prefersGrams = Locale.current.usesMetricSystem
    var prefersCelcius = Locale.current.usesMetricSystem
    var preventAutoLock = false
    var thirtySecondWarning = true
    var enableAltimeter = true
    var appIconIsDark = false

    func reset() {}
}

extension SettingsDefaultsProtocol {
    static var settingsDefaults: SettingsDefaults {
        SettingsDefaults()
    }

    var settingsDefaults: SettingsDefaults {
        SettingsDefaults()
    }
}

protocol EggDefaultsProtocol: EggProtocol {
    static var eggDefaults: EggDefaults {get}
    var eggDefaults: EggDefaults {get}
}

struct EggDefaults: EggProtocol {
    var temp: Temperature = 40
    var tempRange = Range<Double>.temperature

    var doneness: Doneness = EggDoneness.hard.rawValue
    var donenessRange = Range<Double>.doneness

    var size: Size = EggSize.large.rawValue
    var sizeRange = Range<Double>.size

    var boilingPoint: BoilingPoint = 100

    func reset() {}
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
