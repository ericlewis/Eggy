//
//  Modals.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

extension Modal {
    static func settings(onDismiss: (() -> Void)?) -> Modal {
        Modal(SettingsViewContainer().linkStores(), onDismiss: onDismiss)
    }
}
