//
//  NetworkManager.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import Alamofire
import Foundation
import Toast_Swift

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func get<T: Decodable>(_ url: String,
                           parameters: [String: Any]? = nil) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            
            let apiUrl = DeviceParamService.buildRequestURL(url: url)
            
            AF.request(apiUrl, parameters: parameters)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                        
                    case .success(let value):
                        continuation.resume(returning: value)
                        
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func post<T: Decodable>(_ url: String, parameters: [String: Any]) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            
            let apiUrl = DeviceParamService.buildRequestURL(url: url)
            
            AF.upload(multipartFormData: { formData in
                for (key, value) in parameters {
                    if let data = "\(value)".data(using: .utf8) {
                        formData.append(data, withName: key)
                    }
                }
            }, to: apiUrl)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                    
                case .success(let value):
                    continuation.resume(returning: value)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func uploadImage<T: Decodable>(_ url: String,
                                   imageData: Data,
                                   fileName: String = "image.jpg",
                                   parameters: [String: Any]? = nil) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            
            let apiUrl = DeviceParamService.buildRequestURL(url: url)
            
            AF.upload(multipartFormData: { formData in
                formData.append(imageData,
                                withName: "file",
                                fileName: fileName,
                                mimeType: "image/jpeg")
                
                if let parameters = parameters {
                    for (key, value) in parameters {
                        if let data = "\(value)".data(using: .utf8) {
                            formData.append(data, withName: key)
                        }
                    }
                }
            }, to: apiUrl)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                    
                case .success(let value):
                    continuation.resume(returning: value)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

class ToastConfig {
    static func showMessage(_ message: String) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else { return }
            window.makeToast(message, duration: 3.0, position: .center)
        }
    }
}
