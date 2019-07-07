//
//  ContentView.swift
//  Tiny Eggy WatchKit Extension
//
//  Created by Eric Lewis on 7/7/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import Combine

enum EditingState {
  case size
  case doneness
  case temperature
}

struct ContentView : View {
  @ObjectBinding var store = EggManager.shared
  @State var editing = false {
    didSet {
      if editing == false {
        editingState = .temperature
      }
    }
  }
  
  @State var editingState = EditingState.temperature

  var ticker = Timer.publish(every: 1.0, tolerance: 0.1, on: .main, in: .common).autoconnect()
  
  var timeRemaining: Double {
    store.isRunning ? store.rawTimeRemaining : store.rawCookTime
  }
  
  var donenessPercent: Double {
    Rescale(from: (56.0, 85.0), to: (1.0, 0.0)).rescale(store.doneness)
  }
  
  var sizePercent: Length {
    store.isRunning ? 1.0 : Length(Rescale(from: (1.37, 2.8), to: (0.8, 1.0)).rescale(store.size))
  }
  
  func EditingBody() -> some View {
    switch editingState {
    case .size:
      return AnyView(Picker("", selection: $store.size) {
        Text("Small").tag(1.86)
        Text("Medium").tag(2.12)
        Text("Large").tag(2.37)
        Text("Extra Large").tag(2.6)
      }
      .tapAction(advance))
    case .doneness:
      #if os(tvOS)
      return AnyView(EmptyView())
      #else
      return AnyView(Slider(value: $store.doneness, from: 56, through: 85)
        .padding(.horizontal).digitalCrownRotation($store.doneness, from: 56, through: 85, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true))
      #endif
    default:
      return AnyView(Picker("", selection: $store.temp) {
        Text("Fridge").tag(37.0)
        Text("Room").tag(73.0)
      }
      .tapAction(advance))
    }
  }
  
  func advance() {
    if editingState == .doneness {
      editing = false
      store.start()
      return
    }
    
    switch editingState {
    case .doneness:
      editingState = .temperature
    case .size:
      editingState = . doneness
    case .temperature:
      editingState = .size
    }
  }
  
  var navTitle: String {
    if store.isRunning {
      return "Cookin'"
    }
    
    if !editing {
      return "Eggy"
    }
    
    switch editingState {
    case .doneness:
      return store.doneness.donenessString
    case .temperature:
      return "Temperature"
    case .size:
      return "Size"
    }
  }
  
  func alert() -> Alert {
    Alert(title: Text("Are you sure?"), message: Text("This will reset the timer"), primaryButton: .destructive(Text("Stop Timer")) {
      self.store.stop()
      }, secondaryButton: .cancel())
  }
  
  var body: some View {
    VStack {
      ZStack {
        Egg(opacity: donenessPercent)
          .opacity(0.5)
        Egg(opacity: donenessPercent, showShadow: false)
          .mask(CakeView(timeRemaining, store.rawCookTime))
      }
      .scaleEffect(sizePercent)
        .tapAction {
          if self.editing {
            self.advance()
          } else if self.store.isRunning {
            self.store.toggleRunning()
          } else {
            self.$editing.value = true
          }
      }
      if editing {
        EditingBody()
        .transition(.slide)
        .padding(.all, 0)
      }
      if store.isRunning && !editing {
        Text(store.cookTime)
          .padding(.all, 0)
          .font(.largeTitle)
          .animation(.none)
      }
      if !store.isRunning && !editing {
        Button("New Timer") {
          self.$editing.value.toggle()
        }
        .padding(.horizontal)
      }
    }
    .onReceive(ticker, perform: store.didChange.send)
    .animation(.basic())
    .navigationBarTitle(navTitle)
    .presentation($store.needsConfirmStop, alert: alert)
  }
}

class EggManager : BindableObject {
  #if canImport(CoreMotion)
  lazy var altimeter = CMAltimeter()
  #endif
  
  lazy var dateFormatter = DateFormatter()
  
  lazy var didChange = PassthroughSubject<Void, Never>()
  
  @UserDefault("temp", defaultValue: 37.0) var temp: Double
    {didSet {
      changed()
    }}
  
  @UserDefault("doneness", defaultValue: 56.0) var doneness: Double
    {didSet {changed()}}
  
  @UserDefault("size", defaultValue: 1.87) var size: Double
    {didSet {changed()}}
  
  @UserDefault("boilingPoint", defaultValue: 100.0) var boilingPoint: Double
    {didSet {changed()}}
  
  @UserDefault("isRunning", defaultValue: false) var isRunning: Bool {didSet {changed()}}
  
  @UserDefault("endDatee", defaultValue: Date()) var endDate: Date {didSet {changed()}}
  
  @UserDefault("prefersCelcius", defaultValue: false) var prefersCelcius: Bool {didSet {changed()}}
  
  var timerComplete = false {didSet{changed()}}
  var needsConfirmStop = false {didSet{changed()}}
  
  var isFinished: Bool {
    endDate <= Date()
  }
  
  func changed() {
    didChange.send()
  }
  
  var endDateString: String {
    dateFormatter.string(from: endDate)
  }
  
  init() {
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    
    startAltimeter()
  }
}

extension EggManager {
  func start() {
    endDate = Date().addingTimeInterval(rawCookTime)
    createNotification()
    self.isRunning = true
  }
  
  func stop() {
    deleteNotification()
    needsConfirmStop = false
    isRunning = false
  }
  
  func toggleRunning() {
    
    if isRunning {
      needsConfirmStop = true
    } else {
      start()
    }
    
  }
}

extension EggManager {
  var rawCookTime: Double {
    EggManager.calculateCookTime(t: temp, d: doneness, s: size, b: boilingPoint)
  }
  
  var rawTimeRemaining: Double {
    let remaining = max(0.0, endDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate)
    
    if remaining == 0.0 && isRunning {
      timerComplete = true
      stop()
    }
    
    return remaining
  }
  
  var cookTime: String {
    if isRunning {
      return rawTimeRemaining.stringFromTimeInterval()
    } else {
      return rawCookTime.stringFromTimeInterval()
    }
  }
}

extension EggManager {
  static func calculateCookTime(t: Double, d: Double, s: Double, b: Double) -> Double {
    let heatCoeff = 31.0
    let yolkWhiteRatio = 0.86
    
    let eggTemp = Measurement(value: t, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
    
    let weight = Measurement(value: s, unit: UnitMass.ounces).converted(to: .grams).value
    
    return pow(weight, 2/3) * heatCoeff * log(yolkWhiteRatio * (eggTemp - b) / (d - b))
  }
  
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
