//
//  Double+Helpers.swift
//  Eggy
//
//  Created by Eric Lewis on 7/6/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

extension Double {
  var sizeString: String {
    var sizeString = "Small"
    
    if self < 1.62 {
      sizeString = "Peewee"
    } else if self < 1.87 {
      sizeString = "Small"
    } else if self < 2.13 {
      sizeString = "Medium"
    } else if self < 2.38 {
      sizeString = "Large"
    } else {
      sizeString = "Extra Large"
    }
    
    return String(format: "\(sizeString) (%.2foz)", self)
  }
  
  var donenessString: String {
    if self < 62 {
      return "Runny"
    } else if self < 76 {
      return "Soft"
    } else {
      return "Hard"
    }
  }
}
