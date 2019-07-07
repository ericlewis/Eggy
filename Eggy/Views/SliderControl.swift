//
//  SliderControl.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct SliderControl : View {
    var label: String
    var from: Double
    var through: Double
    var leadingLabel: String
    var trailingLabel: String
    var tappedLabel: () -> Void
    var tappedInfo: (() -> Void)?
    
    @Binding var value: Double
    @EnvironmentObject var store: EggManager
    
    init(_ label: String,
         leadingLabel: String,
         trailingLabel: String,
         from: Double,
         through: Double,
         value: Binding<Double>,
         tappedLabel: @escaping () -> Void) {
        self.label = label
        self.leadingLabel = leadingLabel
        self.trailingLabel = trailingLabel
        self.from = from
        self.through = through
        self.tappedLabel = tappedLabel
        $value = value
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
            Slider(value: $value, from: from, through: through, onEditingChanged: { _ in
                self.store.feedback.select(action: nil)
            })
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
