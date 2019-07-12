//
//  Slider+Temperature.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import EggyKit

struct TemperatureSlider: View, SliderProtocol {
    var action: () -> Void
    @EnvironmentObject var store: EGGTimerManager

    var body: some View {
        SliderControl(value: $store.egg.temperature,
                      from: EGGEggPropertyRanges.temperatureRange.lowerBound,
                      through: EGGEggPropertyRanges.temperatureRange.upperBound,
                      onEditingChanged: { _ in
            self.action()
        })
    }
}
