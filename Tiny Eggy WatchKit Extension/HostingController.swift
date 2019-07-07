//
//  HostingController.swift
//  Tiny Eggy WatchKit Extension
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController : WKHostingController<AnyView> {
    override var body: AnyView {
        AnyView(ContentView()
            .environmentObject(EggManager.shared))
    }
}
