//
//  File.swift
//  
//
//  Created by Alexander Rodriguez on 16/02/22.
//

import SwiftUI

//case .congratulations:
//store.parent?.dispatch(ModulePreventorAction.streamline(.showPersonalInfo))
enum CongratulationsType {
    
    case streamline
    case identity
    
}
struct CongratulationsView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<PSDKEmptyState>
    let type: CongratulationsType
    var hideTrailingItems: Bool = true
    var hideBackButton: Bool = true
    let congratulationsText = LanguageManager.shared.language.pages.congratulations
    var subTitle: String {
        type == .identity ? congratulationsText.subTitle.identityVerification : congratulationsText.subTitle.streamline
    }
    var contentBody: some View {
        GeneralBody(title: congratulationsText.title,
                    subTitle: subTitle,
                    lottie: LottieView(animationName: "congratulations"),
                    style: .init(withSpacerTop: true))
    }
    
    func nextAction() {
        store.parent?.dispatch(AppFlow.finishSDK())
    }
    
}
