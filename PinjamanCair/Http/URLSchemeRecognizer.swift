//
//  URLSchemeRecognizer.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/18.
//

import UIKit

class URLSchemeRecognizer {
    
    @discardableResult
    static func recognizeScheme(from urlString: String, with presentingViewController: UIViewController?) -> String {
        
        guard let url = URL(string: urlString) else {
            return ""
        }
        
        guard let scheme = url.scheme, scheme == "ios" else {
            return ""
        }
        
        guard let host = url.host, host == "pin.jamanc.air2" else {
            return ""
        }
        
        let path = url.path
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        
        switch path {
        case "/of":
            let message = "识别到 of 路径，参数: \(queryItems)"
            print(message)
            return message
            
        case "/to":
            let message = "识别到 to 路径，参数: \(queryItems)"
            print(message)
            return message
            
        case "/family":
            let message = "识别到 family 路径，参数: \(queryItems)"
            print(message)
            return message
            
        case "/and":
            let resumedValue = queryItems.first(where: { $0.name == "resumed" })?.value
            let message = "识别到 and 路径，参数 resumed=\(resumedValue ?? "nil")"
            print(message)
            return message
            
        case "/anywhere":
            let undoubtedlyValue = queryItems.first(where: { $0.name == "undoubtedly" })?.value
            let message = "识别到 anywhere 路径，参数 undoubtedly=\(undoubtedlyValue ?? "nil")"
            print(message)
            return message
            
        default:
            let message = "未知路径: \(path)"
            print(message)
            return message
        }
    }
}
