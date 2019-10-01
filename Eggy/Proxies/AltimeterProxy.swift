import Combine
import CoreMotion

class AltimeterProxy {
    lazy var altimeter = CMAltimeter()
    lazy var publisher = PassthroughSubject<CMAltitudeData?, Error>()
    
    init() {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            return
        }
        
        start()
    }
    
    func start() {
        if !SettingsStore.shared.autoUpdateBoilingPoint {
            return
        }
        
        altimeter.startRelativeAltitudeUpdates(to: .main) { data, error in
            guard let error = error else {
                return self.publisher.send(data)
            }
            
            self.publisher.send(completion: Subscribers.Completion.failure(error))
        }
    }
    
    func stop() {
        altimeter.stopRelativeAltitudeUpdates()
    }
}
