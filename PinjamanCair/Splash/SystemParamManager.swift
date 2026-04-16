//
//  SystemParamManager.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SystemConfiguration

final class SystemParamManager {
    
    static let agent = SystemParamManager()
    private init() {}
    
    static var systemLang: String {
        return Locale.preferredLanguages.first ?? "en"
    }
    
    static var isProxyEnabled: Int {
        guard let proxyConfig = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
            return 0
        }
        
        let httpEnabled = (proxyConfig["HTTPEnable"] as? Int) == 1
        let httpsEnabled = (proxyConfig["HTTPSEnable"] as? Int) == 1
        
        return (httpEnabled || httpsEnabled) ? 1 : 0
    }
    
    static var isVPNConnected: String {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let scopedDict = proxySettings["__SCOPED__"] as? [String: Any] else {
            return "0"
        }
        
        let vpnKeywords: Set = ["tap", "tun", "ppp", "ipsec", "utun", "ipsec0"]
        let hasVPN = scopedDict.keys.contains { key in
            vpnKeywords.contains { key.contains($0) }
        }
        
        return hasVPN ? "1" : "0"
    }
    
    static var allParameters: [String: Any] {
        return [
            "husbands": systemLang,
            "plain": isProxyEnabled,
            "suspense": isVPNConnected
        ]
    }
}
