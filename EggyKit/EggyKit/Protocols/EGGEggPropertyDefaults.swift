import Foundation

public enum EGGEggPropertyDefaultsKey: String {
    case temperature
    case doneness
    case size
    case boilingPoint
}

public struct EGGEggPropertyDefaults {
  public static var temperature: Temperature = 2
  public static var doneness: Doneness = 60
  public static var size: Size = 40
  public static var boilingPoint: Temperature = 100
}

public struct EGGEggPropertyRanges {
  public static var temperatureRange: ClosedRange<Temperature> = 2.77...22.77
  public static var donenessRange: ClosedRange<Doneness> = 56...85
  public static var sizeRange: ClosedRange<Size> = 38.83...79.37
}
