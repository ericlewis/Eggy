//
//  TimerProtocol.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

protocol TimerProtocol {
    var ticker: AnyPublisher<Date, Never> {get}
}

extension TimerProtocol {
    var ticker: AnyPublisher<Date, Never> {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return Timer.publish(every: 1.0, tolerance: 0.1, on: .main, in: .common)
                .eraseToAnyPublisher()
        }
        
        return delegate.ticker
    }
}
