//
//  EGGEggProperties+Wrappers.swift
//  EggyKit
//
//  Created by Eric Lewis on 7/10/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

@propertyWrapper
public struct EggTemperature {
    @Cloud(EGGEggPropertyDefaultsKey.temperature.rawValue, defaultValue: EGGEggPropertyDefaults.temperature.rawValue)
    public var wrappedValue: Temperature
    
    public init(_ defaultValue: Temperature = EGGEggPropertyDefaults.temperature.rawValue) {
        wrappedValue = defaultValue
    }
}

@propertyWrapper
public struct EggDoneness {
    @Cloud(EGGEggPropertyDefaultsKey.doneness.rawValue, defaultValue: EGGEggPropertyDefaults.doneness.rawValue)
    public var wrappedValue: Doneness
    
    public init(_ defaultValue: Doneness = EGGEggPropertyDefaults.doneness.rawValue) {
        wrappedValue = defaultValue
    }
}

@propertyWrapper
public struct EggSize {
    @Cloud(EGGEggPropertyDefaultsKey.size.rawValue, defaultValue: EGGEggPropertyDefaults.size.rawValue)
    public var wrappedValue: Size
    
    public init(_ defaultValue: Size = EGGEggPropertyDefaults.size.rawValue) {
        wrappedValue = defaultValue
    }
}

@propertyWrapper
public struct EggBoilingPoint {
    @Cloud(EGGEggPropertyDefaultsKey.boilingPoint.rawValue, defaultValue: EGGEggPropertyDefaults.boilingPoint.rawValue)
    public var wrappedValue: Temperature
    
    public init(_ defaultValue: Temperature = EGGEggPropertyDefaults.boilingPoint.rawValue) {
        wrappedValue = defaultValue
    }
}
