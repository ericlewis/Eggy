//
//  RootView.swift
//  Eggy Today
//
//  Created by Eric Lewis on 10/1/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @UserDefault(EggKey.endDate, defaultValue: .distantFuture) var endDate: Date
    @UserDefault(EggKey.doneness, defaultValue: 0) var doneness: Double
    @UserDefault(EggKey.size, defaultValue: 0) var size: Double
    @UserDefault(EggKey.temp, defaultValue: 0) var temp: Double

    var state: TimerState {
        UserDefaults.shared.value(forKey: EggKey.state, defaultValue: TimerState.idle)
    }
    
    var timeRemaining: TimeInterval {
        endDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
    }
    
    let runningFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.minute, .second]
        formatter.includesTimeRemainingPhrase = true
        var calendar = Calendar.current
        calendar.locale = Locale.current
        formatter.calendar = calendar
        
        return formatter
    }()
    
    var title: String {
        if state == .running {
            return timeRemaining >= 0 ? runningFormatter.string(from: timeRemaining) ?? String(timeRemaining) : "Egg is done"
        }
        
        return "No eggs cooking"
    }
        
    var body: some View {
        VStack {
            Text(title).font(.titleRounded).bold()
            if state == .running {
                Divider()
                HStack {
                    Spacer()
                    Text(temp.tempDetail).font(.titleRounded).bold()
                    Group {
                        Spacer()
                        Divider()
                        Spacer()
                    }
                    Text(size.sizeDetail).font(.titleRounded).bold()
                    Group {
                        Spacer()
                        Divider()
                        Spacer()
                    }
                    Text(doneness.donenessDetail).font(.titleRounded).bold()
                    Spacer()
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
