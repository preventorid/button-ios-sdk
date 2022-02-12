//
//  FinishOTP.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 30/12/21.
//

import SwiftUI
import Lottie

struct FinishOTPView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<FinishOTPState>
    var navigationSettings: PSDKNavigationSettings? {
        PSDKNavigationSettings(
            titleView: UIImageView(image: UIImage.navigationLogo),
            hidesBackButton: true,
            navigationBarColor: .psdkWhite,
            isOpaque: true
        )
    }
    var screen: FinishOTPState.Screen {
        store.state.screen
    }
    var model: GeneralBodyModel {
        store.state.model
    }
    var nextButtonText: String {
        LanguageManager.shared.language.button.finish
    }
    
    var contentBody: some View {
        ZStack {
            if store.state.onValidation {
                ProgressView()
            } else {
                GeneralBody(model: model, style: .init(withSpacerTop: true, withSpacerBottom: true))
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                  )
            }
        }
        .animation(.spring())
        .onAppear{
            if store.state.onValidation {
                store.dispatch(FinishOtpAction.continueOnboarding)
            }
        }
    }
    
    func nextAction() {
        withAnimation {
            switch screen {
            case .congratulations:
                store.dispatch(FinishOtpAction.updateScreen(screen: .finish1))
            case .finish1:
                store.dispatch(FinishOtpAction.updateScreen(screen: .finish2))
            case .finish2:
                store.parent?.dispatch(AppFlow.finishSDK())
            }
        }
    }
    
}
