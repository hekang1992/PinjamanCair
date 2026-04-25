
//
//  Untitled.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import AdSupport

class LoginService {
    
    static func codeInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/plain",
            parameters: parameters
        )
        
        return result
    }
    
    static func loginInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/remains",
            parameters: parameters
        )
        
        return result
    }
    
    static func pointInfo(parameters: [String: String]) async throws -> BaseModel? {
        
        let top = LocationStorage.getLongitude() ?? ""
        
        let jealous = LocationStorage.getLatitude() ?? ""
        
        var apiJson = ["luck": String(Int(Date().timeIntervalSince1970)),
                       "top": top,
                       "jealous": jealous,
                       "small": "2",
                       "fastened": IDFVManager.persistedIDFV,
                       "entered": ASIdentifierManager.shared().advertisingIdentifier.uuidString]
        
        apiJson.merge(parameters) { (_, new) in new }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/absenting",
            parameters: apiJson
        )
        
        return result
    }
    
}
