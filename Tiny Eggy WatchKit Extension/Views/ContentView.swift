//
//  ContentView.swift
//  Tiny Eggy WatchKit Extension
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    // MARK: Private Properties
    
    @EnvironmentObject private var store: EggManager
    
    @State private var editingState = EditingState.temperature
    @State private var editing = false {
        didSet {
            if editing == false {
                editingState = .temperature
            }
        }
    }
    
    // MARK: Actions
        
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
    
    // MARK: Render
    
    var body: some View {
        VStack {
            EggStack()
                .tapAction(tappedEgg)
            if editing {
                EditingView(editingState: $editingState, editing: $editing, advance: advance)
                    .padding(.horizontal)
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
    
    // MARK: View Model
    
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
            return store.temperatureString
        case .size:
            return store.size.sizeString
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
