//
//  FinishAppView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 30/12/21.
//

import SwiftUI
import Lottie

struct FinishAppView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<FinishAppState>
    var navigationSettings: PSDKNavigationSettings? {
        PSDKNavigationSettings(
            titleView: UIImageView(image: UIImage.navigationLogo),
            hideBackButton: true,
            navigationBarColor: .psdkWhite,
            isOpaque: true
        )
    }
    
    var hideBackButton: Bool {
        true
    }
    var hideTrailingItems: Bool {
        true
    }
    var model: GeneralBodyModel {
        store.state.model
    }
    var nextButtonText: String {
        LanguageManager.shared.language.button.finish
    }
    
    var contentBody: some View {
        GeneralBody(model: model, style: .init(withSpacerTop: true, withSpacerBottom: true))
        .animation(.spring())
    }
    
    func nextAction() {
        withAnimation {
            store.parent?.dispatch(AppFlow.finishSDK())
        }
    }
    
}
