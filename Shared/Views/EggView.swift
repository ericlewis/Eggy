//
//  Egg.swift
//  Eggy
//
//  Created by Eric Lewis on 7/6/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct Egg : View {
  var opacity: Double = 1
  var remaining: Double = 1
  var duration: Double = 1
    var x: CGFloat
    var y: CGFloat
    var isDragging: Bool
  var showShadow = true
  private let scale = CGFloat(0.90)
  private let yolkScale = CGFloat(0.7)
  
  var body: some View {
    return GeometryReader { geometry in
      ZStack {
        Image("eggrock")
            .frame(width: geometry.size.width * self.scale, height: geometry.size.height * self.scale)
          .mask(CakeView(self.remaining, self.duration))
        .animation(self.isDragging ? .spring(mass: 1, stiffness: 55, damping: 10, initialVelocity: 0) : .spring(mass: 1, stiffness: 90, damping: 10, initialVelocity: 0))
      }
      .offset(
        x: self.x,
        y: self.y
      )
      .aspectRatio(1, contentMode: .fit)
    }
  }
}
