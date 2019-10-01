import SwiftUI

struct StartButton: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
            HStack {
                Spacer()
                Text("Start")
                    .font(.headlineRounded)
                    .foregroundColor(.black)
                    .bold()
                    .opacity(0.8)
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .tappableWithImpactFeedback(action: store.toggleTimer)
    }
}
