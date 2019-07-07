//
//  FeedbackManager.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

protocol FeedbackManagerProtocol {
    var select: UISelectionFeedbackGenerator {get}
    var impact: UIImpactFeedbackGenerator {get}
    var notice: UINotificationFeedbackGenerator {get}
}

protocol FeedbackManagerActionsProtocol {
    typealias Action = (() -> Void)?
    
    func select(action: Action)
    func impact(action: Action)
    func impact(intensity: CGFloat, action: Action)
    func notice(type: UINotificationFeedbackGenerator.FeedbackType, action: Action)
}

struct FeedbackManager : FeedbackManagerProtocol, FeedbackManagerActionsProtocol {
    
    var select = UISelectionFeedbackGenerator()
    var impact = UIImpactFeedbackGenerator(style: .heavy)
    var notice = UINotificationFeedbackGenerator()
    
    func select(action: Action) {
        select.selectionChanged()
        action?()
        select.prepare()
    }
    
    func impact(action: Action) {
        impact.impactOccurred()
        action?()
        impact.prepare()
    }
    
    func impact(intensity: CGFloat, action: Action) {
        impact.impactOccurred(withIntensity: intensity)
        action?()
        impact.prepare()
    }
    
    func notice(type: UINotificationFeedbackGenerator.FeedbackType, action: Action) {
        notice.notificationOccurred(type)
        action?()
        notice.prepare()
    }
}
