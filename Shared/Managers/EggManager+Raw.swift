//
//  EggManager+Raw.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol RawProtocol {
    var rawCookTime: TimeInterval {get}
    var rawTimeRemaining: TimeInterval {get}
}

extension RawProtocol where Self: EggManager {
    var rawCookTime: Double {
        EggManager.calculateCookTime(t: temp, d: doneness, s: size, b: boilingPoint)
    }
    
    var rawTimeRemaining: Double {
        let remaining = max(0.0, endDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate)
        
        if remaining == 0.0 && isRunning {
            timerComplete = true
            stop()
        }
        
        return remaining
    }
    
    var endDateString: String {
        dateFormatter.string(from: endDate)
    }
}
