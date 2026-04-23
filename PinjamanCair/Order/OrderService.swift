//
//  OrderService.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/23.
//

class OrderService {
    
    static func orderLisrlInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/wondered",
            parameters: parameters
        )
        
        return result
    }
}
