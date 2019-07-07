//
//  EggManager+Actions.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol ActionsProtocol {
    func start()
    func stop()
    func toggleRunning()
}

extension ActionsProtocol where Self: EggManager {
    func start() {
        endDate = Date().addingTimeInterval(rawCookTime)
        createNotifications()
        self.isRunning = true
    }
    
    func stop() {
        feedback.notice(type: .error) {
            self.endDate = .distantFuture
            self.deleteNotifications()
            self.needsConfirmStop = false
            self.isRunning = false
        }
    }
    
    func toggleRunning() {
        if isRunning {
            feedback.impact {
                self.needsConfirmStop = true
            }
        } else {
            feedback.notice(type: .success) {
                self.start()
            }
        }
    }
}
