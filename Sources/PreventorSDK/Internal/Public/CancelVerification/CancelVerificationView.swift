//
//  CancelVerificationView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 21/12/21.
//

import SwiftUI

struct CancelVerificationView: ReduxStoreView {
    typealias ViewAction = AppFlow
    
    internal var navigationSettings: PSDKNavigationSettings? {
        var trailingItems: [UIBarButtonItem] = []
        let profileButton = PSDKBarButton(
            image: UIImage.navigationClose
                .resized(to: CGSize(width: 48, height: 48))
                .withRenderingMode(.alwaysOriginal),
            style: .plain,
            customAction: backAction)
        trailingItems.append(profileButton)
    
        return PSDKNavigationSettings(
            titleView: UIImageView(image: UIImage.navigationLogo),
            navigationBarHidden: false,
            hideBackButton: true,
            trailingItems: trailingItems
        )
    }
    @ObservedObject private(set) var store: ReduxStore<PSDKEmptyState>
    let reason: PreventorSDKErrorCode
    
    private let cancelVerification = LanguageManager.shared.language.pages.cancelVerification
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack{
                Spacer()
                VStack {
                    PSDKText(cancelVerification.title, font: .psdkH5)
                    LottieView(animationName: "alertCancel")
                        .frame(width: width * 0.295, height: height * 0.135, alignment: .center)
                        .padding(.top, height * 0.07)
                    PSDKText(cancelVerification.subTitle)
                        .padding(.top, height * 0.065)
                }
                .padding(.horizontal, width * 0.161)
                Spacer()
                HStack(spacing: width * 0.02){
                    PSDKButton(
                        style: PSDKButtonStyle(
                            type: .outlined,
                            contentMode: .light,
                            isRounded: true),
                       action: backAction,
                       fullWidth: true,
                       label: {
                           Text(LanguageManager.shared.language.button.no)
                       })
                    PSDKButton(
                        style: PSDKButtonStyle(type: .filled,
                                               contentMode: .light,
                                               backgroundColor: .psdkColorSemanticDanger,
                                               isRounded: true),
                        action: {
                            store.parent?.dispatch(AppFlow.finishSDK(error: reason))
                        },
                        fullWidth: true,
                        label: {
                            Text(LanguageManager.shared.language.button.yesConfirm)
                        })
                }
                .padding(.horizontal, width * 0.067)
                .padding(.bottom, height * 0.0316)
            }
        }
    }
    
    private func backAction() {
        store.parent?.dispatch(AppFlow.back)
    }
    
}
