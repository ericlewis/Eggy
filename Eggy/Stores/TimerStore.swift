import SwiftUI
import Combine

class TimerStore: ObservableObject {
    private var userDefaults: UserDefaults
    private var notifications: NotificationStore
    private var settings: SettingsStore
    
    private var sideEffectsCancellable: AnyCancellable?
    private var persistentCancellable: AnyCancellable?
    private var timerCancellable: AnyCancellable?

    let timer = Timer.publish(every: Constants.timeInterval, on: .main, in: .common).autoconnect()

    @Published var state: TimerState = .idle
    var estimatedTime: TimeInterval = 0
    
    var timeRemaining: TimeInterval {
        endDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
    }
    
    var donenessDetail: String {
        if doneness > 0.7 {
            return "Hard"
        }
        
        if doneness > 0.3 {
            return "Soft"
        }
        
        return "Runny"
    }

    @UserDefault(EggKey.endDate, defaultValue: .distantFuture) var endDate: Date
    @UserDefault(EggKey.temp, defaultValue: 0) var temperature: Double
    @UserDefault(EggKey.size, defaultValue: 0) var size: Double
    @UserDefault(EggKey.doneness, defaultValue: 0) var doneness: Double
    @UserDefault(EggKey.boilingPoint, defaultValue: 100) var boilingPoint: Double
    
    init(userDefaults: UserDefaults = .shared, notifications: NotificationStore = .shared, settings: SettingsStore = .shared) {
        self.userDefaults = userDefaults
        self.notifications = notifications
        self.settings = settings
        
        initialize()
    }
    
    deinit {
        sideEffectsCancellable?.cancel()
        persistentCancellable?.cancel()
        timerCancellable?.cancel()
    }
    
    func start(with egg: Settings, boilingPoint: Double) {
        temperature = egg.temp
        size = egg.size
        doneness = egg.doneness
        estimatedTime = EggTimer.calculate(temperature: temperature, size: size, doneness: doneness, boilingPoint: boilingPoint)
        endDate = Date().addingTimeInterval(estimatedTime)
        state = .running
    }
    
    func stop() {
        state = .idle
    }
    
    private func initialize() {
        bind()
        hydrateState()
    }
    
    private func bind() {
        bindTimer()
        bindStateSideEffects()
        bindPersistence()
    }
    
    private func hydrateState() {
        state = userDefaults.value(forKey: EggKey.state, defaultValue: TimerState.idle)
    }
    
    private func bindStateSideEffects() {
        sideEffectsCancellable = $state
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: handleStateChange)
    }
    
    private func bindPersistence() {
        persistentCancellable = $state
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: persistState)
    }
    
    private func bindTimer() {
        timerCancellable = timer
            .receive(on: RunLoop.main)
            .sink(receiveValue: tick)
    }
    
    private func tick(_ date: Date) {
        if state == .running {
            objectWillChange.send()
        }
    }
    
    private func handleStateChange(_ state: TimerState) {
        switch state {
        case .idle:
            handleAutoLock(false)
            notifications.cancelNotifications()
        case .running:
            handleAutoLock(true)
            notifications.scheduleNotifications(endDate: endDate)
        }
    }
    
    private func handleAutoLock(_ disabled: Bool) {
        if settings.preventAutoLock == .active {
            UIApplication.shared.isIdleTimerDisabled = disabled
        }
    }
    
    private func persistState(_ state: TimerState) {
        userDefaults.set(state, forKey: EggKey.state)
    }
}
