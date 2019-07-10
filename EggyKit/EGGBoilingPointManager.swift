import Foundation
import CoreMotion

public protocol EGGBoilingPointManagerDelegate {
    func boilingPointUpdated(value: Temperature)
}

public class EGGBoilingPointManager {
    private lazy var altimeter = CMAltimeter()
    public var isContinuous: Bool
    public var delegate: EGGBoilingPointManagerDelegate?
    
    public init(isContinuous: Bool = false) {
        self.isContinuous = isContinuous
    }
    
    public func startUpdates() {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: .main, withHandler: update)
        }
    }
    
    public func stopUpdates() {
        altimeter.stopRelativeAltitudeUpdates()
    }
    
    private func update(_ data: CMAltitudeData?, _ error: Error?) {
        if let rawPressure = data?.pressure.doubleValue {
            let pressure = Measurement(value: rawPressure, unit: UnitPressure.kilopascals).converted(to: .inchesOfMercury).value
            let res = Measurement(value: 49.161 * log(pressure) + 44, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
            self.delegate?.boilingPointUpdated(value: res)
            
            if !isContinuous {
                stopUpdates()
            }
        }
    }
}
