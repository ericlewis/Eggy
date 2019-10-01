//
//  DoneButton.swift
//  Eggy
//
//  Created by Eric Lewis on 9/29/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct DoneButton: View {
    var body: some View {
        Text("Done").font(.bodyRounded).bold().padding([.leading, .vertical])
    }
}

struct DoneButton_Previews: PreviewProvider {
    static var previews: some View {
        DoneButton()
    }
}
