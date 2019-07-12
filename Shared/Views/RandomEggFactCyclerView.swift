//
//  RandomEggFactCyclerView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct RandomEggFactCyclerView: View {
    @ObjectBinding var randomFactManager = RandomFactManager.shared

    var body: some View {
        Text(randomFactManager.fact)
            .color(.secondary)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .transition(.opacity)
            .animation(.fluidSpring())
    }
}

#if DEBUG
struct RandomEggFactCyclerView_Previews: PreviewProvider {
    static var previews: some View {
        RandomEggFactCyclerView()
    }
}
#endif
