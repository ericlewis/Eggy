import Foundation
import CoreMotion

public protocol EGGBoilingPointManagerDelegate {
    func boilingPointUpdated(value: Temperature)
}

public protocol EGGBoilingPointManagerProtocol : class {
    var isContinuous: Bool {get}
    var boilingPoint: Temperature {get set}
    var delegate: EGGBoilingPointManagerDelegate? {get}
    
    init(isContinuous: Bool, altimeterClient: EGGCMAltimeterProtocol)
    
    func startUpdates()
    func stopUpdates()
}

public class EGGBoilingPointManager : EGGBoilingPointManagerProtocol {
    public var altimeterClient: EGGCMAltimeterProtocol
    public var isContinuous: Bool
    public var delegate: EGGBoilingPointManagerDelegate?
    public var boilingPoint: Temperature = 100.0 // default is 100 celcius
    
    required public init(isContinuous: Bool = false, altimeterClient: EGGCMAltimeterProtocol = EGGCMAltimeterClient()) {
        self.isContinuous = isContinuous
        self.altimeterClient = altimeterClient
    }
    
    public func startUpdates() {
        if altimeterClient.isRelativeAltitudeAvailable {
            altimeterClient.startRelativeAltitudeUpdates(to: .main, withHandler: update)
        }
    }
    
    public func stopUpdates() {
        altimeterClient.stopRelativeAltitudeUpdates()
    }
    
    public func update(_ data: CMAltitudeData?, _ error: Error?) {
        if let rawPressure = data?.pressure {
            let pressure = Measurement(value: rawPressure.doubleValue, unit: UnitPressure.kilopascals).converted(to: .inchesOfMercury).value
            let res = Measurement(value: 49.161 * log(pressure) + 44, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value

            self.boilingPoint = res
            self.delegate?.boilingPointUpdated(value: res)
        }
        
        if !isContinuous {
            stopUpdates()
        }
    }
}
