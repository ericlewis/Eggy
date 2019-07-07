//
//  NavigationBar+Buttons.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct StartStopButton : View {
    @EnvironmentObject var store: EggManager
    
    var timerLabel: String {
        store.isRunning ? "Stop" : "Start"
    }
    
    var timerImage: String {
        store.isRunning ? "stop.fill" : "play.fill"
    }
    
    var body: some View {
        Button(action: store.toggleRunning) {
            HStack {
                Text(timerLabel)
                    .bold()
                Image(systemName: timerImage)
            }
        }
    }
}

struct SettingsButton : View {
    @EnvironmentObject var settings: SettingsManager
    
    var body: some View {
        PresentationLink(destination: SettingsView()
            .environmentObject(settings)) {
                Image(systemName: "slider.horizontal.3")
                    .imageScale(.large)
        }
    }
}

#if DEBUG
struct NavigationBar_Buttons_Previews : PreviewProvider {
    static var previews: some View {
        StartStopButton()
    }
}
#endif
