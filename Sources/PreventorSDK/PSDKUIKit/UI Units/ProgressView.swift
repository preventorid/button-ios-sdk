//
//  ProgressView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 30/12/21.
//

import Foundation
import SwiftUI
import Combine

struct ProgressView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack {
                PSDKText(LanguageManager.shared.language.pages.continueOnboarding.title, font: .psdkH5)
                    .padding(.top, 24)
                LottieView(animationName: "preloader")
                    .frame(width: width * 0.48, height: height * 0.22, alignment: .center)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
              )
            .padding(.horizontal, width * 0.06)
        }
    }
    
}
