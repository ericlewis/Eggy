//
//  RootView.swift
//  Tiny Eggy WatchKit Extension
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct RootView : View {
    
    // MARK: Render
    
    var body: some View {
        ContentView()
            .environmentObject(EggManager.shared)
    }
}

// MARK: Previews

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
