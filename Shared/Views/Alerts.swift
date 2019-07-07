//
//  Alerts.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

extension Alert {
    static func confirmResetAlert(reset: @escaping () -> Void) -> () -> Alert {
    {
        Alert(title: Text("Are you sure?"),
              message: Text("This will reset the timer"),
              primaryButton: .destructive(Text("Stop Timer"), onTrigger: reset),
              secondaryButton: .cancel())
        }
    }
}
