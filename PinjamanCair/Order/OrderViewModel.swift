//
//  OrderViewModel.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/23.
//

import Foundation
import Combine

class OrderViewModel: ObservableObject {
    
    @Published var orderModel: BaseModel?
    
    @Published var errorMsg: String?
    
    func orderLisrlInfo(parameters: [String: Any]) {
        
        Task {
            do {
                orderModel = try await OrderService.orderLisrlInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
}
