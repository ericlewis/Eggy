//
//  EGGSingletonProtocol.swift
//  EggyKit
//
//  Created by Eric Lewis on 7/12/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

public protocol EGGSingletonProtocol {
  static var shared: Self {get}
}
