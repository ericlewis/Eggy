//
//  ContentView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/5/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine

struct RootView : View {
    @EnvironmentObject var store: EggManager

    @Environment(\.sizeCategory) var sizeClass: ContentSizeCategory
    
    var body: some View {
        NavigationView {
            ContentView()
                .presentation($store.confirmResetTimer, alert: Alert.confirmResetAlert(reset: store.stop))
            .navigationBarTitle(store.navBarTitleString)
            .navigationBarItems(leading: SettingsButton(), trailing: StartStopButton())
        }
        .navigationViewStyle(.stack)
        .foregroundColor(.orange)
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
