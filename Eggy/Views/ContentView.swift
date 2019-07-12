//
//  ContentView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct ContentView: View, TimerProtocol {

    // MARK: Private Properties

    @EnvironmentObject private var store: EggManager

    // MARK: Private Actions

    private func tick() {
        if self.store.isRunning {
            self.store.changed()
        }
    }

    // MARK: Render

    var body: some View {
        let dragGesture = DragGesture()
            .updating($dragState) { (value, state, _) in
                state = .dragging(translation: value.translation)
        }
        return VStack {
            EggStack(x: dragState.translation.width, y: dragState.translation.height, isDragging: dragState.isActive)
                .tapAction(store.toggleRunning)
                .gesture(dragGesture)
                .presentation($store.confirmResetTimer, actionSheet: ActionSheet.confirmResetTimer(action: store.stop))
            if !store.isRunning {
                OptionSliders()
                    .opacity(dragOpacity)
                    .transition(.opacity)
                    .onReceive(ticker, perform: tick)

            } else {
                RandomEggFactCyclerView()
                    .opacity(dragOpacity)
                    .transition(.slide)
                    .padding(.bottom)
                    .padding(.horizontal)
                ProjectedEndLabel()
                    .opacity(dragOpacity)
                    .transition(.moveAndFade)
            }
        }
        .animation(.basic())
    }

    // MARK: Draggin props

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
}

// MARK: Previews

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
