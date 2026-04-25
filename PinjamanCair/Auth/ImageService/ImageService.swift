//
//  ImageService.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import Foundation
import AdSupport

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
    
    static func uploadImageInfo(parameters: [String: Any], imageData: Data) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.uploadImage(
            "/aboutwas/fortunate",
            imageData: imageData,
            parameters: parameters
        )
        
        return result
    }
    
    static func saveImageInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/questions",
            parameters: parameters
        )
        
        return result
    }
    
    static func getPerInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/denying",
            parameters: parameters
        )
        
        return result
    }
    
    static func savePerInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/self",
            parameters: parameters
        )
        
        return result
    }
    
    static func getPwInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/heroic",
            parameters: parameters
        )
        
        return result
    }
    
    static func savePwInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/unseen",
            parameters: parameters
        )
        
        return result
    }
    
    static func getPcInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/somewhere",
            parameters: parameters
        )
        
        return result
    }
    
    static func savePcInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/deserted",
            parameters: parameters
        )
        
        return result
    }
    
    static func uploadPcInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/normal",
            parameters: parameters
        )
        
        return result
    }
    
    static func getPbInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/widowed",
            parameters: parameters
        )
        
        return result
    }
    
    static func savePbInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            "/aboutwas/alive",
            parameters: parameters
        )
        
        return result
    }
    
}
