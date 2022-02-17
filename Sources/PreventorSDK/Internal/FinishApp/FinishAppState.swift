//
//  FinishAppState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 30/12/21.
//

import SwiftUI

class FinishAppState: ReduxState {
    
    enum Screen {
        
        case verifiedBiometrics
        case verifiedStreamline
        case awaitingBiometrics
        case awaitingStreamline
        
    }
    
    let model: GeneralBodyModel
    
    init(screen: Screen){
        self.model = screen.build
    }

}

extension FinishAppState.Screen {
    var build: GeneralBodyModel {
        switch self {
        case .verifiedBiometrics:
            let congratulations = LanguageManager.shared.language.pages.congratulations
            return GeneralBodyModel(title: congratulations.title,
                                   subTitle: congratulations.subTitle.identityVerification,
                                   lottie: LottieView(animationName: "congratulations"))
        case .verifiedStreamline:
            let congratulations = LanguageManager.shared.language.pages.congratulations
            return GeneralBodyModel(title: congratulations.title,
                                    subTitle: congratulations.subTitle.streamline,
                                    lottie: LottieView(animationName: "congratulations"))
        case .awaitingBiometrics:
            let identityVerificationSubmitted = LanguageManager.shared.language.pages.identityVerificationSubmitted
            return GeneralBodyModel(title: identityVerificationSubmitted.title,
                                   subTitle: identityVerificationSubmitted.subTitle,
                                   lottie: LottieView(animationName: "digitalHasben"))
        case .awaitingStreamline:
            let streamLineSubmitted = LanguageManager.shared.language.pages.streamLineSubmitted
            return GeneralBodyModel(title: streamLineSubmitted.title,
                                   subTitle: streamLineSubmitted.subTitle,
                                   image: Image.errorOTPFlow)
        }
    }
}
