//
//  FinishOTPState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 30/12/21.
//

import SwiftUI

class FinishOTPState: ReduxState {
    
    enum Screen {
        
        case congratulations
        case finish1
        case finish2
        
    }
    
    let onValidation: Bool
    let screen: Screen
    let model: GeneralBodyModel
    
    init(onValidation: Bool = true,
         screen: Screen = .congratulations){
        self.onValidation = onValidation
        self.screen = screen
        self.model = screen.build
    }

}

extension FinishOTPState.Screen {
    var build: GeneralBodyModel {
        switch self {
        case .congratulations:
            let congratulations = LanguageManager.shared.language.pages.congratulations
            return GeneralBodyModel(title: congratulations.title,
                                   subTitle: congratulations.subTitle.streamline,
                                   lottie: LottieView(animationName: "congratulations"))
        case .finish1:
            let identityVerificationSubmitted = LanguageManager.shared.language.pages.identityVerificationSubmitted
            return GeneralBodyModel(title: identityVerificationSubmitted.title,
                                   subTitle: identityVerificationSubmitted.subTitle,
                                   lottie: LottieView(animationName: "digitalHasben"))
        case .finish2:
            let streamLineSubmitted = LanguageManager.shared.language.pages.streamLineSubmitted
            return GeneralBodyModel(title: streamLineSubmitted.title,
                                   subTitle: streamLineSubmitted.subTitle,
                                   image: Image.errorOTPFlow)
        }
    }
}
