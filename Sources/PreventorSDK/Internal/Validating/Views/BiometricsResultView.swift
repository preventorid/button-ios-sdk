//
//  ValidatingResultView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 13/01/22.
//

import SwiftUI

struct BiometricsResultView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<PSDKEmptyState>
    let button: ButtonText = LanguageManager.shared.language.button
    let type: BiometricsResultType
    var hideBackButton: Bool {
        true
    }
    var nextButtonText: String {
        button.tryAgain
    }
    
    var contentBody: some View {
        switch type {
        case .errorScanDocument:
            let tryAgainDocument = LanguageManager.shared.language.pages.tryAgainDocument
            return GeneralBody(title: tryAgainDocument.title,
                               subTitle: tryAgainDocument.subTitle,
                               image: .scanDocumentError)
        case .errorSelfie:
            let tryAgainSelfie = LanguageManager.shared.language.pages.tryAgainSelfie
            return GeneralBody(title: tryAgainSelfie.title,
                               subTitle: tryAgainSelfie.subTitle,
                               image: .biometricsSelfie)
        }
    }
    
    func nextAction() {
        switch  type {
        case .errorScanDocument:
            store.parent?.dispatch(ModulePreventorAction.biometrics(.backToScanDocument))
        case .errorSelfie:
            store.parent?.dispatch(ModulePreventorAction.biometrics(.backToSelfie))
        }
    }
    
}
