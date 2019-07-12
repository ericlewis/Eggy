//
//  SliderProtocol.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation
import EggyKit

protocol SliderProtocol {
    var store: EGGTimerManager {get}
    var action: () -> Void {get}
}
