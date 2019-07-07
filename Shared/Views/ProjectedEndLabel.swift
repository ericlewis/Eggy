//
//  ProjectedEndLabel.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct ProjectedEndLabel : View {
    @EnvironmentObject var store: EggManager
    
    var body: some View {
        HStack {
            Image(systemName: "bell.fill")
                .font(.title)
                .imageScale(.small)
            Text(store.endDateString)
                .color(.secondary)
                .font(.title)
                .bold()
        }
    }
}

#if DEBUG
struct ProjectedEndLabel_Previews : PreviewProvider {
    static var previews: some View {
        ProjectedEndLabel()
    }
}
#endif
