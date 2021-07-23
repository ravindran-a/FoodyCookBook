//
//  UserDefaultsManager.swift
//  FoodyCookBook
//
//  Created by Ravindran on 22/07/21.
//

import Foundation
import UIKit

public class UserDefaultsManager {
    
    public enum UserDefaultsKeyType: String {
        case favourites = "com.ravindran.FoodyCookBook.favourites"
    }
    
    public static func setInt(_ int: Int?, forKey key: UserDefaultsKeyType, synchronize: Bool = true) {
                
        guard let confirmedInt = int else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedInt, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    public static func setString(_ string: String?, forKey key: UserDefaultsKeyType, synchronize: Bool = true) {
                
        guard let confirmedString = string else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedString, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    public static func setObject(_ object: Any?, forKey key: UserDefaultsKeyType, synchronize: Bool = true) {
                
        guard let confirmedObject = object else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedObject, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
    }

    public static func setBool(_ bool: Bool?, forKey key: UserDefaultsKeyType, synchronize: Bool = true) {

        guard let confirmedBool = bool else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }

        UserDefaults.standard.set(confirmedBool, forKey: key.rawValue)

        if synchronize {
            UserDefaults.standard.synchronize()
        }

    }

    public static func removeValueForKey(_ key: UserDefaultsKeyType, synchronize: Bool = true) {
                
        //TODO: Can we just remove this instead?
        UserDefaults.standard.set("", forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    public static func removeAllUserDefaultValues() {
        UserDefaultsManager.removeValueForKey(.favourites)
    }
    
    public static func stringForKey(_ key: UserDefaultsKeyType) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    public static func integerForKey(_ key: UserDefaultsKeyType) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    public static func objectForKey(_ key: UserDefaultsKeyType) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue) as Any?
    }

    public static func boolForKey(_ key: UserDefaultsKeyType) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }

}
