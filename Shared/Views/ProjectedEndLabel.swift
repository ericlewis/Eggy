//
//  ProjectedEndLabel.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import EggyKit

struct ProjectedEndLabel: View, FormattersProtocol {
  @EnvironmentObject var store: EGGTimerManager

  var endDateString: String {
    guard let endDate = store.projectedEndDate else {
      return ""
    }

    return Self.dateFormatter.string(from: endDate)
  }

  var body: some View {
    HStack {
      Image(systemName: "bell.fill")
        .font(.title)
        .imageScale(.small)
      Text(endDateString)
        .color(.secondary)
        .font(.title)
        .bold()
    }
  }
}

#if DEBUG
struct ProjectedEndLabel_Previews: PreviewProvider {
  static var previews: some View {
    ProjectedEndLabel()
  }
}
#endif
