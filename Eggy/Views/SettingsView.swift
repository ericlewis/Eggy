//
//  SettingsView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import EggyKit

struct SettingsViewContainer: View {
    var body: some View {
        NavigationView {
            SettingsView()
        }
    }
}

struct SettingsView: View, NavigationProtocol {

    // MARK: Private Properties

    @EnvironmentObject private var store: EGGTimerManager
    @EnvironmentObject private var settings: EGGSettingsContainer
    @EnvironmentObject internal var navigation: NavigationManager

    @State private var idk = false

    // MARK: Actions

    func dismiss() {
        navigation.showSettings = false
    }

    // MARK: Render

    var body: some View {
        Form {
            Section {
                Toggle("Prevent Auto-Lock", isOn: $settings.current.preventAutoLock)
                Toggle("30 Second Warning", isOn: $settings.current.warningNotificationEnabled)
                Toggle("Auto-update Boiling Point", isOn: $settings.current.enableAltimeter)
                Picker("Weight Display", selection: $settings.current.prefersGrams) {
                    Text("Ounces (oz)").tag(false)
                    Text("Grams (g)").tag(true)
                }
                Picker("Temperature Display", selection: $settings.current.prefersCelcius) {
                    Text("Fahrenheit (°F)").tag(false)
                    Text("Celcius (°C)").tag(true)
                }
                if UIApplication.shared.supportsAlternateIcons {
                    Picker("App Icon", selection: $settings.current.appIconIsDark) {
                        Text("Light").tag(false)
                        Text("Dark").tag(true)
                    }
                }

            }
            Section {
                Button("Help & FAQ", action: {})
                Button("Share Eggy", action: {})
                Button("Rate Eggy", action: {})
            }
            Section {
                HStack {
                    Text("Version")
                    Spacer()
                    Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "None")
                }
            }
            Section {
                Button("Reset Egg", action: settings.reset)
            }
            Section {
                Button("Reset Settings", action: settings.reset)
            }
            .listStyle(.grouped)
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing: DoneButton(action: dismiss))
        }
    }
}

// MARK: Previews

#if DEBUG
// swiftlint:disable type_name
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(EGGSettingsContainer())
            .environment(\.colorScheme, .dark)
    }
}
#endif
