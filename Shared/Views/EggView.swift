//
//  Egg.swift
//  Eggy
//
//  Created by Eric Lewis on 7/6/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct Egg: View {
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
        Circle()
          .fill(Color.init(white: 0.9))
          .frame(width: geometry.size.width * self.scale, height: geometry.size.height * self.scale)
          .shadow(radius: 10)
        Circle()
          .fill(Color.white)
          .frame(width: geometry.size.width * self.scale, height: geometry.size.height * self.scale)
          .mask(CakeView(self.remaining, self.duration))
        Group {
            Circle()
                .fill(Color.yellow)
                .frame(width: geometry.size.width * self.scale * self.yolkScale,
                       height: geometry.size.height * self.scale * self.yolkScale)
            Circle()
                .fill(RadialGradient(gradient: Gradient(colors: [.yellow, .orange]),
                                     center: .center, startRadius: 1,
                                     endRadius: (geometry.size.width * self.scale * self.yolkScale) / 2))
                .frame(width: geometry.size.width * self.scale * self.yolkScale,
                       height: geometry.size.height * self.scale * self.yolkScale)
                .opacity(self.opacity)
        }
        .animation(self.isDragging ? .spring(mass: 1,
                                             stiffness: 55,
                                             damping: 10,
                                             initialVelocity: 0)
                                    : .spring(mass: 1,
                                              stiffness: 90,
                                              damping: 10,
                                              initialVelocity: 0))
      }
      .offset(
        x: self.x,
        y: self.y
      )
      .aspectRatio(1, contentMode: .fit)
    }
  }
}
