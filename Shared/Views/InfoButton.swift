//
//  InfoButton.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct InfoButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Image(systemName: "questionmark.circle")
        })
    }
}

#if DEBUG
struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton(action: {})
    }
}
#endif
