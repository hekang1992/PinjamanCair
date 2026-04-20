//
//  ImageService.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

class ImageService {
    
    static func imageInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/observers",
            parameters: parameters
        )
        
        return result
    }
    
}
