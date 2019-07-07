//
//  EggManager+Formatters.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol FormattersProtocol {
    var dateFormatter: DateFormatter {get}
    var numberFormatter: NumberFormatter {get}

    func setupFormatters()
}

extension FormattersProtocol {
    func setupFormatters() {
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
    }
}
