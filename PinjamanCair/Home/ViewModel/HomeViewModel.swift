//
//  ViewModel.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var homeModel: BaseModel?
    
    @Published var enterModel: BaseModel?
    
    @Published var errorMsg: String?
    
    func getHomeDataInfo() {
        
        Task {
            do {
                homeModel = try await HomeService.getHomeDataInfo()
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func enterInfo(parameters: [String: Any]) {
        
        Task {
            do {
                enterModel = try await HomeService.enterInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func uploadLocationInfo(parameters: [String: Any]) {
        
        Task {
            do {
                _ = try await HomeService.uploadLocationInfo(parameters: parameters)
            } catch {
                _ = error.localizedDescription
            }
        }
        
    }
}
