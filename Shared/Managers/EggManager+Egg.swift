//
//  EggManager+Egg.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol EggProtocol {
    var temp: Temperature {get set}
    var doneness: Doneness {get set}
    var size: Size {get set}
    var boilingPoint: BoilingPoint {get set}
    var isRunning: Bool {get set}
    var endDate: Date {get set}
}
