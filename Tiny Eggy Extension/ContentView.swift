import SwiftUI
import WatchKit

extension View {
    func detailContainer() -> some View {
        self
            .allowsTightening(true)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.accentColor.opacity(0.20)))
    }
    
    func onTapFeedback(perform action: @escaping () -> Void) -> some View {
        self.onTapGesture {
            WKInterfaceDevice.current().play(.click)
            action()
        }
    }
}

enum Selectables {
    case none, temp, size, doneness
}

struct InnerView: View {
    @State var offset: CGSize = .zero
    
    @EnvironmentObject var timer: TimerStore
    @EnvironmentObject var store: Store
    
    let runningFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.minute, .second]
        formatter.includesTimeRemainingPhrase = false
        var calendar = Calendar.current
        calendar.locale = Locale.current
        formatter.calendar = calendar
        
        return formatter
    }()
    
    var title: String {
        timer.timeRemaining >= 0 ? runningFormatter.string(from: timer.timeRemaining) ?? String(timer.timeRemaining) : "Done"
    }
    
    func selectedTemp() {
        if selected == .temp {
            return selected = .none
        }
        
        selected = .temp
    }
    
    func selectedSize() {
        if selected == .size {
            return selected = .none
        }
        
        selected = .size
    }
    
    func selectedDoneness() {
        if selected == .doneness {
            return selected = .none
        }
        
        selected = .doneness
    }
    
    @State var selected: Selectables = .none
    
    var rotational: Binding<Double> {
        switch selected {
        case .size:
            return $store.size
        case .doneness:
            return $store.doneness
        case .temp:
            return $store.temp
        case .none:
            return .constant(0)
        }
    }
    
    let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.minute, .second]
        var calendar = Calendar.current
        calendar.locale = Locale.current
        formatter.calendar = calendar

        return formatter
    }()
    
    var body: some View {
        VStack {
            EggView(offset: $offset)
            .onTapFeedback(perform: {
                self.selected = .none
                self.store.toggleTimer()
            })
            .layoutPriority(1)
            if timer.state == .running && offset == .zero {
                GeometryReader { geo in
                    Text(self.title)
                    .font(.titleRounded)
                    .bold()
                    .frame(width: geo.frame(in: .global).width + 30)
                }
                .padding(.bottom, 20)
                .padding(.top, 10)
                .transition(.moveBottomAndFade)
                .animation(.spring())
            }
            if timer.state == .idle && offset == .zero {
                HStack {
                    Text(store.tempDetail.trimmingCharacters(in: .whitespacesAndNewlines)).bold()
                    .foregroundColor(selected == .temp ? .green : nil)
                    .onTapFeedback(perform: selectedTemp)
                    Divider()
                    Text(store.sizeDetail.trimmingCharacters(in: .whitespacesAndNewlines)).bold()
                    .foregroundColor(selected == .size ? .green : nil)
                    .onTapFeedback(perform: selectedSize)
                    Divider()
                    Text(store.doneness.donenessDetail).bold()
                    .focusable()
                        .digitalCrownRotation(rotational, from: 0.0, through: 1.0, by: 0.001, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: false)
                    .foregroundColor(selected == .doneness ? .green : nil)
                    .onTapFeedback(perform: selectedDoneness)
                }
                .font(.bodyRounded)
                .transition(.moveBottomAndFade)
                .animation(.spring())
                Button(action: {
                    WKInterfaceDevice.current().play(.click)
                    self.selected = .none
                    self.store.toggleTimer()
                    EggStore.shared.saveContext()
                }) {
                    Text("Start").font(.headlineRounded)
                }
                .padding([.horizontal, .bottom])
                .transition(.moveBottomAndFade)
                .animation(.spring())
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle(timer.state == .running ? "Eggy" : formatter.string(from: store.estimatedTime) ?? "Eggy")
    }
}

struct ContentView: View {
    
    var timer: TimerStore
    @ObservedObject var store: Store
    @ObservedObject var egg = EggStore.shared
    
    let coordinator: Coordinator
    
    init() {
        let t = TimerStore()
        timer = t
        let s = Store(timer: t, egg: EggStore.shared)
        store = s
        coordinator = Coordinator(EggStore.shared, s)
        egg.delegate = coordinator
    }
            
    var body: some View {
        InnerView()
        .environmentObject(store)
        .environmentObject(timer)
        .actionSheet(isPresented: $store.showCancelTimer, content: {
            ActionSheet(title: Text("Are you sure you want to stop this running timer?"), message: nil, buttons: [.destructive(Text("Stop Timer"), action: store.stopTimer), .cancel({
                self.store.showCancelTimer = false
            })])
        })
        .accentColor(.mixer(UIColor(red:0.97, green:0.62, blue:0.04, alpha:1.0), UIColor(red:0.90, green:0.73, blue:0.00, alpha:1.0), CGFloat(store.doneness)))
    }
    
    class Coordinator: EggStoreDelegate {
        
        var egg: EggStore
        var store: Store

        init(_ egg: EggStore, _ store: Store) {
            self.egg = egg
            self.store = store
        }
        
        func updated() {
            guard let size = egg.settings?.size, let doneness = egg.settings?.doneness, let temp = egg.settings?.temp else {
                return
            }
            
            if size != store.size {
                store.size = size
            }
            
            if doneness != store.doneness {
                store.doneness = doneness
            }
            
            if temp != store.temp {
                store.temp = temp
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
