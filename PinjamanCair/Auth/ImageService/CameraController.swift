//
//  CameraController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import UIKit
import AVFoundation

class CameraController: NSObject {
    
    typealias ImageDataCallback = (Data?, String?) -> Void
    
    private weak var presentingViewController: UIViewController?
    private var imagePicker: UIImagePickerController?
    private var callback: ImageDataCallback?
    private var targetCameraPosition: UIImagePickerController.CameraDevice = .rear
    
    init(presenter: UIViewController,
         initialCameraPosition: UIImagePickerController.CameraDevice = .rear,
         completion: @escaping ImageDataCallback) {
        self.presentingViewController = presenter
        self.targetCameraPosition = initialCameraPosition
        self.callback = completion
        super.init()
    }
    
    func startCamera() {
        checkCameraPermission { [weak self] granted in
            guard let self = self else { return }
            if granted {
                self.showCamera()
            } else {
                self.showPermissionDeniedAlert()
            }
        }
    }
    
    private func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
            
        case .denied, .restricted:
            completion(false)
            
        @unknown default:
            completion(false)
        }
    }
    
    private func showPermissionDeniedAlert() {
        guard let presenter = presentingViewController else { return }
        let alert = UIAlertController(
            title: "Permission Required".localized,
            message: "Camera permission is disabled. Please enable it in Settings to allow your loan application to be processed.".localized,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: { [weak self] _ in
            self?.callback?(nil, "")
        }))
        alert.addAction(UIAlertAction(title: "Go to Settings".localized, style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }))
        presenter.present(alert, animated: true, completion: nil)
    }
    
    private func showCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            callback?(nil, "")
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.cameraDevice = targetCameraPosition
        picker.delegate = self
        picker.allowsEditing = false
        self.imagePicker = picker
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let presenter = self.presentingViewController else { return }
            presenter.present(picker, animated: true, completion: nil)
        }
    }
    
    private func compressImageToUnder700KB(_ image: UIImage) -> Data? {
        let maxSizeBytes = 700 * 1024
        
        var compressionQuality: CGFloat = 0.9
        var imageData = image.jpegData(compressionQuality: compressionQuality)
        
        if let data = imageData, data.count <= maxSizeBytes {
            return data
        }
        
        var minQuality: CGFloat = 0.0
        var maxQuality: CGFloat = 1.0
        var bestData: Data? = nil
        
        for _ in 0..<10 {
            let midQuality = (minQuality + maxQuality) / 2
            guard let data = image.jpegData(compressionQuality: midQuality) else { break }
            
            if data.count <= maxSizeBytes {
                bestData = data
                minQuality = midQuality
            } else {
                maxQuality = midQuality
            }
            
            if maxQuality - minQuality < 0.01 {
                break
            }
        }
        
        if let finalData = bestData, finalData.count <= maxSizeBytes {
            return finalData
        }
        
        guard let resizedImage = resizeImage(image, scale: 0.7) else {
            return image.jpegData(compressionQuality: 0.1)
        }
        
        var finalCompression: CGFloat = 0.5
        var finalData = resizedImage.jpegData(compressionQuality: finalCompression)
        for _ in 0..<5 {
            if let data = finalData, data.count <= maxSizeBytes {
                return data
            }
            finalCompression -= 0.1
            finalData = resizedImage.jpegData(compressionQuality: max(finalCompression, 0.05))
        }
        
        return finalData ?? image.jpegData(compressionQuality: 0.1)
    }
    
    private func resizeImage(_ image: UIImage, scale: CGFloat) -> UIImage? {
        let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension CameraController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            guard let originalImage = info[.originalImage] as? UIImage else {
                self.callback?(nil, "")
                return
            }
            
            guard let compressedData = self.compressImageToUnder700KB(originalImage) else {
                self.callback?(nil, "")
                return
            }
            
            if compressedData.count <= 700 * 1024 {
                self.callback?(compressedData, nil)
            } else {
                self.callback?(nil, "")
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [weak self] in
            self?.callback?(nil, "")
        }
    }
}

