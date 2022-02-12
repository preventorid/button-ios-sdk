//
//  StepEmailView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 28/12/21.
//

import SwiftUI
import Combine

struct StepEmailView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<StepEmailState>
    @State var emailText: String = ""
    @State var validationText: String = ""
    @State var isNextButtonDissabled: Bool = true
    @State var isOtpNextButtonDissabled: Bool = true
    var screen: StepEmailState.Screen {
        store.state.screen
    }
    var customBackButton: UIBarButtonItem? {
        return PSDKBarButton(
            image: .navigationBackButton,
            style: .plain,
            customAction: backAction)
    }
    var nextButtonDisabled: Bool {
        return screen == .email ?
        isNextButtonDissabled :
        isOtpNextButtonDissabled
    }
    let emailPage = LanguageManager.shared.language.pages.email
    let emailVerificationPage = LanguageManager.shared.language.pages.emailVerification
    let placeHolder = LanguageManager.shared.language.placeholder
    
    var contentBody: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack(spacing: 0) {
                if screen == .email {
                    PSDKText(emailPage.title,
                             font: .psdkH5)
                    Image.stepEmailIcon
                        .padding(.top, height * 0.03)
                    PSDKEmailTextField(
                        $emailText,
                        hint: placeHolder.emailAddress,
                        handler: { text, status, handler  in
                            isNextButtonDissabled = status != .valid
                            handler(status)
                        },
                        onSubmit: onSubmit)
                        .padding(.top, height * 0.0214)
                    PSDKText(emailPage.subTitle,
                             textColor: .psdkColorTextLow,
                             font: .psdkH8)
                        .padding(.top, 8)
                } else if screen == .otpEmail {
                    PSDKText(emailVerificationPage.title,
                             font: .psdkH5)
                    Image.stepEmailIcon
                        .padding(.top, height * 0.03)
                    PSDKText("\(emailVerificationPage.subTitle) \n\(PSDKSession.shared.getEmail() ?? "")")
                        .padding(.top, height * 0.0215)
                    PSDKTextField($validationText,
                                  hint: placeHolder.verificationCode,
                                  minLength: 3,
                                  maxLength: 6,
                                  keyboardType: .numberPad,
                                  handler: { text, status, handler in
                        isOtpNextButtonDissabled = status != .valid
                    })
                        .padding(.top, height * 0.0215)
                    PSDKText(emailVerificationPage.resend, textColor: .psdkColorPrimaryLigth200, font: .psdkH8)
                        .padding(.top, height * 0.04)
                        .onTapGesture {
                            store.dispatch(StepEmailAction.sendOtpEmail(email: emailText))
                        }
                    HStack {
                        PSDKText("00:59:00 \(emailVerificationPage.resend)", textColor: .psdkColorTextLow)
                        Spacer()
                    }
                    .padding(.top, height * 0.011)
                }
                Spacer()
            }
            .padding(.top, 15)
            .padding(.horizontal, width * 0.067)
            .animation(.default)
        }
    }
    
    func onSubmit(_ result: ValidationResult) {
        if result == .valid {
            nextAction()
        }
    }
    
    func nextAction() {
        if (screen == .email && !emailText.isEmpty) {
            store.dispatch(StepEmailAction.sendOtpEmail(email: emailText))
        } else {
            store.dispatch(StepEmailAction.validateOtpEmail(code: validationText))
        }
    }
    
    func backAction() {
        if screen == .email {
            store.parent?.dispatch(AppFlow.back)
        } else {
            withAnimation {
                store.dispatch(StepEmailAction.updateScreen(screen: .email))
            }
        }
    }
    
}
