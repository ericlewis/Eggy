//
//  Egg.swift
//  Eggy
//
//  Created by Eric Lewis on 7/6/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct Egg : View {
  private let scale = CGFloat(0.90)
  private let yolkScale = CGFloat(0.7)
  
  var body: some View {
    return GeometryReader { geometry in
      ZStack {
        Circle()
          .fill(Color.white)
          .frame(width: geometry.size.width * self.scale, height: geometry.size.height * self.scale)
          .shadow(radius: 25)
        Circle()
          .fill(Color.yellow)
          .frame(width: geometry.size.width * self.scale * self.yolkScale, height: geometry.size.height * self.scale * self.yolkScale)
          .brightness(0.09)
        Circle()
          .fill(Color.yellow)
          .frame(width: geometry.size.width * self.scale * self.yolkScale * self.yolkScale, height: geometry.size.height * self.scale * self.yolkScale * self.yolkScale)
          .opacity(1)
      }
      .aspectRatio(1, contentMode: .fit)
    }
  }
}

#if DEBUG
struct Egg_Previews : PreviewProvider {
    static var previews: some View {
        Egg()
    }
}
#endif
