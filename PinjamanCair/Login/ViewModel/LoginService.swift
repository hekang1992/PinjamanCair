
//
//  Untitled.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

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
    
}
