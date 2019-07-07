//
//  EditingView.swift
//  Tiny Eggy WatchKit Extension
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct EditingView : View {
    // MARK: Public Properties
    
    @Binding var editingState: EditingState
    @Binding var editing: Bool
    var advance: () -> Void
    
    // MARK: Private Properties
    
    @EnvironmentObject private var store: EggManager
    
    // MARK: Actions
    
    
    // MARK: Render
    
    var body: some View {
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
}


#if DEBUG
struct EditingView_Previews : PreviewProvider {
    static var previews: some View {
        EditingView(editingState: .constant(.doneness), editing: .constant(true), advance: {})
    }
}
#endif
