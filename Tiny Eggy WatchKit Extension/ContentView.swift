//
//  ContentView.swift
//  Tiny Eggy WatchKit Extension
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine

enum EditingState {
    case size
    case doneness
    case temperature
}

struct ContentView : View {
    @EnvironmentObject var store: EggManager
    
    @State var editingState = EditingState.temperature
    @State var editing = false {
        didSet {
            if editing == false {
                editingState = .temperature
            }
        }
    }
        
    func tappedEgg() {
        if self.editing {
            self.advance()
        } else if self.store.isRunning {
            self.store.toggleRunning()
        } else {
            self.$editing.value = true
        }
    }
    
    func advance() {
        if editingState == .doneness {
            editing = false
            store.start()
            return
        }
        
        switch editingState {
        case .doneness:
            editingState = .temperature
        case .size:
            editingState = . doneness
        case .temperature:
            editingState = .size
        }
    }
    
    func EditingBody() -> some View {
        switch editingState {
        case .size:
            return AnyView(
                Picker("", selection: $store.size) {
                    Text("Small").tag(1.86)
                    Text("Medium").tag(2.12)
                    Text("Large").tag(2.37)
                    Text("Extra Large").tag(2.6)
                }
                .tapAction(advance)
            )
        case .doneness:
            return AnyView(
                DonenessSlider(action: {})
                    .padding(.horizontal)
                    .digitalCrownRotation($store.doneness,
                                          from: 56,
                                          through: 85,
                                          by: 1.0,
                                          sensitivity: .medium,
                                          isContinuous: false,
                                          isHapticFeedbackEnabled: true)
            )
        default:
            return AnyView(
                Picker("", selection: $store.temp) {
                    Text("Fridge").tag(37.0)
                    Text("Room").tag(73.0)
                }
                .tapAction(advance)
            )
        }
    }
    
    var body: some View {
        VStack {
            EggStack()
                .tapAction(tappedEgg)
            if editing {
                EditingBody()
                    .transition(.slide)
                    .padding(.all, 0)
            }
            if store.isRunning && !editing {
                Text(store.cookTimeString)
                    .padding(.all, 0)
                    .font(.largeTitle)
                    .animation(.none)
            }
            if !store.isRunning && !editing {
                NewTimerButton(editing: $editing)
            }
        }
        .onReceive(store.ticker, perform: store.didChange.send)
            .animation(.basic())
            .navigationBarTitle(navTitle)
            .presentation($store.confirmResetTimer, alert: Alert.confirmResetAlert(reset: store.stop))
    }
    
    var navTitle: String {
        if store.isRunning {
            return "Cookin'"
        }
        
        if !editing {
            return "Eggy"
        }
        
        switch editingState {
        case .doneness:
            return store.doneness.donenessString
        case .temperature:
            return "Temperature"
        case .size:
            return "Size"
        }
    }
    
}

struct NewTimerButton : View {
    @Binding var editing: Bool
    
    var body: some View {
        Button("New Timer") {
            self.$editing.value.toggle()
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
