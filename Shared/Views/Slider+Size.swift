//
//  Slider+Size.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import EggyKit

struct SizeSlider: View, SliderProtocol {
    var action: () -> Void
    @EnvironmentObject var store: EGGTimerManager

    var body: some View {
        SliderControl(value: $store.egg.size,
                      from: EGGEggPropertyRanges.sizeRange.lowerBound,
                      through: EGGEggPropertyRanges.sizeRange.upperBound,
                      onEditingChanged: { _ in
            self.action()
        })
    }
}
