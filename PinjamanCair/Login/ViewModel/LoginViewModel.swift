//
//  LoginViewModel.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var codeModel: BaseModel?
    
    @Published var voiceModel: BaseModel?
    
    @Published var loginModel: BaseModel?
    
    @Published var errorMsg: String?
    
    func codeInfo(parameters: [String: Any]) {
        
        Task {
            do {
                codeModel = try await LoginService.codeInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func loginInfo(parameters: [String: Any]) {
        
        Task {
            do {
                loginModel = try await LoginService.loginInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func pointInfo(parameters: [String: String]) {
        
        Task {
            do {
                _ = try await LoginService.pointInfo(parameters: parameters)
            } catch {
                _ = error.localizedDescription
            }
        }
        
    }
    
    func voiceInfo(parameters: [String: Any]) {
        
        Task {
            do {
                voiceModel = try await LoginService.voiceInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
}
