//
//  EggManager+Formatters.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation
import EggyKit

protocol FormattersProtocol {
    static var dateFormatter: DateFormatter {get}
    static var numberFormatter: NumberFormatter {get}
    static var measurementFormatter: MeasurementFormatter {get}

    func setupFormatters()
    func formatMeasurement(measurement: Measurement<Unit>, digits: Int) -> String
}

struct Formatters: FormattersProtocol {
    static var measurementFormatter = MeasurementFormatter()
    static var dateFormatter = DateFormatter()
    static var numberFormatter = NumberFormatter()

}

extension FormattersProtocol {
    static var measurementFormatter: MeasurementFormatter {
        Formatters.measurementFormatter
    }

    static var dateFormatter: DateFormatter {
        Formatters.dateFormatter
    }

    static var numberFormatter: NumberFormatter {
        Formatters.numberFormatter
    }

    func setupFormatters() {
        Self.dateFormatter.dateStyle = .none
        Self.dateFormatter.timeStyle = .short
    }

    func formatMeasurement<T: Unit>(measurement: Measurement<T>, digits: Int) -> String {
        Self.numberFormatter.maximumFractionDigits = digits
        Self.measurementFormatter.numberFormatter = Self.numberFormatter
        Self.measurementFormatter.unitStyle = .medium
        if EGGSettingsContainer().current.prefersCelcius {
            Self.measurementFormatter.locale = .init(identifier: "en_GB")
        } else {
            Self.measurementFormatter.locale = .autoupdatingCurrent
        }
        return Self.measurementFormatter.string(from: measurement)
    }
}
