
import Foundation

public protocol EGGEggProtocol : EGGEggPropertiesProtocol, EGGCookTimeCalculator {
    var cookTime: TimeInterval {get}
    var endDate: Date {get}
}

public extension EGGEggProtocol {
    var cookTime: TimeInterval {
        return calculateCookTime(withEgg: self)
    }
    
    var endDate: Date {
        return Date().addingTimeInterval(cookTime)
    }
}

public struct EGGEgg : EGGEggProtocol {
    public var temperature: Temperature
    public var doneness: Doneness
    public var size: Size
    public var boilingPoint: Temperature
    
    public init(temperature: Temperature = EGGPropertyDefaults.current.temperature, 
                doneness: Doneness = EGGPropertyDefaults.current.doneness, 
                size: Size = EGGPropertyDefaults.current.size, 
                boilingPoint: Temperature = EGGPropertyDefaults.current.boilingPoint) {
        self.temperature = temperature
        self.doneness = doneness
        self.size = size
        self.boilingPoint = boilingPoint
    }
}
