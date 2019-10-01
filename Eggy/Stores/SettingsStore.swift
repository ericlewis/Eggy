import SwiftUI

extension SettingsStore {
    static var version: String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "\(version) (\(build))"
    }
}

protocol TitleProtocol: RawRepresentable {
    var title: LocalizedStringKey {get}
}

extension TitleProtocol where Self.RawValue: StringProtocol {
    var title: LocalizedStringKey {
        LocalizedStringKey(rawValue.localizedCapitalized)
    }
}

enum AutoLockState: String, TitleProtocol {
    case active = "while running", always, never
}

enum TemperatureDisplay: String, TitleProtocol {
    case celcius, fahrenheit
}

enum WeightDisplay: String, TitleProtocol {
    case grams, ounces
}

class SettingsStore: ObservableObject {
    static let shared = SettingsStore()

    private var userDefaults: UserDefaults
    
    @Published var autoUpdateBoilingPoint: Bool
    @Published var preventAutoLock: AutoLockState
    @Published var forceDarkMode: Bool
    @Published var temperatureDisplay: TemperatureDisplay
    @Published var weightDisplay: WeightDisplay

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        
        // TODO: do some notification thinking
        // Don't ask for permissions, but do check

        autoUpdateBoilingPoint = userDefaults.value(forKey: SettingsKey.autoUpdateBoilingPoint, defaultValue: true)
        preventAutoLock = userDefaults.value(forKey: SettingsKey.preventAutoLock, defaultValue: .active)
        forceDarkMode = userDefaults.value(forKey: SettingsKey.forceDarkMode, defaultValue: false)
        temperatureDisplay = userDefaults.value(forKey: SettingsKey.temperature, defaultValue: Locale.current.usesMetricSystem ? .celcius : .fahrenheit)
        weightDisplay = userDefaults.value(forKey: SettingsKey.weight, defaultValue: Locale.current.usesMetricSystem ? .grams : .ounces)

        bindPersistance()
    }
    
    private func bindPersistance() {
        let _ = $autoUpdateBoilingPoint
        .receive(on: RunLoop.main)
        .sink {
            self.userDefaults.set($0, forKey: SettingsKey.autoUpdateBoilingPoint)
        }
        
        let _ = $preventAutoLock
        .receive(on: RunLoop.main)
        .sink {
            self.userDefaults.set($0, forKey: SettingsKey.preventAutoLock)
        }
        
        let _ = $weightDisplay
        .receive(on: RunLoop.main)
        .sink {
            self.userDefaults.set($0, forKey: SettingsKey.weight)
        }
        
        let _ = $temperatureDisplay
        .receive(on: RunLoop.main)
        .sink {
            self.userDefaults.set($0, forKey: SettingsKey.temperature)
        }
        
        let _ = $forceDarkMode
        .receive(on: RunLoop.main)
        .sink {
            self.userDefaults.set($0, forKey: SettingsKey.forceDarkMode)
        }
    }
}
