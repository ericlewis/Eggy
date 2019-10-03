import SwiftUI

struct NiceButton: View {
    var text: LocalizedStringKey
    
    var body: some View {
            HStack {
                Spacer()
                Text(text)
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
