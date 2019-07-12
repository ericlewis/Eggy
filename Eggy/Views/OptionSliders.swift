//
//  OptionsSliders.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import EggyKit

struct OptionSliders: View {

    // MARK: Private Properties

    @EnvironmentObject private var store: EGGTimerManager
    @EnvironmentObject private var settings: EGGSettingsContainer

    @State private var showingSizePicker = false
    @State private var showingDonenessPicker = false
    @State private var showingTempSheet = false

    let feedback = EGGFeedbackManager.shared

    // MARK: Setters

    func setSize(_ size: EggSize) {
        feedback.buzz(type: .select) {
            self.store.egg.size = size.rawValue
        }
    }

    func setDone(_ done: EggDoneness) {
        feedback.buzz(type: .select) {
            self.store.egg.doneness = done.rawValue
        }
    }

    func setTemp(_ prefersCelcius: Bool) {
       feedback.buzz(type: .select) {
            self.settings.current.prefersCelcius = prefersCelcius
        }
    }

    // MARK: Actions

    func toggleTempSheet() {
        feedback.buzz(type: .select) {
            self.$showingTempSheet.value.toggle()
        }
    }

    func toggleSizeSheet() {
        feedback.buzz(type: .select) {
            self.$showingSizePicker.value.toggle()
        }
    }

    func toggleDonenessSheet() {
        feedback.buzz(type: .select) {
            self.$showingDonenessPicker.value.toggle()
        }
    }

    func didSelect() {
        feedback.buzz(type: .select)
    }

    // MARK: Render

    var temperatureString: String {
      // TODO: fix me
      String(store.egg.temperature)
    }

    var body: some View {
        VStack {
            SliderContainer(temperatureString,
                            leadingLabel: "Fridge",
                            trailingLabel: "Room",
                            tappedLabel: toggleTempSheet,
                            tappedInfo: nil,
                            tappedLeadingLabel: { self.store.egg.temperature -= 1; self.didSelect() },
                            tappedTrailingLabel: { self.store.egg.temperature += 1; self.didSelect() }) {
                                TemperatureSlider(action: self.didSelect)
            }
            .presentation($showingTempSheet, actionSheet: ActionSheet.tempSheet(action: setTemp))
            SliderContainer(store.egg.size.sizeString,
                            leadingLabel: "Small",
                            trailingLabel: "Large",
                            tappedLabel: toggleSizeSheet,
                            tappedInfo: nil,
                            tappedLeadingLabel: { self.store.egg.size -= 0.01; self.didSelect() },
                            tappedTrailingLabel: { self.store.egg.size += 0.01; self.didSelect() }) {
                                SizeSlider(action: self.didSelect)
            }
            .presentation($showingSizePicker, actionSheet: ActionSheet.sizeSheet(action: setSize))
            SliderContainer(store.egg.doneness.donenessString,
                            leadingLabel: "Runny",
                            trailingLabel: "Hard",
                            tappedLabel: toggleDonenessSheet,
                            tappedInfo: nil,
                            tappedLeadingLabel: { self.store.egg.doneness -= 1; self.didSelect() },
                            tappedTrailingLabel: { self.store.egg.doneness += 1; self.didSelect() }) {
                                DonenessSlider(action: self.didSelect)
            }
            .presentation($showingDonenessPicker, actionSheet: ActionSheet.donenessSheet(action: setDone))
        }
    }
}

// MARK: Previews

#if DEBUG
struct OptionSliders_Previews: PreviewProvider {
    static var previews: some View {
        OptionSliders()
    }
}
#endif
