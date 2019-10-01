import Foundation

extension Store {
    var tempDetail: String {
        MeasurementFormatter.tempFormatter.string(from: Measurement(value: temp.scaledTemp(), unit: UnitTemperature.celsius).converted(to: SettingsStore.shared.temperatureDisplay == .celcius ? .celsius : .fahrenheit)) + "  "
    }
    
    var sizeDetail: String {
        MeasurementFormatter.formatter.string(from: Measurement(value: size.scaledSize(), unit: UnitMass.grams).converted(to: SettingsStore.shared.weightDisplay == .grams ? .grams : .ounces)) + "     "
    }
    
    var donenessDetail: String {
        if doneness > 0.7 {
            return "Hard"
        }
        
        if doneness > 0.3 {
            return "Soft"
        }
        
        return "Runny"
    }
}
