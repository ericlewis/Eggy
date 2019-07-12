import Foundation

public protocol EGGTimerManagerProtocolDelegate: AnyObject {
    func stateChanged(state: EGGTimerState, egg: EGGEgg)
}

public protocol EGGTimerManagerProtocol: EGGTimerProtocol, EGGTimerActions {
    var boilingPointManager: EGGBoilingPointManager {get set}
    var notificationScheduler: EGGNotificationScheduler {get set}
    var egg: EGGEgg {get set}
    var delegate: EGGTimerManagerProtocolDelegate? {get set}
}

@propertyWrapper
public struct TimerState {
    private static var key = "kTimerState"
    public var userDefaults: UserDefaults

    public init(_ initialValue: EGGTimerState = .stopped, userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        wrappedValue = initialValue
    }

    public var wrappedValue: EGGTimerState {
        get {
            EGGTimerState.init(rawValue: userDefaults.integer(forKey: TimerState.key)) ?? .stopped
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: TimerState.key)
        }
    }
}

public class EGGTimerManager: EasyBindableObject, EGGTimerManagerProtocol, EGGBoilingPointManagerDelegate {

    // MARK: Public Properties

    public weak var delegate: EGGTimerManagerProtocolDelegate?

    public var timer: Timer?

    public var ticked: (() -> Void)?

    @TimerState()
    public var state: EGGTimerState {
        didSet {
            switch state {
            case .running:
                notificationScheduler.schedule(cookTime: egg.cookTime)
            case .stopped:
                notificationScheduler.clear()
            case .finished:
                break
            }

            changed()
            delegate?.stateChanged(state: state, egg: egg)
        }
    }

    public var notificationScheduler: EGGNotificationScheduler

    public var egg: EGGEgg {
      didSet {
        changed()
      }
    }

    public var projectedEndDate: Date?

    public var boilingPointManager: EGGBoilingPointManager

    public init(egg: EGGEgg = EGGEgg(),
                state: EGGTimerState = .stopped,
                notificationScheduler: EGGNotificationScheduler = EGGNotificationScheduler(),
                boilingPointManager: EGGBoilingPointManager = EGGBoilingPointManager(),
                notification: EGGLocalNotification? = nil,
                timer: Timer? = nil) {
        self.notificationScheduler = notificationScheduler
        self.boilingPointManager = boilingPointManager
        self.egg = egg

        super.init()

        self.timer = timer ?? Timer.init(timeInterval: EGGTimerManager.interval, repeats: true, block: tick)
        self.state = state
        boilingPointManager.delegate = self
    }

    public func boilingPointUpdated(value: Temperature) {
        egg.boilingPoint = value
    }

    public func start() {
        start(withTriggerDate: egg.endDate)
    }

    public static var shared = EGGTimerManager()
}
