//
//  ProductViewModel.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    
    @Published var productModel: BaseModel?
    
    @Published var errorMsg: String?
    
    func productDetailInfo(parameters: [String: Any]) {
        
        Task {
            do {
                productModel = try await ProductService.productDetailInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
}
