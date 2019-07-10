
import Foundation

public protocol EGGPropertyDefaultsProtocol : class, EGGEggPropertiesProtocol {}

public extension EGGPropertyDefaultsProtocol {
    var temperature: Temperature {
        set {}
        get { return 2}
    }
    
    var doneness: Doneness {
        set {}
        get {return 60}
    }
    
    var size: Size {
        set {}
        get {return 40}
    }
    
    var boilingPoint: Temperature {
        set {}
        get {return 100}
    }
}

public class EGGPropertyDefaults : EGGPropertyDefaultsProtocol {
    public static var current = EGGPropertyDefaults()
}
