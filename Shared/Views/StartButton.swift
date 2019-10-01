import SwiftUI

struct StartButton: View {    
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
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.accentColor))
    }
}
