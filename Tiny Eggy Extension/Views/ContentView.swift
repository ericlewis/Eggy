//
//  ContentView.swift
//  Tiny Eggy WatchKit Extension
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct ContentView : View, TimerProtocol {
    
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
    
    // MARK: Drag Gesture
    
    enum DragState {
        
        case inactive
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isActive: Bool {
            switch self {
            case .inactive:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    var dragOpacity: Double {
        dragState.isActive ? 0.0 : 1.0
    }
    
    @GestureState var dragState = DragState.inactive

    
    // MARK: Render
    
    var body: some View {
        let dragGesture = DragGesture()
            .updating($dragState) { (value, state, transaction) in
                state = .dragging(translation: value.translation)
        }
        return VStack {
            EggStack(x: dragState.translation.width, y: dragState.translation.height, isDragging: dragState.isActive)
                .tapAction(tappedEgg)
                .gesture(dragGesture)

            Group {
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
            }.opacity(dragOpacity)
        }
        .onReceive(ticker, perform: store.changed)
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

// MARK: Previews

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
