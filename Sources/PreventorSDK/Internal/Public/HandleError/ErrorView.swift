//
//  ErrorView.swift
//  
//
//  Created by Alexander Rodriguez on 2/02/22.
//

import SwiftUI

struct ErrorView: BaseView {
    
    var store: ReduxStore<PSDKEmptyState>
    
    var showNextButton: Bool = false
    
    var trailingItems: [UIBarButtonItem] {
        var trailingItems: [UIBarButtonItem] = []
        let profileButton = PSDKBarButton(
            image: .navigationClose.resized(to: CGSize(width: 30, height: 30)),
            style: .plain,
            customAction: {
                store.parent?.dispatch(AppFlow.showCancelVerification(
                    reason: .BIOMETRIC_AUTHENTICATION_FAILED))
            })
        trailingItems.append(profileButton)
        return trailingItems
    }
    
    var navigationSettings: PSDKNavigationSettings? {
        PSDKNavigationSettings(
            hidesBackButton: true,
            trailingItems: trailingItems,
            navigationBarColor: .psdkWhite,
            isOpaque: true
        )
    }
    
    var contentBody: some View {
        let error = LanguageManager.shared.language.pages.error
        GeneralBody(title: error.title,
                    subTitle: error.subTitle,
                    image: Image.withoutSignal,
                    style: .init(withSpacerTop: true, withSpacerBottom: true))
    }
    
    func nextAction() {
        
    }
    
}
