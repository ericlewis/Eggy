//
//  Slider+Doneness.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct DonenessSlider : View, SliderProtocol {
    var action: () -> Void
    @EnvironmentObject var store: EggManager
    
    var body: some View {
        SliderControl(value: $store.doneness, from: store.eggDefaults.donenessRange.lowerBound, through: store.eggDefaults.donenessRange.upperBound, onEditingChanged: { _ in
            self.action()
        })
    }
}
