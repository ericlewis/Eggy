import SwiftUI
import Combine

class Store: ObservableObject {
    var timer: TimerStore
    var egg: EggStore

    @Published var estimatedTime: TimeInterval = 0
    
    @Published var temp: Double {
        didSet {
            let new = min(max(0, temp), 1)
            if temp != new {
                temp = new
            }
        }
    }
    @Published var size: Double {
        didSet {
            let new = min(max(0, size), 1)
            if size != new {
                size = new
            }
        }
    }
    @Published var doneness: Double {
        didSet {
            let new = min(max(0, doneness), 1)
            if doneness != new {
                doneness = new
            }
        }
    }
    @Published var boilingPoint: Double
    
    @Published var showCancelTimer: Bool

    private lazy var altimeter = AltimeterProxy()
    private let userDefaults: UserDefaults
    
    func toggleTimer() {
        switch timer.state {
        case .idle:
            startTimer()
        case .running:
            if timer.timeRemaining >= 0 {
                requestStopTimer()
            } else {
                timer.stop()
            }
        }
    }
    
    func startTimer() {
        if timer.state == .running {
            return
        }
        
        timer.start(with: egg.settings!, boilingPoint: boilingPoint)
    }
    
    func requestStopTimer() {
        if timer.state == .idle {
            return
        }
        
        if timer.timeRemaining >= 0 {
            showCancelTimer.toggle()
        } else {
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer.stop()
    }
    
    init(timer: TimerStore, egg: EggStore, userDefaults: UserDefaults = .shared) {
        self.timer = timer
        self.egg = egg
        self.userDefaults = userDefaults

        boilingPoint = userDefaults.value(forKey: EggKey.boilingPoint, defaultValue: 100.0)

        temp = egg.settings?.temp ?? 0.2
        size = egg.settings?.size ?? 0.5
        doneness = egg.settings?.doneness ?? 1.0

        showCancelTimer = false
        
        #if os(watchOS)
        #else
        if SettingsStore.shared.preventAutoLock == .always {
            UIApplication.shared.isIdleTimerDisabled = true
        } else {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        #endif

        bind()
    }

    private func bind() {
        bindCalculator()
        bindCoreDataBridge()
        bindAltimeter()
    }
}

extension Store {
    private func bindCalculator() {
        let _ = Publishers.CombineLatest4($temp, $size, $doneness, $boilingPoint)
            .receive(on: RunLoop.main)
            .map { temp, size, doneness, boilingPoint in
                pow(size.scaledSize(), 2/3) * Constants.heatCoefficient * log(Constants.yolkToWhiteRatio * (temp.scaledTemp() - boilingPoint) / (doneness.scaledDoneness() - boilingPoint))
        }
        .assign(to: \.estimatedTime, on: self)
    }
}

extension Store {
    private func bindAltimeter() {
        let _ = altimeter.publisher
            .receive(on: RunLoop.main)
            .map {
                $0?.pressure ?? 100
        }
        .map {
            let pressure = Measurement(value: Double(truncating: $0), unit: UnitPressure.kilopascals).converted(to: .inchesOfMercury).value
            return Measurement(value: 49.161 * log(pressure) + 44, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
        }
        .catch { _ in
            Just(Constants.boilingPoint)
        }
        .assign(to: \.boilingPoint, on: self)
    }
}

extension Store {
    private func bindCoreDataBridge() {
        let _ = $temp
            .receive(on: RunLoop.main)
            .sink {
                self.setEggStoreValue($0, .temp)
        }
        
        let _ = $size
            .receive(on: RunLoop.main)
            .sink {
                self.setEggStoreValue($0, .size)
        }
        
        let _ = $doneness
            .receive(on: RunLoop.main)
            .sink {
                self.setEggStoreValue($0, .doneness)
        }
        
        // we persist to user default cause we may have different values in different areas
        // should remain local to the device itself if possible.
        let _ = $boilingPoint
            .receive(on: RunLoop.main)
            .sink { bp in
                DispatchQueue.global(qos: .background).async {
                    UserDefaults.standard.set(bp, forKey: EggKey.boilingPoint)
                }
        }
    }
    
    private func setEggStoreValue(_ value: Double, _ key: EggKey) {
        switch key {
        case .doneness:
            egg.settings?.doneness = value
        case .size:
            egg.settings?.size = value
        case .temp:
            egg.settings?.temp = value
        default:
            break
        }
    }
}
