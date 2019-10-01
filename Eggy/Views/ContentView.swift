import SwiftUI
import SFSafeSymbols

struct ContentView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var timer: TimerStore
    @State var offset: CGSize = .zero
    @State var reactorToggle = false
    
    let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.minute, .second]
        formatter.includesApproximationPhrase = true
        var calendar = Calendar.current
        calendar.locale = Locale.current
        formatter.calendar = calendar

        return formatter
    }()
    
    let runningFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.minute, .second]
        formatter.includesTimeRemainingPhrase = true
        var calendar = Calendar.current
        calendar.locale = Locale.current
        formatter.calendar = calendar
        
        return formatter
    }()
    
    var title: String {
        if timer.state == .running {
            return timer.timeRemaining >= 0 ? runningFormatter.string(from: timer.timeRemaining) ?? String(timer.timeRemaining) : "Egg is done"
        }
        
        return formatter.string(from: store.estimatedTime) ?? String(store.estimatedTime)
    }
    
    
    var animation: Animation {
        Animation.spring()
    }
    
    var body: some View {
        VStack {
            if timer.state == .running && offset == .zero {
                Text(timer.donenessDetail)
                .font(.titleRounded)
                .bold()
                .foregroundColor(.secondary)
                .transition(AnyTransition.moveBottomAndFade)
                .animation(.spring())
            }
            ZStack {
                EggView(offset: $offset)
                .touchableWithImpactFeedback(action: store.toggleTimer)
                .animation(.spring())
            }
            .animation(.spring())
            .zIndex(2)
            if timer.state != .running && offset == .zero {
                Group {
                    SlidersView()
                        .animation(self.animation)
                    StartButton()
                        .animation(self.animation)
                }
                .transition(AnyTransition.moveBottomAndFade)
                .zIndex(1)
            } else if timer.state == .running && offset == .zero {
                EndDateView()
                .tappableWithImpactFeedback(action: store.toggleTimer)
                .padding()
                .transition(AnyTransition.moveTopAndFade)
                .animation(.spring())
            }
        }
        .overlay(Text(String(reactorToggle ? "t" : "f")).hidden())
        .padding()
        .navigationBarTitle(title)
        .navigationBarItems(trailing: timer.state == .running ? nil : SettingsButton())
        .onReceive(timer.timer) { _ in
            if self.timer.state == .running {
                self.reactorToggle.toggle()
            }
        }
        .onAppear {
            if self.timer.state == .running {
                self.reactorToggle.toggle()
            }
        }
    }
}
