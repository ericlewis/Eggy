import Foundation

public protocol EGGCookTimeCalculator {
    func calculateCookTime(withEgg egg: EGGEgg) -> TimeInterval
}

public extension EGGCookTimeCalculator {
    func calculateCookTime<E: EGGEggProtocol>(withEgg egg: E) -> TimeInterval {
        let heatCoeff = 31.0
        let yolkWhiteRatio = 0.86
        return pow(egg.size, 2/3) * heatCoeff * log(yolkWhiteRatio * (egg.temperature - egg.boilingPoint) / (egg.doneness - egg.boilingPoint))
    }
}
