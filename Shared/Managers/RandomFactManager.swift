//
//  RandomFactManager.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import Foundation

class RandomFactManager: EasyBindableObject {
    static let shared = RandomFactManager()

    static let timeInterval = 8.0

    static var eggFacts = [
        "Eggs last 4-5 weeks from the packing date\n",
        "The average chicken lays 250-300 eggs per year",
        "A large egg contains 70 calories\n",
        "There are 3 grades of eggs: AA, A and B\n",
        "As a hen get older, her egg size increase\n",
        "Fresh eggs which are hard-boiled, are more difficult to peel",
        "Since 1997, egg consumption is on the rise.\n",
        "Egg yolks are one of the few foods that are a naturally good source of Vitamin D",
        "Brown eggs are typically more expensive than white eggs."
    ]

    var timer: Timer?
    var fact = RandomFactManager.eggFacts.randomElement()! {
        didSet {
            changed()
        }
    }

    override init() {
        super.init()
        setup()
    }

    private func setup() {
        timer = Timer.init(timeInterval: RandomFactManager.timeInterval, repeats: true, block: generate)
        RunLoop.current.add(timer!, forMode: .common)
    }

    private func generate(timer: Timer) {
        fact = RandomFactManager.eggFacts.randomElement()!
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }
}
