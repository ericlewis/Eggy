import Foundation

struct EggTimer {
    static func calculate(temperature: Double, size: Double, doneness: Double, boilingPoint: Double) -> TimeInterval {
        pow(size.scaledSize(), 2/3) * Constants.heatCoefficient * log(Constants.yolkToWhiteRatio * (temperature.scaledTemp() - boilingPoint) / (doneness.scaledDoneness() - boilingPoint))
    }
}
