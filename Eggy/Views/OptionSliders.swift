//
//  OptionsSliders.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct OptionSliders : View {
    
    // MARK: Private Properties

    @EnvironmentObject private var store: EggManager
    @EnvironmentObject private var settings: SettingsManager
    
    @State private var showingSizePicker = false
    @State private var showingDonenessPicker = false
    @State private var showingTempSheet = false

    // MARK: Setters

    func setSize(_ size: EggSize) {
        self.store.feedback.buzz(type: .select) {
            self.store.size = size.rawValue
        }
    }
    
    func setDone(_ done: EggDoneness) {
        self.store.feedback.buzz(type: .select) {
            self.store.doneness = done.rawValue
        }
    }
    
    func setTemp(_ prefersCelcius: Bool) {
        self.store.feedback.buzz(type: .select) {
            self.settings.prefersCelcius = prefersCelcius
        }
    }
    
    // MARK: Actions

    func toggleTempSheet() {
        store.feedback.buzz(type: .select) {
            self.$showingTempSheet.value.toggle()
        }
    }
    
    func toggleSizeSheet() {
        store.feedback.buzz(type: .select) {
            self.$showingSizePicker.value.toggle()
        }
    }
    
    func toggleDonenessSheet() {
        store.feedback.buzz(type: .select) {
            self.$showingDonenessPicker.value.toggle()
        }
    }
    
    func didSelect() {
        store.feedback.buzz(type: .select)
    }
    
    // MARK: Render
    
    var body: some View {
        VStack {
            SliderContainer(store.temperatureString,
                            leadingLabel: "Fridge",
                            trailingLabel: "Room",
                            tappedLabel: toggleTempSheet,
                            tappedInfo: nil,
                            tappedLeadingLabel: { self.store.temp -= 1; self.didSelect() },
                            tappedTrailingLabel: { self.store.temp += 1; self.didSelect() }) {
                                TemperatureSlider(action: self.didSelect)
            }
            .presentation($showingTempSheet, actionSheet: ActionSheet.tempSheet(action: setTemp))
            SliderContainer(store.size.sizeString,
                            leadingLabel: "Small",
                            trailingLabel: "Large",
                            tappedLabel: toggleSizeSheet,
                            tappedInfo: nil,
                            tappedLeadingLabel: { self.store.size -= 0.01; self.didSelect() },
                            tappedTrailingLabel: { self.store.size += 0.01; self.didSelect() }) {
                                SizeSlider(action: self.didSelect)
            }
            .presentation($showingSizePicker, actionSheet: ActionSheet.sizeSheet(action: setSize))
            SliderContainer(store.doneness.donenessString,
                            leadingLabel: "Runny",
                            trailingLabel: "Hard",
                            tappedLabel: toggleDonenessSheet,
                            tappedInfo: nil,
                            tappedLeadingLabel: { self.store.doneness -= 1; self.didSelect() },
                            tappedTrailingLabel: { self.store.doneness += 1; self.didSelect() }) {
                                DonenessSlider(action: self.didSelect)
            }
            .presentation($showingDonenessPicker, actionSheet: ActionSheet.donenessSheet(action: setDone))
        }
    }
}

// MARK: Previews

#if DEBUG
struct OptionSliders_Previews : PreviewProvider {
    static var previews: some View {
        OptionSliders()
    }
}
#endif
