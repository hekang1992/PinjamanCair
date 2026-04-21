//
//  ImageViewModel.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import Foundation
import Combine

class ImageViewModel: ObservableObject {
    
    @Published var imageModel: BaseModel?
    
    @Published var uploadModel: BaseModel?
    
    @Published var saveModel: BaseModel?
    
    @Published var listModel: BaseModel?
    
    @Published var errorMsg: String?
    
    func imageInfo(parameters: [String: Any]) {
        
        Task {
            do {
                imageModel = try await ImageService.imageInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func uploadImageInfo(parameters: [String: Any], imageData: Data) {
        
        Task {
            do {
                uploadModel = try await ImageService.uploadImageInfo(parameters: parameters,
                                                                     imageData: imageData)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func saveImageInfo(parameters: [String: Any]) {
        
        Task {
            do {
                saveModel = try await ImageService.saveImageInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func getPerInfo(parameters: [String: Any]) {
        
        Task {
            do {
                listModel = try await ImageService.getPerInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func savePerInfo(parameters: [String: Any]) {
        
        Task {
            do {
                saveModel = try await ImageService.savePerInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func getPwInfo(parameters: [String: Any]) {
        
        Task {
            do {
                listModel = try await ImageService.getPwInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func savePwInfo(parameters: [String: Any]) {
        
        Task {
            do {
                saveModel = try await ImageService.savePwInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func getPcInfo(parameters: [String: Any]) {
        
        Task {
            do {
                listModel = try await ImageService.getPcInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func savePcInfo(parameters: [String: Any]) {
        
        Task {
            do {
                saveModel = try await ImageService.savePcInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
    func uploadPcInfo(parameters: [String: Any]) {
        
        Task {
            do {
                uploadModel = try await ImageService.uploadPcInfo(parameters: parameters)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
        
    }
    
}
