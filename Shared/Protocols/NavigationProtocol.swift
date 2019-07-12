//
//  NavigationProtocol.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

protocol NavigationProtocol {
    var navigation: NavigationManager {get}
}

protocol NavigationManagerProtocol: AnyObject {
    static var shared: NavigationManager {get}
    var showSettings: Bool {get set}
}

class NavigationManager: EasyBindableObject, NavigationManagerProtocol {
    static var shared = NavigationManager()

    var showSettings: Bool = false {
        didSet {
            changed()
        }
    }
}
