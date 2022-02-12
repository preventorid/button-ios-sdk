//
//  CameraDenied.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import UIKit
import SwiftUI

struct CameraDeniedView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<CameraDeniedState>
    var nextButtonStyle: PSDKButtonStyle {
        PSDKButtonStyle(type: .outlined,
                        contentMode: .light,
                        backgroundColor: .psdkWhite,
                        isRounded: true)
    }
    let page = LanguageManager.shared.language.pages.deniedAccessCamera
    var contentBody: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack {
                Text(page.title)
                    .multilineTextAlignment(.center)
                    .font(.psdkH5)
                    .foregroundColor(.psdkTextColorPrimaryLight)
                LottieView(animationName: "alertCancel")
                    .frame(width: width * 0.47,
                           height: height * 0.26,
                           alignment: .center)
                    .padding(.top, height * 0.03)
                Text(page.subTitleMobile)
                    .multilineTextAlignment(.center)
                    .font(.psdkH7)
                    .foregroundColor(.psdkTextColorPrimaryLight)
                    .padding(.top, height * 0.02)
            }
            .padding(.horizontal, width * 0.16)
            .padding(.top, height * 0.1)
        }
    }
    
    func nextAction() {
        
    }
}
