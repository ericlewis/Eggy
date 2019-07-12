//
//  EasyBindableObject.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine

protocol EasyBindableObjectProtocol {
    var didChange: PassthroughSubject<Void, Never> {get}
    func changed()
}

public class EasyBindableObject: BindableObject, EasyBindableObjectProtocol {
    public lazy var didChange = PassthroughSubject<Void, Never>()
    public func changed() {
        didChange.send()
    }
}
