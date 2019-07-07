//
//  SettingsView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct SettingsView : View {
    @EnvironmentObject var settings: SettingsManager
    @State var idk = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle("Prefers Celcius", isOn: $settings.prefersCelcius)
                    Toggle("Prevent Auto-Lock", isOn: $settings.preventAutoLock)
                    Toggle("30 Second Warning", isOn: $settings.thirtySecondWarning)
                    Toggle("Disable Altimeter", isOn: $settings.disableAltimeter)
                    Picker("Sound", selection: .constant(1)) {
                        Text("Boop").tag(0)
                        Text("Beep").tag(1)
                    }
                    Picker("App Icon", selection: .constant(0)) {
                        Text("Light").tag(0)
                        Text("Dark").tag(1)
                    }
                }
                Section {
                    Button("Help & FAQ", action: {})
                    Button("Share Eggy with friends", action: {})
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

#if DEBUG
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsManager.shared)
            .environment(\.colorScheme, .dark)
    }
}
#endif
