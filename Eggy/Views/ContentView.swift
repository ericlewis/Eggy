//
//  ContentView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @EnvironmentObject var store: EggManager
    
    var body: some View {
        VStack {
            EggStack()
                .tapAction(store.toggleRunning)
            if !store.isRunning {
                OptionSliders()
                    .transition(.opacity)
                    .onReceive(store.ticker, perform: store.changed)
            } else {
                ProjectedEndLabel()
                    .transition(.moveAndFade)
            }
        }
        .animation(.basic())
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
