//
//  ModuleModels.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 13/01/22.
//

import SwiftUI

enum BiometricsResultType {
    
    case errorScanDocument
    case errorSelfie
    
}

struct ReadyScanModel {
    
    let title: String
    let subTitle: String
    let image: Image
    
    init(from type: DocumentModel.DocType) {
        switch type {
        case .passport:
            title = LanguageManager.shared.language.pages.globalDocument.passport.title
            subTitle = LanguageManager.shared.language.pages.globalDocument.passport.subTitle
            image = .documentPassport
        case .visa:
            title = LanguageManager.shared.language.pages.globalDocument.visa.title
            subTitle = LanguageManager.shared.language.pages.globalDocument.visa.subTitle
            image = .documentVisa
        case .idCard:
            title = LanguageManager.shared.language.pages.globalDocument.idCard.title
            subTitle = LanguageManager.shared.language.pages.globalDocument.idCard.subTitle
            image = .documentNationalId
        case .driverLicense:
            title = LanguageManager.shared.language.pages.globalDocument.driverLicense.title
            subTitle = LanguageManager.shared.language.pages.globalDocument.driverLicense.subTitle
            image = .documentDriverLicense
        }
    }
    
}
