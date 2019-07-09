//
//  Slider+Temperature.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct TemperatureSlider : View, SliderProtocol {
    var action: () -> Void
    @EnvironmentObject var store: EggManager
    
    var body: some View {
        SliderControl(value: $store.temp, from: store.eggDefaults.tempRange.lowerBound, through: store.eggDefaults.tempRange.upperBound, onEditingChanged: { _ in
            self.action()
        })
    }
}
