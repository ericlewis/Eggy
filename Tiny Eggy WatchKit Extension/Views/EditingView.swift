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
    
    func selectionChanged() {
        // no-op for now
    }
    
    // MARK: Render
    
    var body: some View {
        switch editingState {
        case .size:
            return AnyView(
                SizeSlider(action: selectionChanged)
                .tapAction(advance)
                    .digitalCrownRotation($store.doneness,
                                          from: store.eggDefaults.donenessRange.lowerBound,
                                          through: store.eggDefaults.donenessRange.upperBound,
                                          by: 1.0,
                                          sensitivity: .medium,
                                          isContinuous: false,
                                          isHapticFeedbackEnabled: true)
            )
        case .doneness:
            return AnyView(
                DonenessSlider(action: selectionChanged)
                    .digitalCrownRotation($store.doneness,
                                          from: store.eggDefaults.donenessRange.lowerBound,
                                          through: store.eggDefaults.donenessRange.upperBound,
                                          by: 1.0,
                                          sensitivity: .medium,
                                          isContinuous: false,
                                          isHapticFeedbackEnabled: true)
            )
        default:
            return AnyView(TemperatureSlider(action: selectionChanged)
                .digitalCrownRotation($store.doneness,
                                      from: store.eggDefaults.donenessRange.lowerBound,
                                      through: store.eggDefaults.donenessRange.upperBound,
                                      by: 1.0,
                                      sensitivity: .medium,
                                      isContinuous: false,
                                      isHapticFeedbackEnabled: true)
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
