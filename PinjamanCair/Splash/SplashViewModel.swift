//
//  Untitled.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {
    
    @Published var splashModel: BaseModel?
    
    @Published var errorMsg: String?
    
    func appInitInfo(parameters: [String: Any]) {
        
        Task {
            do {
                splashModel = try await SplashService.appInitInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
}
