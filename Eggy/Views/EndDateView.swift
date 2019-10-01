import SwiftUI

struct EndDateView: View {
    @EnvironmentObject var timer: TimerStore
    @EnvironmentObject var store: Store

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }()
    
    var body: some View {
        HStack {
            Image(systemSymbol: .bellFill)
            .imageScale(.large)
            .foregroundColor(Color.mixer(.systemOrange, .systemYellow, CGFloat(self.timer.state == .running ? self.timer.doneness : self.store.doneness)))
            Text(dateFormatter.string(from: timer.endDate) + " " )
            .font(.titleRounded)
            .bold()
            .foregroundColor(.secondary)
        }
    }
}
