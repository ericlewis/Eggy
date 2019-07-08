//
//  AnyTransition+Transitions.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.move(edge: .bottom).combined(with: .opacity)
    }
  
  static var moveDownAndScale: AnyTransition {
      AnyTransition.move(edge: .bottom).combined(with: .scale())
    }
}
