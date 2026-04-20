//
//  ProductService.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

class ProductService {
    
    static func productDetailInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/postpone",
            parameters: parameters
        )
        
        return result
    }
}
