import Foundation
import CoreMotion

public protocol EGGBoilingPointManagerDelegate {
    func boilingPointUpdated(value: Temperature)
}

public protocol EGGBoilingPointManagerProtocol : class {
    var isContinuous: Bool {get}
    var delegate: EGGBoilingPointManagerDelegate? {get}
    
    init(isContinuous: Bool, altimeterClient: EGGCMAAltimeterProtocol)
    
    func startUpdates()
    func stopUpdates()
}

public class EGGBoilingPointManager : EGGBoilingPointManagerProtocol {
    public var altimeterClient: EGGCMAAltimeterProtocol
    public var isContinuous: Bool
    public var delegate: EGGBoilingPointManagerDelegate?
    
    required public init(isContinuous: Bool = false, altimeterClient: EGGCMAAltimeterProtocol = EGGCMAAltimeterClient()) {
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
    
    private func update(_ data: CMAltitudeData?, _ error: Error?) {
        if let rawPressure = data?.pressure.doubleValue {
            let pressure = Measurement(value: rawPressure, unit: UnitPressure.kilopascals).converted(to: .inchesOfMercury).value
            let res = Measurement(value: 49.161 * log(pressure) + 44, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
            
            if !isContinuous {
                stopUpdates()
            }
            
            self.delegate?.boilingPointUpdated(value: res)
        }
    }
}
