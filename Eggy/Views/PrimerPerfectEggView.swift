//
//  PrimerPerfectEggView.swift
//  Eggy
//
//  Created by Eric Lewis on 10/2/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import SFSafeSymbols

struct PrimerPerfectEggView: View {
    @EnvironmentObject var store: Store

    struct Item: View {
        var title: LocalizedStringKey
        var detail: LocalizedStringKey
        var symbol: SFSymbol

        var body: some View {
            HStack {
                Image(systemSymbol: symbol)
                .font(.title)
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding()
                VStack(alignment: .leading) {
                    Text(title).font(.headlineRounded)
                    .padding(.bottom, 2)
                    Text(detail).font(.subheadlineRounded).foregroundColor(.secondary)
                }
                Spacer()
            }
        }
    }
    
    var body: some View {
        VStack {
            Group {
                Item(title: "Find your perfect egg",
                     detail: "Using the 3 dedicated sliders for temperature, size, and the preferred doneness we calculate the cooking time.",
                     symbol: .sliderHorizontal3)
                .padding(.top)
                
                Item(title: "Prepare your station",
                     detail: "After choosing your egg settings, bring water to a rolling boil.",
                     symbol: .speedometer)
                
                Item(title: "Transfer eggs to water",
                     detail: "With the utmost care transfer your precious eggs to the boiling water.",
                     symbol: .exclamationmarkTriangle)
                
                Item(title: "Press start and relax",
                     detail: "Tap on the Egg or tap on the Start button to begin your timer.",
                     symbol: .playCircle)
                
                Item(title: "Enjoy your perfect egg",
                     detail: "Eggy will notify you when it is finished. Transfer the eggs to a cold water bath. Bon Appétit.",
                     symbol: .heart)
            }
            .padding(.bottom)
            
            Spacer()
            NiceButton(text: "Continue")
            .tappableWithFeedback {
                self.store.showPrimer = false
                self.store.firstVisit = false
            }
        }
        .padding()
        .padding(.trailing)
        .navigationBarTitle("How to use Eggy")
    }
}

struct PrimerPerfectEggView_Previews: PreviewProvider {
    static var previews: some View {
        PrimerPerfectEggView()
    }
}
