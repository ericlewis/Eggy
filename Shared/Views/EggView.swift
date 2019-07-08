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
        Circle()
          .fill(Color.yellow)
          .frame(width: geometry.size.width * self.scale * self.yolkScale, height: geometry.size.height * self.scale * self.yolkScale)
        Circle()
          .fill(RadialGradient(gradient: Gradient(colors: [.yellow, .orange]), center: .center, startRadius: 1, endRadius: (geometry.size.width * self.scale * self.yolkScale) / 2))
          .frame(width: geometry.size.width * self.scale * self.yolkScale, height: geometry.size.height * self.scale * self.yolkScale)
          .opacity(self.opacity)
      }
      .aspectRatio(1, contentMode: .fit)
    }
  }
}

#if DEBUG
struct Egg_Previews : PreviewProvider {
    static var previews: some View {
      Group {
        Egg()
        Egg(opacity: 0.5)
        Egg(opacity: 0.0)
      }
    }
}
#endif
