//
//  CakeView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

public struct CakeView: View {
  var remaining: TimeInterval
  let duration: TimeInterval

  public init(_ remaining: TimeInterval, _ duration: TimeInterval) {
    self.remaining = remaining
    self.duration = duration
  }

  public var body: some View {
    GeometryReader { geometry in
      Path { path in
        let width: CGFloat = min(geometry.size.width, geometry.size.height)
        let height = width
        let middle = width / 2.0
        path.move(
          to: CGPoint(
            x: middle,
            y: height * 0.5
          )
        )
        let middlePoint = CGPoint(
          x: middle,
          y: height * 0.5
        )
        let rawProgress =  self.remaining/self.duration
        let progress = rawProgress < 0.000 ? 0.0 : (self.remaining/self.duration) * 100.0
        path.addArc(center: middlePoint, radius: width, startAngle: .degrees(-90), endAngle: .degrees(-90 + (3.6 * progress)), clockwise: false)
        path.addLine(to: middlePoint)
        path.closeSubpath()
      }
      .fill(Color.white)
        .aspectRatio(1, contentMode: .fit)
    }.padding(.all, 1)
  }
}

#if DEBUG
struct CakeView_Previews: PreviewProvider {
    static var previews: some View {
        CakeView(1.0, 2.0)
    }
}
#endif
