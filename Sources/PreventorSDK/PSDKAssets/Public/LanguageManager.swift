//
//  LanguageManager.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 14/01/22.
//

import Foundation

enum AppLanguage: String {
    
    case none = "anyLanguage"
    case spanish = "es"
    case english = "en"
    
}

class LanguageManager {
    
    static let shared: LanguageManager = .init()
    var language: Language!
    var currentLanguage: AppLanguage = .none
    var repository: LanguageRepository

    init() {
        repository = LanguageRepository()
    }
    
    func setLanguage(_ language: AppLanguage? = nil, complete: @escaping ( PSDKResultState) -> Void) {
        let appLanguage: AppLanguage = language ?? (.init(rawValue: Locale.current.languageCode ?? "") ?? .english)
        if currentLanguage == appLanguage {
            return
        }
        currentLanguage = appLanguage
        let repository = LanguageRepository()
        repository.getLanguage(
            language: currentLanguage,
            success: { language in
                LanguageManager.shared.language = language
                complete(.success)
            },
            failure: { error in
                complete(.failed)
            })
        
    }
    
    func readAndWriteData(_ appLanguage: AppLanguage) {
        if currentLanguage == appLanguage {
            return
        }
        currentLanguage = appLanguage
        var currentBunddle = Bundle.psdkUIKitBundle()
        if let path = currentBunddle?.path(forResource: currentLanguage.rawValue, ofType: "lproj"), let languageBundle = Bundle(path: path) {
            currentBunddle = languageBundle
        }
        do {
            print(appLanguage.rawValue)
            let bundlePath = currentBunddle?.path(forResource: "language",
                                                  ofType: "json") ?? ""
            if let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)  {
                language = try JSONDecoder().decode(Language.self, from: jsonData)
            }
        } catch {
            print("Error info: \(error)")
        }
    }
    
}
