//
//  UserDefaultsExtension.swift
//  FYTool
//
//  Created by chinghoi on 2020/8/3.
//

import UIKit

public protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue == String {
    
    /// Sets the value of the specified default key.
    /// - Parameters:
    ///   - value: The object to store in the defaults database.
    ///   - key: The key with which to associate the value.
    public static func set(value: Any?, forKey key: defaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    // delete
    public static func removeObject(forKey key: defaultKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    // read
    public static func string(forKey key: defaultKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    public static func bool(forKey key: defaultKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    public static func integer(forKey key: defaultKeys) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    public static func array(forKey key: defaultKeys) -> [Any]? {
        return UserDefaults.standard.array(forKey: key.rawValue)
    }
    public static func float(forKey key: defaultKeys) -> Float {
        return UserDefaults.standard.float(forKey: key.rawValue)
    }
    public static func double(forKey key: defaultKeys) -> Double {
        return UserDefaults.standard.double(forKey: key.rawValue)
    }
    public static func url(forKey key: defaultKeys) -> URL? {
        return UserDefaults.standard.url(forKey: key.rawValue)
    }
    public static func data(forKey key: defaultKeys) -> Data? {
        return UserDefaults.standard.data(forKey: key.rawValue)
    }
    public static func dictionary(forKey key: defaultKeys) -> [String : Any]? {
        return UserDefaults.standard.dictionary(forKey: key.rawValue)
    }
    public static func object(forKey key: defaultKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
}
extension UserDefaults {
    static func removeAllDefaultsData(){
       let userDefaults = UserDefaults.standard
       let dics = userDefaults.dictionaryRepresentation()
       for key in dics {
           userDefaults.removeObject(forKey: key.key)
       }
       userDefaults.synchronize()
    }
}



