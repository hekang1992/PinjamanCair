//
//  DeviceParamService.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit
import AdSupport
import AppTrackingTransparency

class DeviceParamService {
    
    static let base_url = "http://8.215.47.12/confirmmy"
    
    static func buildRequestURL() -> String {
        let params = getAllParameters()
        var components = URLComponents(string: base_url)!
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url?.absoluteString ?? base_url
    }
    
    static func getAllParameters() -> [String: String] {
        return [
            "returned": getAppVersion(),
            "gladly": getDeviceModel(),
            "sugar": getIdfv(),
            "surfeited": getOSVersion(),
            "safe": getSessionId(),
            "offspring": getIdfa(),
            "future": getCountryCode()
        ]
    }
    
    private static func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    private static func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier.isEmpty ? UIDevice.current.model : identifier
    }
    
    private static func getIdfv() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    private static func getOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    private static func getSessionId() -> String {
        return UserDefaults.standard.string(forKey: "user_session_id") ?? ""
    }
    
    private static func getIdfa() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    private static func getCountryCode() -> String {
        return LanguageManager.currentLanguageCode()
    }
    
    static func updateSessionId(_ sessionId: String) {
        UserDefaults.standard.set(sessionId, forKey: "user_session_id")
    }
    
}
