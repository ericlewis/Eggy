//
//  EggStateProtocol.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol EggStateProtocol : class, EggProtocol {
    var isRunning: Bool {get set}
    var endDate: Date {get set}
    var rawTimeRemaining: Double {get}
    var isFinished: Bool {get}

    func start()
    func stop()
    func toggleRunning()
    
    func stopped(needsConfirm: Bool)
    func started()
}

// MARK: Actions

extension EggStateProtocol {
    func start() {
        endDate = Date().addingTimeInterval(rawCookTime)
        started()
        isRunning = true
    }
    
    func stop() {
        stopped(needsConfirm: false)
        isRunning = false
    }
    
    func toggleRunning() {
        if isRunning {
            stopped(needsConfirm: true)
        } else {
            start()
        }
    }
}

// MARK: Properties
extension EggStateProtocol {
    
    var isFinished: Bool {
        endDate <= Date()
    }
    
    var rawTimeRemaining: Double {
        let remaining = max(0.0, endDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate)
        
        if remaining == 0.0 && isRunning {
            stop()
        }
        
        return remaining
    }
}
