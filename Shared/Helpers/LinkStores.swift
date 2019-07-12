//
//  linkStores.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import EggyKit

extension View {
    func linkStores() -> some View {
        self
            .environmentObject(EGGTimerManager.shared)
            .environmentObject(EGGSettingsContainer())
            .environmentObject(NavigationManager.shared)
    }
}
