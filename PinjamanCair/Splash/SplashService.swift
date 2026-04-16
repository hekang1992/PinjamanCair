//
//  SplashService.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

class SplashService {
    
    static func appInitInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/husbands",
            parameters: parameters
        )
        
        return result
    }
    
}
