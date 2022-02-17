//
//  TermsConditionsView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 18/12/21.
//

import SwiftUI

struct TermsConditionsView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<CameraDeniedState>
    @State var termsAcepted = false
    @State var strings: [StringWithAttributes] = []
    let textManager: PrepareSteps = LanguageManager.shared.language.pages.prepareSteps
    var showProgressBar: Bool { false }
    var nextButtonDisabled: Bool { !termsAcepted }
    
    var contentBody: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack {
                PSDKText(textManager.title,
                         font: .psdkH5)
                    .padding(.horizontal, width * 0.06)
                    .padding(.top, height * 0.02)
                VStack(spacing: height * 0.02) {
                    TermView(text: textManager.steps.step1)
                    TermView(text: textManager.steps.step2)
                    TermView(text: textManager.steps.step3)
                    TermView(text: textManager.steps.step4)
                }
                .padding(.horizontal, width * 0.1)
                .padding(.top, height * 0.04)
                Spacer()
                HStack {
                    CheckBoxView(checked: $termsAcepted)
                    HyperlinkText(html: textManager.agreements, strings: $strings)
                }
                .frame(height: 45, alignment: .bottom)
                .padding(.horizontal, width * 0.06)
                .padding(.bottom, 17)
            }
        }
        .animation(.default)
    }
    
    func nextAction() {
        if termsAcepted {
            store.parent?.dispatch(ModulePreventorAction.biometrics(.showDocumentType))
        }
    }
    
}
