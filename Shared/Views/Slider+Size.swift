//
//  Slider+Size.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct SizeSlider : View, SliderProtocol {
    var action: () -> Void
    @EnvironmentObject var store: EggManager
    
    var body: some View {
        Slider(value: $store.size, from: store.eggDefaults.sizeRange.lowerBound, through: store.eggDefaults.sizeRange.upperBound, onEditingChanged: { _ in
            self.action()
        })
    }
}
