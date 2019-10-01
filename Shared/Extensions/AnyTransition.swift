import SwiftUI

extension AnyTransition {
    static var moveBottomAndFade: AnyTransition {
        AnyTransition.move(edge: .bottom).combined(with: .opacity)
    }
    
    static var moveTrailingAndFade: AnyTransition {
        AnyTransition.move(edge: .trailing).combined(with: .opacity)
    }
    
    static var moveTopAndFade: AnyTransition {
        AnyTransition.move(edge: .top).combined(with: .opacity)
    }
}
