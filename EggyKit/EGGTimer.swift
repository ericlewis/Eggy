
import Foundation

public enum EGGTimerState {
    case running
    case stopped
    case finished
    
    public var stringValue: String {
        return ""
    }
}

public protocol EGGTimerStateProtocol : class {
    var state: EGGTimerState {get set}
    var projectedEndDate: Date? {get set}
}

public extension EGGTimerStateProtocol {}

public protocol EGGTimerActionResume : EGGTimerStateProtocol {
    func start(withTriggerDate date: Date)
    func start(withCookTime: TimeInterval)
}

public extension EGGTimerActionResume {
    func start(withTriggerDate date: Date) {
        state = .running
        projectedEndDate = date
    } 
    
    func start(withCookTime cookTime: TimeInterval) {
        start(withTriggerDate: Date().addingTimeInterval(cookTime))
    }
}


public protocol EGGTimerActionStop : EGGTimerStateProtocol {
    func stop()
}

public extension EGGTimerActionStop {
    func stop() {
        state = .stopped
        // we purposesly do not clear out the projected end date.
    }
}

public protocol EGGTimerActions : EGGTimerActionStop, EGGTimerActionResume {}

public protocol EGGTimerProtocol {
    static var interval: TimeInterval {get} 
    var timer: Timer? { get }
    // Placeholder for SwiftUI's BindableObject
    func tick(_ timer: Timer)
}

public extension EGGTimerProtocol {
    static var interval: TimeInterval {
        return 1
    }
    
    func tick(_ timer: Timer) {
        // do ticky things, like emit events
    }
}
