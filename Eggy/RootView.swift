//
//  ContentView.swift
//  Eggy
//
//  Created by Eric Lewis on 7/5/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView : View {
  @EnvironmentObject var store: EggManager
  
  var ticker = Timer.publish(every: 1.0, tolerance: 0.1, on: .main, in: .common).autoconnect()
  
  var title: String {
    if store.isRunning {
      return store.cookTime + " remaining"
    }
    
    return "Cook for " + store.cookTime
  }
  
  var timeRemaining: Double {
    store.isRunning ? store.rawTimeRemaining : store.rawCookTime
  }
  
  var donenessPercent: Double {
    Rescale(from: (56.0, 85.0), to: (1.0, 0.0)).rescale(store.doneness)
  }
  
  var body: some View {
    NavigationView {
      VStack {
        ZStack {
          Egg(opacity: donenessPercent)
            .opacity(0.6)
          Egg(opacity: donenessPercent)
            .mask(CakeView(timeRemaining, store.rawCookTime))
        }.tapAction(store.toggleRunning)
        if !store.isRunning {
          OptionSliders()
        } else {
          ProjectedEnd()
        }
      }
      .animation(.basic())
        .padding()
        .navigationBarTitle(title)
        .navigationBarItems(leading: SettingsButton(), trailing: StartStopButton())
    }.onReceive(ticker) {
      self.store.changed()
    }
  }
}

struct SettingsButton : View {
  var body: some View {
    PresentationLink(destination: Settings()) {
      Image(systemName: "slider.horizontal.3")
        .imageScale(.large)
    }
  }
}

struct Settings : View {
  var body: some View {
    NavigationView {
      Form {
        Section {
          Text("PlaceHolder")
        }
      }
      .navigationBarTitle("Settings")
    }
  }
}

public struct CakeView: View {
  var remaining: TimeInterval;
  let duration: TimeInterval;
  
  public init(_ remaining: TimeInterval, _ duration: TimeInterval) {
    self.remaining = remaining
    self.duration = duration
  }
  
  public var body: some View {
    GeometryReader { geometry in
      Path { path in
        let width: CGFloat = min(geometry.size.width, geometry.size.height)
        let height = width
        let middle = width / 2.0
        path.move(
          to: CGPoint(
            x: middle,
            y: height * 0.5
          )
        )
        let middlePoint = CGPoint(
          x: middle,
          y: height * 0.5
        )
        let rawProgress =  self.remaining/self.duration;
        let progress = rawProgress < 0.000 ? 0.0 : (self.remaining/self.duration) * 100.0
        path.addArc(center: middlePoint, radius: width * 0.43, startAngle: .degrees(-90), endAngle: .degrees(-90 + (3.6 * progress)), clockwise: false)
        path.addLine(to: middlePoint)
        path.closeSubpath()
      }
      .fill(Color.white)
        .aspectRatio(1, contentMode: .fit)
    }.padding(.all, 1)
  }
}

struct OptionSliders : View {
  @EnvironmentObject var store: EggManager
  
  @State var showingSizePicker = false
  @State var showingDonenessPicker = false
  
  // TODO: reuse or move this
  var tempLabelText: String {
    let x = Measurement(value: store.temp, unit: UnitTemperature.fahrenheit)
    let n = NumberFormatter()
    n.maximumFractionDigits = 0
    let m = MeasurementFormatter()
    m.numberFormatter = n
    return m.string(from: x)
  }
  
  func sizeSheet() -> ActionSheet {
    func setSize(_ size: Size) {
      store.size = size
    }
    
    return ActionSheet(title: Text("Size"), message: nil, buttons: [
      .default(Text("Peewee")) { setSize(1.61) },
      .default(Text("Small")) { setSize(1.86) },
      .default(Text("Medium")) { setSize(2.12) },
      .default(Text("Large")) { setSize(2.37) },
      .default(Text("Extra Large")) { setSize(2.6) },
      .cancel(),
    ])
  }
  
  func donenessSheet() -> ActionSheet {
    func setDone(_ done: Doneness) {
      store.doneness = done
    }
    i
    return ActionSheet(title: Text("Consistency"), message: nil, buttons: [
      .default(Text("Runny")) { setDone(60) },
      .default(Text("Soft")) { setDone(71) },
      .default(Text("Hard")) { setDone(80) },
      .cancel(),
    ])
  }
  
  var body: some View {
    Group {
      VStack {
        SliderControl(tempLabelText,
                      from: 37,
                      through: 73,
                      value: $store.temp) {}
          .padding(.top)
        SliderControl(store.size.sizeString,
                      from: 1.37,
                      through: 2.8,
                      value: $store.size) {
                        self.$showingSizePicker.value.toggle()
        }
        .presentation($showingSizePicker, actionSheet: sizeSheet)
        SliderControl(store.doneness.donenessString,
                      from: 56,
                      through: 85,
                      value: $store.doneness) {
                        self.$showingDonenessPicker.value.toggle()
        }
        .presentation($showingDonenessPicker, actionSheet: donenessSheet)
      }
    }
  }
}

struct StartStopButton : View {
  @EnvironmentObject var store: EggManager
  
  var timerLabel: String {
    store.isRunning ? "Stop" : "Start"
  }
  
  var timerImage: String {
    store.isRunning ? "stop.fill" : "play.fill"
  }
  
  var body: some View {
    Button(action: store.toggleRunning) {
      HStack {
        Text(timerLabel)
          .bold()
        Image(systemName: timerImage)
      }
    }
  }
}

struct ProjectedEnd : View {
  @EnvironmentObject var store: EggManager
  
  var body: some View {
    HStack {
      Image(systemName: "bell.fill")
        .font(.title)
        .foregroundColor(.orange)
      Text(store.endDateString)
        .color(.secondary)
        .font(.title)
        .bold()
    }
  }
}

struct SliderControl : View {
  var label: String
  var from: Double
  var through: Double
  var tappedLabel: () -> Void
  
  @Binding var value: Double
  
  init(_ label: String,
       from: Double,
       through: Double,
       value: Binding<Double>,
       tappedLabel: @escaping () -> Void) {
    self.label = label
    self.from = from
    self.through = through
    self.tappedLabel = tappedLabel
    $value = value
  }
  
  var body: some View {
    VStack(alignment: .trailing) {
      Slider(value: $value, from: from, through: through, onEditingChanged: { _ in
        
      })
      Text(label)
        .tapAction(tappedLabel)
        .animation(.none)
    }.padding(.bottom)
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
