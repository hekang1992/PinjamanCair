//
//  AccountViewModel.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import Foundation
import Combine

class AccountViewModel: ObservableObject {
    
    @Published var accountModel: BaseModel?
    
    @Published var errorMsg: String?
    
    func getAccountInfo() {
        
        Task {
            do {
                accountModel = try await AccountService.getAccountInfo()
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
}
