//
//  EggManager+ViewModel.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol ViewModelProtocol : EggStateProtocol, FormattersProtocol {
    var navBarTitleString: String {get}
    var endDateString: String {get}
    var cookTimeString: String {get}
    var temperatureString: String {get}
}

extension ViewModelProtocol {
    var navBarTitleString: String {
        isRunning ? "\(cookTimeString) remaining" : "Cook for \(cookTimeString)"
    }
    
    var endDateString: String {
        Self.dateFormatter.string(from: endDate)
    }
    
    var cookTimeString: String {
        if isRunning {
            return rawTimeRemaining.stringFromTimeInterval()
        } else {
            return rawCookTime.stringFromTimeInterval()
        }
    }
    
    var temperatureString: String {
        let x = Measurement(value: temp, unit: UnitTemperature.fahrenheit)
        return formatMeasurement(measurement: x, digits: 0)
    }
}
