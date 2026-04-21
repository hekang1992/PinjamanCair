//
//  DeviceParamService.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit
import AdSupport
import AppTrackingTransparency

let h5_url = "http://8.215.47.12"
let base_url = "http://8.215.47.12/confirmmy"
class DeviceParamService {
    
    static func buildRequestURL(url: String, base: String) -> String {
        let params = getAllParameters()
        guard var components = URLComponents(string: base + url) else {
            return base_url
        }
        let existingItems = components.queryItems ?? []
        let newItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        var allItems = existingItems
        for newItem in newItems {
            if let index = allItems.firstIndex(where: { $0.name == newItem.name }) {
                allItems[index] = newItem
            } else {
                allItems.append(newItem)
            }
        }
        components.queryItems = allItems.isEmpty ? nil : allItems
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
        return IDFVManager.persistedIDFV
    }
    
    private static func getOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    private static func getSessionId() -> String {
        return UserSessionManager.getToken() ?? ""
    }
    
    private static func getIdfa() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    private static func getCountryCode() -> String {
        return LanguageManager.currentLanguageCode() == "en" ? "1" : "2"
    }
    
}
