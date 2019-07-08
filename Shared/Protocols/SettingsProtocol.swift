//
//  SettingsProtocol.swift
//  Eggy
//
//  Created by Eric Lewis on 7/8/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol SettingsProtocol : class {
    var prefersGrams: Bool {get set}
    var prefersCelcius: Bool {get set}
    var preventAutoLock: Bool {get set}
    var thirtySecondWarning: Bool {get set}
    var enableAltimeter: Bool {get set}
    var appIconIsDark: Bool {get set}
}
