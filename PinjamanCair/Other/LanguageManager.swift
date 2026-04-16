//
//  LanguageManager.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit

final class LanguageManager {
    
    static let shared = LanguageManager()
    private init() {
        savedLanguageCode = UserDefaults.standard.string(forKey: AppLanguageKey) ?? LanguageType.english.rawValue
        updateBundle()
    }
    
    enum LanguageType: String {
        case english = "en"
        case indonesian = "id"
        
        init?(futureValue: String) {
            switch futureValue {
            case "1": self = .english
            case "2": self = .indonesian
            default: return nil
            }
        }
    }
    
    private let AppLanguageKey = "AppLanguage"
    private var languageBundle: Bundle?
    private var savedLanguageCode: String
    
    class func setAppLanguage(futureValue: String) {
        guard let language = LanguageType(futureValue: futureValue) else {
            return
        }
        
        let languageCode = language.rawValue
        shared.savedLanguageCode = languageCode
        UserDefaults.standard.set(languageCode, forKey: shared.AppLanguageKey)
        UserDefaults.standard.synchronize()
        
        shared.updateBundle()
    }
    
    class func currentLanguage() -> LanguageType {
        return LanguageType(rawValue: shared.savedLanguageCode) ?? .english
    }
    
    class func currentLanguageCode() -> String {
        return shared.savedLanguageCode
    }
    
    class func localizedString(forKey key: String) -> String {
        guard let bundle = shared.languageBundle else {
            return NSLocalizedString(key, comment: "")
        }
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
    private func updateBundle() {
        if let path = Bundle.main.path(forResource: savedLanguageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            languageBundle = bundle
        } else {
            languageBundle = Bundle.main
        }
    }
}

extension String {
    var localized: String {
        return LanguageManager.localizedString(forKey: self)
    }
}
