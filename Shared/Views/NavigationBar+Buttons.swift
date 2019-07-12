//
//  NavigationBar+Buttons.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct StartStopButton: View {
    @EnvironmentObject private var store: EggManager

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

struct SettingsButton: View, NavigationProtocol {
    @EnvironmentObject internal var navigation: NavigationManager

    private func toggleSettings() {
        navigation.showSettings.toggle()
    }

    var body: some View {
        Button(action: toggleSettings) {
                Image(systemName: "slider.horizontal.3")
                    .imageScale(.large)
        }
    }
}

struct DoneButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text("Done")
                .color(.yellow)
                .bold()
        }
    }
}

#if DEBUG
struct NavigationBar_Buttons_Previews: PreviewProvider {
    static var previews: some View {
        StartStopButton()
    }
}
#endif
