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
    
    @Published var imageModel: BaseModel?
    
    @Published var orderModel: BaseModel?
    
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
    
    func imageInfo(parameters: [String: Any]) {
        
        Task {
            do {
                imageModel = try await ProductService.imageInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func orderInfo(parameters: [String: Any]) {
        
        Task {
            do {
                orderModel = try await ProductService.orderInfo(parameters: parameters)
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
    
}
