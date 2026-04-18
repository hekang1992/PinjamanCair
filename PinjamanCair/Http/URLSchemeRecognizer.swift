//
//  URLSchemeRecognizer.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/18.
//

import UIKit

class URLSchemeRecognizer {
    
    static let scheme_url = "ios://pin.jamanc.air2"
    
    static func recognizeScheme(from urlString: String, with viewController: CommonViewController?) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        guard let scheme = url.scheme, scheme == "ios" else {
            return
        }
        
        guard let host = url.host, host == "pin.jamanc.air2" else {
            return
        }
        
        let path = url.path
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        
        switch path {
        case "/of":
            let settingVc = SettingsViewController()
            viewController?.navigationController?.pushViewController(settingVc, animated: true)
            
        case "/to":
            let message = "识别到 to 路径，参数: \(queryItems)"
            print(message)
            
        case "/family":
            let message = "识别到 family 路径，参数: \(queryItems)"
            print(message)
            
        case "/and":
            let resumedValue = queryItems.first(where: { $0.name == "resumed" })?.value
            let message = "识别到 and 路径，参数 resumed=\(resumedValue ?? "nil")"
            print(message)
            
        case "/anywhere":
            let undoubtedlyValue = queryItems.first(where: { $0.name == "undoubtedly" })?.value
            let message = "识别到 anywhere 路径，参数 undoubtedly=\(undoubtedlyValue ?? "nil")"
            print(message)
            
        default:
            let message = "未知路径: \(path)"
            print(message)
        }
    }
}
