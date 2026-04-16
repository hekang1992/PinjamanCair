//
//  UserSessionManager.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import Foundation

class UserSessionManager {
    
    private struct Keys {
        static let phone = "user_phone_key"
        static let token = "user_token_key"
    }
    
    class func save(phone: String, token: String) {
        let defaults = UserDefaults.standard
        defaults.set(phone, forKey: Keys.phone)
        defaults.set(token, forKey: Keys.token)
        defaults.synchronize()
    }
    
    class func getPhone() -> String? {
        return UserDefaults.standard.string(forKey: Keys.phone)
    }
    
    class func getToken() -> String? {
        return UserDefaults.standard.string(forKey: Keys.token)
    }
    
    class func isLoggedIn() -> Bool {
        guard let token = getToken() else {
            return false
        }
        return !token.isEmpty
    }
    
    class func clearAll() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Keys.phone)
        defaults.removeObject(forKey: Keys.token)
        defaults.synchronize()
    }
    
}
