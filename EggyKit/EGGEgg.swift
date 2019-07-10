
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

@propertyWrapper
public struct EggTemperature {
    @Cloud(EGGPropertyDefaultsKey.temperature.rawValue, defaultValue: EGGEggPropertyDefaults.temperature.rawValue)
    public var wrappedValue: Temperature
    
    public init(_ defaultValue: Temperature = EGGEggPropertyDefaults.temperature.rawValue) {
        wrappedValue = defaultValue
    }
}

@propertyWrapper
public struct EggDoneness {
    @Cloud(EGGPropertyDefaultsKey.doneness.rawValue, defaultValue: EGGEggPropertyDefaults.doneness.rawValue)
    public var wrappedValue: Doneness
    
    public init(_ defaultValue: Doneness = EGGEggPropertyDefaults.doneness.rawValue) {
        wrappedValue = defaultValue
    }
}

@propertyWrapper
public struct EggSize {
    @Cloud(EGGPropertyDefaultsKey.size.rawValue, defaultValue: EGGEggPropertyDefaults.size.rawValue)
    public var wrappedValue: Size
    
    public init(_ defaultValue: Size = EGGEggPropertyDefaults.size.rawValue) {
        wrappedValue = defaultValue
    }
}

@propertyWrapper
public struct EggBoilingPoint {
    @Cloud(EGGPropertyDefaultsKey.boilingPoint.rawValue, defaultValue: EGGEggPropertyDefaults.boilingPoint.rawValue)
    public var wrappedValue: Temperature
    
    public init(_ defaultValue: Temperature = EGGEggPropertyDefaults.boilingPoint.rawValue) {
        wrappedValue = defaultValue
    }
}

public struct EGGEgg : EGGEggProtocol {

    @EggTemperature()
    public var temperature: Temperature
    
    @EggDoneness()
    public var doneness: Doneness

    @EggSize()
    public var size: Size
    
    @EggBoilingPoint()
    public var boilingPoint: Temperature
    
    public init(temperature: Temperature = EGGEggPropertyDefaults.temperature.rawValue,
                doneness: Doneness = EGGEggPropertyDefaults.doneness.rawValue,
                size: Size = EGGEggPropertyDefaults.size.rawValue,
                boilingPoint: Temperature = EGGEggPropertyDefaults.boilingPoint.rawValue) {
        self.size = size
        self.boilingPoint = boilingPoint
        self.doneness = doneness
        self.temperature = temperature
    }
}
