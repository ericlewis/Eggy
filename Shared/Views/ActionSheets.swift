//
//  ActionSheets.swift
//  Eggy
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import EggyKit

extension ActionSheet {
    static func confirmResetTimer(action: @escaping () -> Void) -> () -> ActionSheet { {
        ActionSheet(title: Text("Do you want to stop the timer?"), message: nil, buttons: [
            .destructive(Text("Stop Timer"), onTrigger: action),
            .cancel()
        ])
        }
    }

    static func sizeSheet(action: @escaping (EggSize) -> Void) -> () -> ActionSheet { {
        ActionSheet(title: Text("Egg Size"), message: nil, buttons: [
            .default(Text("Peewee")) { action(.peewee) },
            .default(Text("Small")) { action(.small) },
            .default(Text("Medium")) { action(.medium) },
            .default(Text("Large")) { action(.large) },
            .default(Text("Extra Large")) { action(.xlarge) },
            .cancel()
        ])
        }
    }

    static func donenessSheet(action: @escaping (EggDoneness) -> Void) -> () -> ActionSheet { {
        ActionSheet(title: Text("Desired Consistency"), message: nil, buttons: [
            .default(Text("Runny")) { action(.runny) },
            .default(Text("Soft")) { action(.soft) },
            .default(Text("Hard")) { action(.hard) },
            .cancel()
        ])
        }
    }

    static func tempSheet(action: @escaping (Bool) -> Void) -> () -> ActionSheet { {
        ActionSheet(title: Text("Temperature Display"), message: nil, buttons: [
            .default(Text("Fahrenheit (°F)")) { action(false) },
            .default(Text("Celcius (°C)")) { action(true) },
            .cancel()
        ])
        }
    }
}
