//
//  Enums.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

enum EggSize: Size {
    case peewee = 1.61
    case small = 1.86
    case medium = 2.12
    case large = 2.37
    case xlarge = 2.6
}

enum EggDoneness: Doneness {
    case runny = 60
    case soft = 71
    case hard = 80
}