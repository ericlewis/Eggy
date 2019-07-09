//
//  SliderProtocol.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol SliderProtocol {
    var store: EggManager {get}
    var action: () -> Void {get}
}
