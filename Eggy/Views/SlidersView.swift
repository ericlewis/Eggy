import SwiftUI
import SFSafeSymbols

struct SlidersView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var egg: EggStore

    func header(_ leading: LocalizedStringKey,
                _ trailing: LocalizedStringKey,
                increment: @escaping () -> Void,
                decrement: @escaping () -> Void) -> some View {
        HStack {
            Text(leading)
                .font(.captionRounded)
                .bold()
                .foregroundColor(.secondary)
                .tappableWithFeedback(action: decrement)
            Spacer()
            Text(trailing)
                .font(.captionRounded)
                .bold()
                .foregroundColor(.secondary)
                .tappableWithFeedback(action: increment)
        }
    }
    
    func footer(_ symbol: SFSymbol, _ value: String) -> some View {
        HStack {
            if symbol == .thermometer {
                Image(systemSymbol: symbol)
                    .padding(.horizontal, 3)
            } else {
                Image(systemSymbol: symbol)
            }
            Text(value + "       ")
                .font(.subheadlineRounded)
                .bold()
            Spacer(minLength: 0)
        }
        .padding(.bottom)
    }
    
    var sizeSymbol: SFSymbol {
        if store.size > 0.7 {
            return .lCircle
        }
        
        if store.size > 0.3 {
            return .mCircle
        }
        
        return .sCircle
    }
    
    var donenessSymbol: SFSymbol {
        if store.doneness > 0.7 {
            return .timelapse
        }
        
        if store.doneness > 0.3 {
            return .slowmo
        }
        
        return .rays
    }
    
    static let stride = 0.01
    private let feedback: UISelectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    private func selectionChanged(_ editingStarted: Bool) {
        feedback.prepare()
        
        if !editingStarted {
            self.feedback.selectionChanged()
            egg.saveContext()
        }
    }

    var body: some View {
        VStack(spacing: 5) {
            header("Fridge", "Room", increment: {
                self.store.temp += Self.stride
                self.egg.saveContext()
            }) {
                self.store.temp -= Self.stride
                self.egg.saveContext()
            }
            Slider(value: $store.temp, onEditingChanged: self.selectionChanged)
            footer(.thermometer, store.tempDetail)
            
            header("Small", "Large", increment: {
                self.store.size += Self.stride
                self.egg.saveContext()
            }) {
                self.store.size -= Self.stride
                self.egg.saveContext()
            }
            Slider(value: $store.size, onEditingChanged: self.selectionChanged)
            footer(sizeSymbol, store.sizeDetail)
            
            header("Soft", "Hard", increment: {
                self.store.doneness += Self.stride
                self.egg.saveContext()
            }) {
                self.store.doneness -= Self.stride
                self.egg.saveContext()
            }
            Slider(value: $store.doneness, onEditingChanged: self.selectionChanged)
            footer(donenessSymbol, store.donenessDetail)
        }
    }
}
