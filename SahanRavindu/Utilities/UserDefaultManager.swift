//
//  UserDefaultManager.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation
import UIKit

class UserDefaultsManager {
    
    fileprivate class func setValue(_ value: AnyObject?, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    fileprivate class func getValue(_ key: String) -> AnyObject? {
        return UserDefaults.standard.object(forKey: key) as AnyObject?
    }
    
    fileprivate class func removeValue(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}

extension UserDefaultsManager {
    
    fileprivate struct PreferencesConstants {
        static let Username = "UserLogedIn"
    }
    
    class func setLogedInUser(_ isLogedIn: Bool?) {
        UserDefaultsManager.setValue(isLogedIn as AnyObject?, key: PreferencesConstants.Username)
    }
    class func getLogedInUser() -> Bool {
        return UserDefaultsManager.getValue(PreferencesConstants.Username) as? Bool ?? false
        
    }
}

