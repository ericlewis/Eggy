import Foundation

public protocol EGGEggProtocol: EGGEggPropertiesProtocol, EGGCookTimeCalculator {
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

public struct EGGEgg: EGGEggProtocol {

    @EggTemperature()
    public var temperature: Temperature

    @EggDoneness()
    public var doneness: Doneness

    @EggSize()
    public var size: Size

    @EggBoilingPoint()
    public var boilingPoint: Temperature

    public init(temperature: Temperature = EGGEggPropertyDefaults.temperature,
                doneness: Doneness = EGGEggPropertyDefaults.doneness,
                size: Size = EGGEggPropertyDefaults.size,
                boilingPoint: Temperature = EGGEggPropertyDefaults.boilingPoint) {
        self.size = size
        self.boilingPoint = boilingPoint
        self.doneness = doneness
        self.temperature = temperature
    }
}
