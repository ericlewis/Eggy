//
//  EggStack.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import EggyKit

protocol EggStackViewModelProtocol {
    var store: EGGTimerManager {get}
    var sizePercent: Length {get}
    var timeRemaining: Double {get}
    var donenessPercent: Double {get}
}

extension EggStackViewModelProtocol {
    var sizePercent: Length {
        let from = (EGGEggPropertyRanges.sizeRange.lowerBound, EGGEggPropertyRanges.sizeRange.upperBound)
        return store.state != .stopped ? 1.0 : Length(Rescale(from: from,
                                                       to: (0.9, 1)).rescale(store.egg.size))
    }

    var timeRemaining: Double {
        store.egg.cookTime
    }

    var donenessPercent: Double {
        let from = (EGGEggPropertyRanges.donenessRange.lowerBound, EGGEggPropertyRanges.donenessRange.upperBound)
        return Rescale(from: from, to: (1.0, 0.0)).rescale(store.egg.doneness)
    }
}

struct EggStack: View, EggStackViewModelProtocol {
    @EnvironmentObject var store: EGGTimerManager

    var x: CGFloat
    var y: CGFloat
    var isDragging: Bool

    var body: some View {
        ZStack {
            Egg(opacity: donenessPercent,
                remaining: timeRemaining,
                duration: store.egg.cookTime, x: x, y: y,
                isDragging: isDragging)
        }
        .scaleEffect(sizePercent)
            .transition(.moveDownAndScale)
            .animation(.spring())
    }
}

#if DEBUG
struct EggStack_Previews: PreviewProvider {
    static var previews: some View {
        EggStack(x: 1, y: 1, isDragging: false)
    }
}
#endif
