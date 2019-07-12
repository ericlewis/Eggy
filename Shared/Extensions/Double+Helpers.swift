//
//  Double+Helpers.swift
//  Eggy
//
//  Created by Eric Lewis on 7/6/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation
import EggyKit

struct Rescale<Type: BinaryFloatingPoint> {
  typealias RescaleDomain = (lowerBound: Type, upperBound: Type)

  var fromDomain: RescaleDomain
  var toDomain: RescaleDomain

  init(from: RescaleDomain, to: RescaleDomain) {
    self.fromDomain = from
    self.toDomain = to
  }

  func interpolate(_ x: Type ) -> Type {
    return self.toDomain.lowerBound * (1 - x) + self.toDomain.upperBound * x
  }

  func uninterpolate(_ x: Type) -> Type {
    let res = (self.fromDomain.upperBound - self.fromDomain.lowerBound)
    let b = res != 0 ? res : 1 / self.fromDomain.upperBound

    return (x - self.fromDomain.lowerBound) / b
  }

  func rescale(_ x: Type ) -> Type {
    return interpolate( uninterpolate(x) )
  }
}

extension Double {
  var sizeString: String {
    var sizeString = "Small"

    if self < 1.62 {
      sizeString = "Peewee"
    } else if self < 1.87 {
      sizeString = "Small"
    } else if self < 2.13 {
      sizeString = "Medium"
    } else if self < 2.38 {
      sizeString = "Large"
    } else {
      sizeString = "Extra Large"
    }

    let formatter = MeasurementFormatter()
    formatter.unitOptions = .providedUnit
    formatter.numberFormatter.maximumFractionDigits = 2
    formatter.unitStyle = .medium

    let measurement = Measurement(value: self, unit: UnitMass.ounces)
    let converted = measurement.converted(to: EGGSettingsContainer().current.prefersGrams ? .grams : .ounces)
    let s = formatter.string(from: converted)

    return String(format: "\(sizeString) (\(s))")
  }

  var donenessString: String {
    if self < 62 {
      return "Runny"
    } else if self < 76 {
      return "Soft"
    } else {
      return "Hard"
    }
  }
}
