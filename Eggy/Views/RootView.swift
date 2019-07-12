//
//  ContentView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/5/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine

struct RootView: View, NavigationProtocol {

    // MARK: Private Properties

    @EnvironmentObject internal var navigation: NavigationManager
    @EnvironmentObject var store: EggManager

    // MARK: Render

    var settingsModal: Modal? {
        func dismiss() {
            navigation.showSettings = false
        }

        return navigation.showSettings ? Modal.settings(onDismiss: dismiss) : nil
    }

    var body: some View {
        NavigationView {
            ContentView()
                .navigationBarTitle(store.navBarTitleString)
                .navigationBarItems(leading: SettingsButton(), trailing: StartStopButton())
        }
        .navigationViewStyle(.stack)
        .foregroundColor(.yellow)
        .presentation(settingsModal)
    }
}

// MARK: Previews

#if DEBUG
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
