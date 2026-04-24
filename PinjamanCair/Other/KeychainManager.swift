//
//  KeychainManager.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import Foundation
import Security
import UIKit
import AppTrackingTransparency
import AdSupport

class KeychainManager {
    
    static let service = "com.PinjamanCair.idfv.key"
    static func save(key: String, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    static func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        return value
    }
    
    static func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}

class IDFVManager {
    
    private static let idfvKey = "com.PinjamanCair.idfv.key"
    
    static var persistedIDFV: String {
        if let savedIDFV = KeychainManager.load(key: idfvKey) {
            return savedIDFV
        }
        
        let idfv = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
        if !idfv.isEmpty {
            _ = KeychainManager.save(key: idfvKey, value: idfv)
        }
        
        return idfv
    }
}

class IDFAManager {
    
    static func requestIDFAWithDelay() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        let status = await ATTrackingManager.requestTrackingAuthorization()
        
        switch status {
        case .authorized:
            print("idfa==\(ASIdentifierManager.shared().advertisingIdentifier.uuidString)")
            break
            
        default:
            break
        }
    }
}
