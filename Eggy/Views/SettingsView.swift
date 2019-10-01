import SwiftUI

extension Text {
    func titleStyle() -> some View {
        self.font(.bodyRounded)
    }
    
    func headerStyle() -> some View {
        self.font(.captionRounded).bold()
    }
}

struct SettingsView: View {
    @ObservedObject var store = SettingsStore.shared
    @EnvironmentObject var mainStore: Store
    @ObservedObject var notices = NotificationStore.shared
    
    private func tappedFAQ() {
        
    }
    
    private func tappedShare() {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.presentedViewController?.present(UIActivityViewController(activityItems: [URL(string: "https://twitter.com/ericlewis")!], applicationActivities: nil), animated: true, completion: nil)
        }
    }
    
    private func tappedRate() {
        
    }
    
    var General: some View {
        Section(header: Text("General").headerStyle()) {
            Toggle(isOn: $store.forceDarkMode) {
                Text("Always Dark Mode")
                    .titleStyle()
            }
        }
    }
    
    var Sensors: some View {
        Section(header: Text("Sensors").headerStyle()) {
            Toggle(isOn: $store.autoUpdateBoilingPoint) {
                Text("Auto-Update Boiling Point")
                    .titleStyle()
            }
            HStack {
                Text("Current Boiling Point")
                    .titleStyle()
                Spacer()
                Text(MeasurementFormatter.tempFormatter.string(from: Measurement(value: mainStore.boilingPoint, unit: UnitTemperature.celsius)))
                    .titleStyle().foregroundColor(.secondary)
            }
        }
    }
    
    var AutoLock: some View {
        Section(header: Text("Prevent Screen Dimming").headerStyle()) {
            Picker(selection: $store.preventAutoLock, label: Text("Prevent Auto-Lock")) {
                Text(AutoLockState.always.title)
                    .titleStyle()
                    .tag(AutoLockState.always)
                
                Text(AutoLockState.active.title)
                    .titleStyle()
                    .tag(AutoLockState.active)
                
                Text(AutoLockState.never.title)
                    .titleStyle()
                    .tag(AutoLockState.never)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    @State var showingTemperatureDisplayPicker = false
    @State var showingWeightDisplayPicker = false
    
    var Measurements: some View {
        Section(header: Text("Measurements").headerStyle()) {
            NavigationLink(destination: Form {
                HStack {
                    Text(WeightDisplay.grams.title)
                        .titleStyle()
                        .foregroundColor(.primary)
                    Spacer()
                    if store.weightDisplay == .grams {
                        Image(systemSymbol: .checkmark)
                            .foregroundColor(.accentColor)
                    }
                }
                .tappableWithFeedback {
                    self.store.weightDisplay = .grams
                    self.showingWeightDisplayPicker = false
                }
                HStack {
                    Text(WeightDisplay.ounces.title)
                        .titleStyle()
                        .foregroundColor(.primary)
                    Spacer()
                    if store.weightDisplay == .ounces {
                        Image(systemSymbol: .checkmark)
                            .foregroundColor(.accentColor)
                    }
                }
                .tappableWithFeedback {
                    self.store.weightDisplay = .ounces
                    self.showingWeightDisplayPicker = false
                }
            }.navigationBarTitle("Weight Display"), isActive: $showingWeightDisplayPicker) {
                HStack {
                    Text("Weight Display")
                        .titleStyle()
                    Spacer()
                    Text(store.weightDisplay.title)
                        .titleStyle()
                        .foregroundColor(.secondary)
                }
            }
            NavigationLink(destination: Form {
                HStack {
                    Text(TemperatureDisplay.celcius.title)
                        .titleStyle()
                        .foregroundColor(.primary)
                    Spacer()
                    if store.temperatureDisplay == TemperatureDisplay.celcius {
                        Image(systemSymbol: .checkmark)
                            .foregroundColor(.accentColor)
                    }
                }
                .tappableWithFeedback {
                    self.store.temperatureDisplay = .celcius
                    self.showingTemperatureDisplayPicker = false
                }
                HStack {
                    Text(TemperatureDisplay.fahrenheit.title)
                        .titleStyle()
                        .foregroundColor(.primary)
                    Spacer()
                    if store.temperatureDisplay == TemperatureDisplay.fahrenheit {
                        Image(systemSymbol: .checkmark)
                            .foregroundColor(.accentColor)
                    }
                }
                .tappableWithFeedback {
                    self.store.temperatureDisplay = .fahrenheit
                    self.showingTemperatureDisplayPicker = false
                }
            }.navigationBarTitle("Temperature Display"), isActive: $showingTemperatureDisplayPicker) {
                HStack {
                    Text("Temperature Display")
                        .titleStyle()
                    Spacer()
                    Text(store.temperatureDisplay.title)
                        .titleStyle()
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    var Notifications: some View {
        Section(header: Text("Notifications").headerStyle()) {
            Toggle(isOn: $notices.warning) {
                Text("30 Second Warning")
                    .titleStyle()
            }
        }
        .disabled(!notices.enabled)
    }
    
    var Misc: some View {
        Section(header: Text("More Information").headerStyle(), footer: Text("Version \(SettingsStore.version)").font(.footnoteRounded)) {
            HStack {
                Text("Help & FAQs")
                .titleStyle()
                .foregroundColor(.primary)
                Spacer()
                Image(systemSymbol: .questionmarkCircle)
                .foregroundColor(.accentColor)
            }
            .tappable(action: tappedFAQ)
            HStack {
              Text("Share Eggy")
                .titleStyle()
                .foregroundColor(.primary)
                Spacer()
                Image(systemSymbol: .squareAndArrowUp)
                .foregroundColor(.accentColor)
                .padding(.trailing, 1)
            }
            .tappable(action: tappedShare)
            HStack {
            Text("Rate Egg")
                .titleStyle()
                .foregroundColor(.primary)
                Spacer()
                Image(systemSymbol: .heart)
                .foregroundColor(.accentColor)
            }
            .tappable(action: tappedRate)
        }
    }
    
    var body: some View {
        Form {
            General
            AutoLock
            Measurements
            Notifications
            Sensors
            Misc
        }
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}
