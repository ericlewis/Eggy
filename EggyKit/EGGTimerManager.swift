import Foundation

public protocol EGGTimerManagerProtocolDelegate {
    func stateChanged(state: EGGTimerState)
}

public protocol EGGTimerManagerProtocol : EGGTimerProtocol, EGGTimerActions {
    var boilingPointManager: EGGBoilingPointManager {get set}
    var notification: EGGLocalNotification {get set}
    var egg: EGGEgg {get set}
    var delegate: EGGTimerManagerProtocolDelegate? {get set}
}

public class EGGTimerManager : EGGTimerManagerProtocol, EGGBoilingPointManagerDelegate {
    
    // MARK: Public Properties
    
    public var delegate: EGGTimerManagerProtocolDelegate?
    
    public var timer: Timer?
    
    public var state: EGGTimerState {
        didSet {
            switch state {
            case .running:
                notification.fire(triggerOffset: egg.cookTime)
            case .stopped:
                notification.delete()
            case .finished:
                break
            }
            delegate?.stateChanged(state: state)
        }
    }
    
    public var notification: EGGLocalNotification
    
    public var egg: EGGEgg
    
    public var projectedEndDate: Date?
    
    public var boilingPointManager: EGGBoilingPointManager
    
    public init(egg: EGGEgg = EGGEgg(),
                state: EGGTimerState = .stopped,
                boilingPointManager: EGGBoilingPointManager = EGGBoilingPointManager(),
                notification: EGGLocalNotification? = nil,
                timer: Timer? = nil) {
        self.state = state
        self.egg = egg
        self.notification = EGGLocalNotification(title: "Your egg is finished!", message: nil)
        self.boilingPointManager = boilingPointManager
        self.timer = timer ?? Timer.init(timeInterval: EGGTimerManager.interval, repeats: true, block: tick)
        
        setupBoilingPointManager()
    }
    
    private func setupBoilingPointManager() {
        boilingPointManager.delegate = self
    }
    
    public func boilingPointUpdated(value: Temperature) {
        egg.boilingPoint = value
    }
    
    public func start() {
        start(withTriggerDate: egg.endDate)
    }
}
