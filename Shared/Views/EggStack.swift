//
//  EggStack.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct EggStack : View {
    @EnvironmentObject var store: EggManager
    var x: CGFloat
    var y: CGFloat
    var isDragging: Bool
    
    var sizePercent: Length {
        store.isRunning ? 1.0 : Length(Rescale(from: (1.37, 2.8), to: (0.90, 1.0)).rescale(store.size))
    }
    
    var timeRemaining: Double {
        store.isRunning ? store.rawTimeRemaining : store.rawCookTime
    }
    
    var donenessPercent: Double {
        Rescale(from: (56.0, 85.0), to: (1.0, 0.0)).rescale(store.doneness)
    }
    
    var body: some View {
        ZStack {
            Egg(opacity: donenessPercent, remaining: timeRemaining, duration: store.rawCookTime, x: x, y: y, isDragging: isDragging)
        }
        .scaleEffect(sizePercent)
            .transition(.moveDownAndScale)
            .animation(.spring())
    }
}

#if DEBUG
struct EggStack_Previews : PreviewProvider {
    static var previews: some View {
        EggStack(x: 1, y: 1, isDragging: false)
    }
}
#endif
