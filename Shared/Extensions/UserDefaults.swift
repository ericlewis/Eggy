import Foundation

// TODO: generic

public extension UserDefaults {
    static var shared: UserDefaults {
        UserDefaults(suiteName: "group.eel.eggy")!
    }
    
    func set<Value, Key>(_ value: Value?, forKey key: Key) where Value: RawRepresentable, Key: RawRepresentable, Key.RawValue == String {
        self.set(value?.rawValue, forKey: key.rawValue)
    }
    
    func set<Value, Key>(_ value: Value?, forKey key: Key) where Key: RawRepresentable, Key.RawValue == String {
        self.set(value, forKey: key.rawValue)
    }
    
    func value<Value, Key>(forKey key: Key, defaultValue: Value) -> Value where Value: RawRepresentable, Key: RawRepresentable, Key.RawValue == String {
        object(forKey: key.rawValue) != nil ? Value(rawValue: object(forKey: key.rawValue) as! Value.RawValue)! : defaultValue
    }
    
    func value<Value, Key>(forKey key: Key, defaultValue: Value) -> Value where Key: RawRepresentable, Key.RawValue == String {
        object(forKey: key.rawValue) != nil ? object(forKey: key.rawValue) as! Value : defaultValue
    }
    
    func value<Value, Key>(forKey key: Key, defaultValue: Value?) -> Value? where Key: RawRepresentable, Key.RawValue == String {
        object(forKey: key.rawValue) != nil ? object(forKey: key.rawValue) as? Value : defaultValue
    }
}
