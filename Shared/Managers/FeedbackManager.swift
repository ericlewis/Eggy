//
//  FeedbackManager.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

enum FeedbackType {
    case select
    case impact
    case lightImpact
    case success
    case failure
}

protocol FeedbackManagerActionsProtocol {
    typealias Action = (() -> Void)?

    func buzz(type: FeedbackType)
    func buzz(type: FeedbackType, action: Action)
}

#if os(watchOS)
struct FeedbackManager: FeedbackManagerActionsProtocol {
    func buzz(type: FeedbackType, action: Self.Action) {
        action?()
    }

    func buzz(type: FeedbackType) {
        buzz(type: type, action: nil)
    }
}
#else
protocol FeedbackManagerProtocol {
    var select: UISelectionFeedbackGenerator {get}
    var impact: UIImpactFeedbackGenerator {get}
    var notice: UINotificationFeedbackGenerator {get}
}

struct FeedbackManager: FeedbackManagerProtocol, FeedbackManagerActionsProtocol {

    var select = UISelectionFeedbackGenerator()
    var impact = UIImpactFeedbackGenerator(style: .heavy)
    var notice = UINotificationFeedbackGenerator()

    func buzz(type: FeedbackType) {
        buzz(type: type, action: nil)
    }

    func buzz(type: FeedbackType, action: Self.Action) {
        switch type {
        case .select:
            select.selectionChanged()
        case .success:
            notice.notificationOccurred(.success)
        case .failure:
            notice.notificationOccurred(.error)
        case .impact:
            impact.impactOccurred()
        case .lightImpact:
            impact.impactOccurred(withIntensity: 0.5)
        }

        action?()

        switch type {
        case .success, .failure:
            notice.prepare()
        case .impact, .lightImpact:
            impact.prepare()
        case .select:
            select.prepare()
        }

    }
}
#endif
