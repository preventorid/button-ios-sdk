//
//  StepEmailView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 28/12/21.
//

import SwiftUI
import Combine

struct StepEmailView: BaseView {
    
    typealias ViewAction = StepEmailAction
    @ObservedObject private(set) var store: ReduxStore<StepEmailState>
    @State var emailText: String = ""
    @State var validationText: String = ""
    @State var isNextButtonDissabled: Bool = true
    @State var isOtpNextButtonDissabled: Bool = true
    @State var timer: Timer? = nil
    @State var timeRemaining: Date? = nil
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
                    if store.state.showTimer {
                        HStack {
                            PSDKText("\(countDownString()) \(emailVerificationPage.resend)", textColor: .psdkColorTextLow)
                            Spacer()
                        }
                        .padding(.top, height * 0.038)
                        .onAppear {
                            if timer == nil {
                                let date = Date()
                                let zeroDate = date - date.timeIntervalSinceReferenceDate
                                timeRemaining = zeroDate + (store.state.seconds ?? 0.0)
                                timer = .scheduledTimer(withTimeInterval: 1, repeats: true) { t in
                                    if let time = timeRemaining {
                                        if Int(time.timeIntervalSinceReferenceDate) == 0 {
                                            store.dispatch(StepEmailAction.hiddeTimer)
                                            t.invalidate()
                                            timer = nil
                                        } else {
                                            timeRemaining = time - 1
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        PSDKText(emailVerificationPage.resend, textColor: .psdkColorPrimaryLigth200, font: .psdkH8)
                            .padding(.top, height * 0.04)
                            .onTapGesture {
                                store.dispatch(StepEmailAction.sendOtpEmail(email: emailText))
                            }
                    }
                }
                Spacer()
            }
            .padding(.top, 15)
            .padding(.horizontal, width * 0.067)
            .animation(.default)
        }
    }
    
    func countDownString() -> String {
        if let timeRemaining = timeRemaining {
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.minute, .second], from: timeRemaining)
            return String(format: "%02d:%02d",
                          components.minute ?? 00,
                          components.second ?? 00)
        }
        return ""
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
