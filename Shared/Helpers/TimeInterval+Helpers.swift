//
//  TimeInterval+Helpers.swift
//  Eggy
//
//  Created by Eric Lewis on 7/6/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

public extension TimeInterval {
  func stringFromTimeInterval() -> String {
    
    // watchOS hack: Guard ourselves against overflows
    if self >= Double(Int.max) {
        return "00:00"
    }
    
    let time = max(0, Int(self))
    
    let seconds = time % 60
    let minutes = (time / 60) % 60
    let hours = (time / 3600)
    
    if (hours > 0) {
      return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
    
    // TODO: WE SHOULD DO ROUNDING FOR DISPLAY, round MS up for seconds or some shit
    return String(format: "%0.2d:%0.2d",minutes,seconds)
    
  }
}
