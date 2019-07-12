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
  @Cloud(EGGEggPropertyDefaultsKey.temperature.rawValue, defaultValue: EGGEggPropertyDefaults.temperature)
  public var value: Temperature
  public let range = EGGEggPropertyRanges.temperatureRange

  public init(_ defaultValue: Temperature = EGGEggPropertyDefaults.temperature) {
    value = defaultValue
  }

  public var wrappedValue: Temperature {
    get { value }
    set { value = min(max(range.lowerBound, newValue), range.upperBound) }
  }
}

@propertyWrapper
public struct EggDoneness {
  @Cloud(EGGEggPropertyDefaultsKey.doneness.rawValue, defaultValue: EGGEggPropertyDefaults.doneness)
  public var value: Doneness
  public let range = EGGEggPropertyRanges.donenessRange

  public init(_ defaultValue: Doneness = EGGEggPropertyDefaults.doneness) {
    value = defaultValue
  }

  public var wrappedValue: Temperature {
    get { value }
    set { value = min(max(range.lowerBound, newValue), range.upperBound) }
  }
}

@propertyWrapper
public struct EggSize {
  @Cloud(EGGEggPropertyDefaultsKey.size.rawValue, defaultValue: EGGEggPropertyDefaults.size)
  public var value: Size
  public let range = EGGEggPropertyRanges.sizeRange

  public init(_ defaultValue: Size = EGGEggPropertyDefaults.size) {
    value = defaultValue
  }

  public var wrappedValue: Temperature {
    get { value }
    set { value = min(max(range.lowerBound, newValue), range.upperBound) }
  }
}

@propertyWrapper
public struct EggBoilingPoint {
  @Cloud(EGGEggPropertyDefaultsKey.boilingPoint.rawValue, defaultValue: EGGEggPropertyDefaults.boilingPoint)
  public var wrappedValue: Temperature

  public init(_ defaultValue: Temperature = EGGEggPropertyDefaults.boilingPoint) {
    wrappedValue = defaultValue
  }
}
