//
//  NewTimerButton.swift
//  Tiny Eggy WatchKit Extension
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct NewTimerButton : View {
    
    // MARK: Public Properties
    
    @Binding var editing: Bool
    
    // MARK: Render

    var body: some View {
        Button("New Timer") {
            self.$editing.value.toggle()
        }
        .padding(.horizontal)
    }
}

// MARK: Preview

#if DEBUG
struct NewTimerButton_Previews : PreviewProvider {
    static var previews: some View {
        NewTimerButton(editing: .constant(true))
    }
}
#endif
