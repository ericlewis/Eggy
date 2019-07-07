//
//  SliderContainer.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct SliderContainer<SliderView : View> : View {
    typealias Action = () -> Void
    typealias TappedLabel = Action
    typealias TappedInfo = Action?
    
    var label: String
    var leadingLabel: String
    var trailingLabel: String
    var tappedLabel: () -> Void
    var tappedInfo: (() -> Void)?
    var sliderProvider: () -> SliderView
    
    @EnvironmentObject var store: EggManager
    
    init(_ label: String,
         leadingLabel: String,
         trailingLabel: String,
         tappedLabel: @escaping TappedLabel,
         tappedInfo: TappedInfo,
         sliderProvider: @escaping () -> SliderView) {
        self.label = label
        self.leadingLabel = leadingLabel
        self.trailingLabel = trailingLabel
        self.tappedLabel = tappedLabel
        self.tappedInfo = tappedInfo
        self.sliderProvider = sliderProvider
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(leadingLabel)
                    .font(.caption)
                    .color(.secondary)
                Spacer()
                Text(trailingLabel)
                    .font(.caption)
                    .color(.secondary)
            }
            .padding(.vertical, 0)
            sliderProvider()
            HStack {
                Text(label)
                    .font(.headline)
                    .color(.primary)
                    .tapAction(tappedLabel)
                    .animation(.none)
                if tappedInfo != nil {
                    Button(action: tappedInfo!, label: {
                        Image(systemName: "questionmark.circle")
                    })
                }
            }
            .padding(.top, 0)
        }
        .padding(.horizontal)
            .padding(.vertical, 5)
    }
}
