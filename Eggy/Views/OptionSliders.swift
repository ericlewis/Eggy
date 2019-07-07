//
//  OptionsSliders.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct OptionSliders : View {
    @EnvironmentObject var store: EggManager
    @EnvironmentObject var settings: SettingsManager
    
    @State var showingSizePicker = false
    @State var showingDonenessPicker = false
    @State var showingTempSheet = false
    
    var tempLabelText: String {
        let x = Measurement(value: store.temp, unit: UnitTemperature.fahrenheit)
        return store.formatMeasurement(measurement: x, digits: 0)
    }
    
    func sizeSheet() -> ActionSheet {
        func setSize(_ size: EggSize) {
            self.store.feedback.select {
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
            self.store.feedback.select {
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
            self.store.feedback.select {
                self.settings.prefersCelcius = prefersCelcius
            }
        }
        
        return ActionSheet(title: Text("Temperature Display"), message: nil, buttons: [
            .default(Text("Fahrenheit")) { setDisplay(false) },
            .default(Text("Celcius")) { setDisplay(true) },
            .cancel(),
        ])
    }
    
    var body: some View {
        Group {
            VStack {
                SliderControl(tempLabelText,
                              leadingLabel: "Fridge",
                              trailingLabel: "Room",
                              from: store.eggDefaults.tempRange.lowerBound,
                              through: store.eggDefaults.tempRange.upperBound,
                              value: $store.temp) {
                                self.store.feedback.select {
                                    self.$showingTempSheet.value.toggle()
                                }
                }
                .presentation($showingTempSheet, actionSheet: tempSheet)
                Divider()
                SliderControl(store.size.sizeString,
                              leadingLabel: "Small",
                              trailingLabel: "Large",
                              from: store.eggDefaults.sizeRange.lowerBound,
                              through: store.eggDefaults.sizeRange.upperBound,
                              value: $store.size) {
                                self.store.feedback.select {
                                    self.$showingSizePicker.value.toggle()
                                }
                                
                }
                .presentation($showingSizePicker, actionSheet: sizeSheet)
                Divider()
                SliderControl(store.doneness.donenessString,
                              leadingLabel: "Runny",
                              trailingLabel: "Hard",
                              from: store.eggDefaults.donenessRange.lowerBound,
                              through: store.eggDefaults.donenessRange.upperBound,
                              value: $store.doneness) {
                                self.store.feedback.select {
                                    self.$showingDonenessPicker.value.toggle()
                                }
                                
                }
                .presentation($showingDonenessPicker, actionSheet: donenessSheet)
            }
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
