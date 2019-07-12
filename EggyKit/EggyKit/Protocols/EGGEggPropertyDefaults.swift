import Foundation

public enum EGGEggPropertyDefaultsKey: String {
    case temperature = "kTemperature"
    case doneness = "kDoneness"
    case size = "kSize"
    case boilingPoint = "kBoilingPoint"
}

public enum EGGEggPropertyDefaults: Double {
    case temperature = 2
    case doneness = 60
    case size = 40
    case boilingPoint = 100
}
