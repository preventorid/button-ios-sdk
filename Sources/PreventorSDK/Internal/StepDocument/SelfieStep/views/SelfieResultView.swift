//
//  SelfieResultView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 13/01/22.
//

import SwiftUI

struct SelfieResultView: View {
    
    let type: SelfieResultType
    
    var body: some View {
        switch type {
        case .errorScanDocument:
            return GeneralBody(title: "Let’s try that again",
                               subTitle: "But first, please make sure you take the photo in a well-lit flat surface.",
                               image: .scanDocumentError)
        case .errorSelfie:
            return GeneralBody(title: "Let’s try that again",
                               subTitle: "But first, please make sure you are in good light environment, use neutral expression, no smiling, no glare or extreme lighting.",
                               image: .biometricsSelfie)
        case .congratulations:
            return GeneralBody(title: "Congratulations\nyou’re done!",
                               subTitle: "Your identity verification\nhas been completed.",
                               lottie: LottieView(animationName: "congratulations"),
                               style: .init(withSpacerTop: true))
        }
    }
    
}
