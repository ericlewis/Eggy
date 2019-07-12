import Foundation

public typealias Temperature = Double
public typealias Doneness = Double
public typealias Size = Double

public protocol EGGEggPropertiesProtocol {
  var temperature: Temperature {get set}
  var doneness: Doneness {get set}
  var size: Size {get set}
  var boilingPoint: Temperature {get set}
}
