//
//  OptionsSliders.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct OptionSliders : View {
    @EnvironmentObject private var store: EggManager
    @EnvironmentObject private var settings: SettingsManager
    
    @State private var showingSizePicker = false
    @State private var showingDonenessPicker = false
    @State private var showingTempSheet = false

    func sizeSheet() -> ActionSheet {
        func setSize(_ size: EggSize) {
            self.store.feedback.buzz(type: .select) {
                self.store.size = size.rawValue
            }
        }
        
        return ActionSheet(title: Text("Egg Size"), message: nil, buttons: [
            .default(Text("Peewee")) { setSize(.peewee) },
            .default(Text("Small")) { setSize(.small) },
            .default(Text("Medium")) { setSize(.medium) },
            .default(Text("Large")) { setSize(.large) },
            .default(Text("Extra Large")) { setSize(.xlarge) },
            .cancel(),
        ])
    }
    
    func donenessSheet() -> ActionSheet {
        func setDone(_ done: EggDoneness) {
            self.store.feedback.buzz(type: .select) {
                self.store.doneness = done.rawValue
            }
            
        }
        
        return ActionSheet(title: Text("Desired Consistency"), message: nil, buttons: [
            .default(Text("Runny")) { setDone(.runny) },
            .default(Text("Soft")) { setDone(.soft) },
            .default(Text("Hard")) { setDone(.hard) },
            .cancel(),
        ])
    }
    
    func tempSheet() -> ActionSheet {
        func setDisplay(_ prefersCelcius: Bool) {
            self.store.feedback.buzz(type: .select) {
                self.settings.prefersCelcius = prefersCelcius
            }
        }
        
        return ActionSheet(title: Text("Temperature Display"), message: nil, buttons: [
            .default(Text("Fahrenheit")) { setDisplay(false) },
            .default(Text("Celcius")) { setDisplay(true) },
            .cancel(),
        ])
    }
    
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
    
    var body: some View {
        VStack {
            SliderContainer(store.temperatureString,
                            leadingLabel: "Fridge",
                            trailingLabel: "Room", tappedLabel: toggleTempSheet, tappedInfo: nil) {
                                TemperatureSlider(action: self.didSelect)
            }
            .presentation($showingTempSheet, actionSheet: tempSheet)
            Divider()
            SliderContainer(store.size.sizeString,
                            leadingLabel: "Small",
                            trailingLabel: "Large", tappedLabel: toggleSizeSheet, tappedInfo: nil) {
                                SizeSlider(action: self.didSelect)
            }
            .presentation($showingSizePicker, actionSheet: sizeSheet)
            Divider()
            SliderContainer(store.doneness.donenessString,
                            leadingLabel: "Runny",
                            trailingLabel: "Hard", tappedLabel: toggleDonenessSheet, tappedInfo: nil) {
                                DonenessSlider(action: self.didSelect)
            }
            .presentation($showingDonenessPicker, actionSheet: donenessSheet)
        }
    }
}


#if DEBUG
struct OptionSliders_Previews : PreviewProvider {
    static var previews: some View {
        OptionSliders()
    }
}
#endif
