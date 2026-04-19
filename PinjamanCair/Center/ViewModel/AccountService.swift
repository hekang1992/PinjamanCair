//
//  AccountService.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

class AccountService {
    
    static func getAccountInfo() async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.get(
            "/aboutwas/eat"
        )
        
        return result
    }
    
    static func outInfo() async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.get(
            "/aboutwas/judgment"
        )
        
        return result
    }
    
    static func deleteInfo() async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/likely",
            parameters: ["app": "1"]
        )
        
        return result
    }
}
