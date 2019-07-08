//
//  SettingsView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct SettingsView : View {
    
    //MARK: Private Properties
    
    @EnvironmentObject private var settings: SettingsManager
    @State private var idk = false
    
    // MARK: Render
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle("Prevent Auto-Lock", isOn: $settings.preventAutoLock)
                    Toggle("30 Second Warning", isOn: $settings.thirtySecondWarning)
                    Toggle("Auto-update Boiling Point", isOn: $settings.enableAltimeter)
                    Picker("Weight Display", selection: $settings.prefersGrams) {
                        Text("Ounces (oz)").tag(false)
                        Text("Grams (g)").tag(true)
                    }
                    Picker("Temperature Display", selection: $settings.prefersCelcius) {
                        Text("Fahrenheit (°F)").tag(false)
                        Text("Celcius (°C)").tag(true)
                    }
                    if UIApplication.shared.supportsAlternateIcons {
                        Picker("App Icon", selection: $settings.appIconIsDark) {
                            Text("Light").tag(false)
                            Text("Dark").tag(true)
                        }
                    }
                    
                }
                Section {
                    Button("Help & FAQ", action: {})
                    Button("Share Eggy", action: {})
                    Button("Rate Eggy", action: {})
                    Button("Give Feedback", action: {})
                }
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("idk")
                    }
                }
                Section {
                    Button("Reset Timer Defaults", action: {})
                    Button("Reset All Settings", action: {})
                }
            }.listStyle(.grouped)
                .navigationBarTitle("Settings")
        }
    }
}

// MARK: Previews

#if DEBUG
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsManager.shared)
            .environment(\.colorScheme, .dark)
    }
}
#endif
