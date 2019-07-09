//
//  SliderContainer.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

extension Text {
    func sliderContainerValueStyle() -> some View {
        return self.font(.headline)
            .color(.primary)
            .animation(.none)
    }
    
    func sliderContainerLabelStyle() -> some View {
        return self.font(.caption)
            .color(.secondary)
    }
}

struct SliderContainer<SliderView : View> : View {
    
    // MARK: Types
    
    typealias Action = () -> Void
    typealias TappedLabel = Action
    typealias TappedInfo = Action?
    
    // MARK: Public Properties
    
    var label: String
    var leadingLabel: String
    var trailingLabel: String
    var tappedLabel: () -> Void
    var tappedInfo: (() -> Void)?
    var sliderProvider: () -> SliderView
    
    // MARK: Private Properties
    
    @EnvironmentObject private var store: EggManager
    
    // MARK: Initializer
    
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
    
    // MARK: Render
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(leadingLabel)
                    .sliderContainerLabelStyle()
                Spacer()
                Text(trailingLabel)
                    .sliderContainerLabelStyle()
            }
            .padding(.vertical, 0)
            sliderProvider()
            HStack {
                Text(label)
                    .sliderContainerValueStyle()
                    .tapAction(tappedLabel)
                if tappedInfo != nil {
                    InfoButton(action: tappedInfo!)
                }
            }
            .padding(.top, 0)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}
