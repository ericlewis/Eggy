//
//  EGGFeedbackManager.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

public enum EEGFeedbackType {
    case select
    case impact
    case lightImpact
    case success
    case failure
}

public protocol EGGFeedbackManagerActionsProtocol {
    typealias Action = (() -> Void)?
    
    func buzz(type: EEGFeedbackType)
    func buzz(type: EEGFeedbackType, action: Action)
}

#if os(watchOS)
public struct EGGFeedbackManager : EGGFeedbackManagerActionsProtocol {
    public func buzz(type: FeedbackType, action: Self.Action) {
        action?()
    }
    
    public func buzz(type: FeedbackType) {
        buzz(type: type, action: nil)
    }
}
#else
protocol EGGFeedbackManagerProtocol {
    var select: UISelectionFeedbackGenerator {get}
    var impact: UIImpactFeedbackGenerator {get}
    var notice: UINotificationFeedbackGenerator {get}
}

public struct EGGFeedbackManager : EGGFeedbackManagerProtocol, EGGFeedbackManagerActionsProtocol {
    
    internal var select = UISelectionFeedbackGenerator()
    internal var impact = UIImpactFeedbackGenerator(style: .heavy)
    internal var notice = UINotificationFeedbackGenerator()
    
    public func buzz(type: EEGFeedbackType) {
        buzz(type: type, action: nil)
    }
    
    public func buzz(type: EEGFeedbackType, action: Self.Action) {
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
