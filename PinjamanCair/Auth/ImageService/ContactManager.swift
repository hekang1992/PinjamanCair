//
//  ContactManager.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/21.
//

import UIKit
import Contacts
import ContactsUI

class ContactManager: NSObject {
    
    static let shared = ContactManager()
    private override init() { super.init() }
    
    private var selectCompletionHandler: (([[String: String]]?) -> Void)?
    
    static func selectSingleContact(completion: @escaping ([[String: String]]?) -> Void) {
        shared.selectCompletionHandler = completion
        shared.presentContactPicker()
    }
    
    static func getAllContacts(completion: @escaping ([[String: String]]?) -> Void) {
        shared.fetchAllContacts(completion: completion)
    }
    
    private func presentContactPicker() {
        guard let topVC = getTopViewController() else { return }
        
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch authorizationStatus {
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { [weak self] granted, _ in
                DispatchQueue.main.async {
                    if granted {
                        self?.showContactPicker(from: topVC)
                    } else {
                        self?.showSettingsAlert()
                        self?.selectCompletionHandler?(nil)
                    }
                }
            }
            
        case .authorized, .limited:
            showContactPicker(from: topVC)
            
        case .denied, .restricted:
            showSettingsAlert()
            selectCompletionHandler?(nil)
            
        @unknown default:
            selectCompletionHandler?(nil)
        }
    }
    
    private func showContactPicker(from viewController: UIViewController) {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        
        picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        
        viewController.present(picker, animated: true)
    }
    
    private func fetchAllContacts(completion: @escaping ([[String: String]]?) -> Void) {
        let store = CNContactStore()
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch authorizationStatus {
        case .notDetermined:
            store.requestAccess(for: .contacts) { [weak self] granted, _ in
                DispatchQueue.main.async {
                    if granted {
                        self?.fetchAllContactsFromStore(completion: completion)
                    } else {
                        self?.showSettingsAlert()
                        completion(nil)
                    }
                }
            }
            
        case .authorized, .limited:
            fetchAllContactsFromStore(completion: completion)
            
        case .denied, .restricted:
            showSettingsAlert()
            completion(nil)
            
        @unknown default:
            completion(nil)
        }
    }
    
    private func fetchAllContactsFromStore(completion: @escaping ([[String: String]]?) -> Void) {
        let store = CNContactStore()
        var allContacts: [[String: String]] = []
        
        let keysToFetch = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey
        ] as [CNKeyDescriptor]
        
        do {
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            
            try store.enumerateContacts(with: request) { contact, stop in
                if let contactDict = self.processContact(contact, takeFirstPhoneOnly: false) {
                    allContacts.append(contactDict)
                }
            }
            
            completion(allContacts.isEmpty ? nil : allContacts)
            
        } catch {
            print("\(error)")
            completion(nil)
        }
    }
    
    private func processContact(_ contact: CNContact, takeFirstPhoneOnly: Bool) -> [String: String]? {
        var phoneNumbers: String?
        
        if takeFirstPhoneOnly {
            phoneNumbers = contact.phoneNumbers.first?.value.stringValue
        } else {
            let allNumbers = contact.phoneNumbers.compactMap { $0.value.stringValue }
            phoneNumbers = allNumbers.isEmpty ? nil : allNumbers.joined(separator: ",")
        }
        
        guard let phone = phoneNumbers else { return nil }
        
        let fullName = "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespaces)
        let displayName = fullName.isEmpty ? "" : fullName
        
        return ["self": phone, "alive": displayName]
    }
    
    private func showSettingsAlert() {
        guard let topVC = getTopViewController() else { return }
        
        let alert = UIAlertController(
            title: "Permission Required".localized,
            message: "Contact permission is disabled. Please enable it in Settings to allow your loan application to be processed.".localized,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        alert.addAction(UIAlertAction(title: "Go to Settings".localized, style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        
        topVC.present(alert, animated: true)
    }
    
    private func getTopViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return nil
        }
        return getTopMostViewController(from: rootVC)
    }
    
    private func getTopMostViewController(from viewController: UIViewController) -> UIViewController {
        if let presented = viewController.presentedViewController {
            return getTopMostViewController(from: presented)
        }
        if let navigation = viewController as? UINavigationController,
           let top = navigation.topViewController {
            return getTopMostViewController(from: top)
        }
        if let tabBar = viewController as? UITabBarController,
           let selected = tabBar.selectedViewController {
            return getTopMostViewController(from: selected)
        }
        return viewController
    }
}

extension ContactManager: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if let result = processContact(contact, takeFirstPhoneOnly: true) {
            selectCompletionHandler?([result])
        } else {
            selectCompletionHandler?(nil)
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        selectCompletionHandler?(nil)
    }
}
