//
//  ValidatingView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 10/02/22.
//

import SwiftUI

struct ValidatingView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<ValidantingState>
    var button: ButtonText = LanguageManager.shared.language.button
    
    var screen: ValidantingState.Screen {
        store.state.screen
    }
    
    var showNextButton: Bool {
        screen == .result
    }
    
    var nextButtonText: String {
        store.state.resultType == .congratulations ? button.finish : button.tryAgain
    }
    
    var hidesBackButton: Bool {
        true
    }
    
    var hiddenTrailingItems: Bool {
        screen == .verifying
    }
    
    var contentBody: some View {
        ZStack {
            if screen == .verifying {
                ProgressView()
                    .onAppear {
                        updateNavigationSettings()
                    }
            } else if screen == .result {
                if let result = store.state.resultType {
                    SelfieResultView(type: result)
                        .onAppear {
                            updateNavigationSettings()
                        }
                }
            }
        }
        .onAppear {
            if screen == .verifying {
                store.dispatch(ValidantingAction.validateInfo)
            }
        }
    }
    
    func updateNavigationSettings() {
        if let coordinator = store.coordinator as? StepDocumentCoordinator,
           let settings = navigationSettings {
            coordinator.updateNavigationSettings(settings: settings, animated: true)
        }
    }
    
    func nextAction() {
        if let result = store.state.resultType {
            switch  result {
            case .errorSelfie:
                store.parent?.dispatch(StepDocumentAction.backToSelfie)
            case .errorScanDocument:
                store.parent?.dispatch(StepDocumentAction.backToScanDocument)
            case .congratulations:
                store.parent?.dispatch(AppFlow.personalInfo)
            }
        }
    }
    
}
