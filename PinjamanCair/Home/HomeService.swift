//
//  HomeService.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

class HomeService {
    
    static func getHomeDataInfo() async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.get(
            "/aboutwas/meantime"
        )
        
        return result
    }
    
}
