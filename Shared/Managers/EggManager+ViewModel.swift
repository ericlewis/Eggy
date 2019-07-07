//
//  EggManager+ViewModel.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol ViewModelProtocol : RawProtocol {
    var endDateString: String {get}
    var cookTimeString: String {get}
    
    var isFinished: Bool {get}
}

extension ViewModelProtocol where Self: EggManager {
    var endDateString: String {
        dateFormatter.string(from: endDate)
    }
    
    var cookTimeString: String {
        if isRunning {
            return rawTimeRemaining.stringFromTimeInterval()
        } else {
            return rawCookTime.stringFromTimeInterval()
        }
    }
    
    var isFinished: Bool {
        endDate <= Date()
    }
}
