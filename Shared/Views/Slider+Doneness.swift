//
//  Slider+Doneness.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import EggyKit

struct DonenessSlider: View, SliderProtocol {
    var action: () -> Void
    @EnvironmentObject var store: EGGTimerManager

    var body: some View {
        SliderControl(value: $store.egg.doneness,
                      from: EGGEggPropertyRanges.donenessRange.lowerBound,
                      through: EGGEggPropertyRanges.donenessRange.upperBound,
                      onEditingChanged: { _ in
            self.action()
        })
    }
}
