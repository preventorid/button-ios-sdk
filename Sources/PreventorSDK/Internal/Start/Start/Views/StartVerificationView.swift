//
//  StartVerificationView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 18/12/21.
//

import SwiftUI
import Combine

struct StartVerificationView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<StartState>
    var showProgressBar: Bool { false }
    var nextButtonText: String { LanguageManager.shared.language.button.start }
    @State var text: String = ""
    var textManager: GenericView {
        LanguageManager.shared.language.pages.start
    }
    
    var contentBody: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                Text(textManager.title)
                    .font(.psdkH5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.psdkTextColorPrimaryLight)
                    .fixedSize(horizontal: false, vertical: true)
                LottieView(animationName: "startIdentityVerification")
                    .frame(width: 178, height: 147, alignment: .center)
                Text(textManager.subTitle)
                    .font(.psdkH7)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.psdkTextColorPrimaryLight)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .padding(.horizontal, width * 0.16)
            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
    
    func nextAction() {
        store.parent?.dispatch(StartFlowAction.showTermsConditions)
    }
    
}
