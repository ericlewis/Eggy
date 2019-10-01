import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    func tappable(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            self
        }
    }
    
    func tappableWithImpactFeedback(_ feedback: UIImpactFeedbackGenerator = .init(), action: @escaping () -> Void) -> some View {
        Button(action: {
            feedback.prepare()
            action()
            feedback.impactOccurred()
        }) {
            self
        }
    }
    
    func touchableWithImpactFeedback(_ feedback: UIImpactFeedbackGenerator = .init(), action: @escaping () -> Void) -> some View {
        self.onTapGesture {
            feedback.prepare()
            action()
            feedback.impactOccurred()
        }
    }
    
    func tappableWithFeedback(_ feedback: UISelectionFeedbackGenerator = .init(), action: @escaping () -> Void) -> some View {
        Button(action: {
            feedback.prepare()
            action()
            feedback.selectionChanged()
        }) {
            self
        }
    }
}
