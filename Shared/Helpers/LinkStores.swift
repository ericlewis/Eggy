//
//  linkStores.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

extension View {
    func linkStores() -> some View {
        self
            .environmentObject(EggManager.shared)
            .environmentObject(SettingsManager.shared)
            .environmentObject(NavigationManager.shared)
    }
}