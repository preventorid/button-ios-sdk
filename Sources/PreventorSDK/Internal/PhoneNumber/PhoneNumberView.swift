//
//  PhoneNumberView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 29/12/21.
//

import Foundation

import SwiftUI

struct PhoneNumberView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<PhoneNumberState>
    @State var phoneNumber: String = ""
    @State var validationText: String = ""
    @State var showDropdown: Bool = false
    @State var modalRouter: PSDKModalRouter = PSDKModalRouter()
    @State private var item: PSDKPhoneTextField.Item? = nil
    @State var isNextButtonDissabled: Bool = true
    @State var isOtpNextButtonDissabled: Bool = true
    @State var timer: Timer? = nil
    @State var timeRemaining: Date? = nil
    let phonePage = LanguageManager.shared.language.pages.phone
    let phoneVerificationPage = LanguageManager.shared.language.pages.phoneVerification
    let placeHolder = LanguageManager.shared.language.placeholder
    var demiModal: PSDKDemiModal? {
        PSDKDemiModal(presented: $showDropdown, router: modalRouter, opacity:  0.8 )
    }
    var screen: PhoneNumberState.Screen {
        store.state.screen
    }
    var customBackButton: UIBarButtonItem? {
        return hideBackButton ? nil : PSDKBarButton(
            image: .navigationBackButton,
            style: .plain,
            customAction: backAction)
    }
    var nextButtonDisabled: Bool {
        return screen == .phoneNumber ? isNextButtonDissabled : isOtpNextButtonDissabled
    }
    
    var contentBody: some View {
        return GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack(spacing: 0) {
                if screen == .phoneNumber {
                    PSDKText(phonePage.title,
                             font: .psdkH5)
                    Image.stepEmailIcon
                        .padding(.top, height * 0.03)
                    PSDKPhoneTextField(
                        text: $phoneNumber,
                        item: $item,
                        modalRouter: $modalRouter,
                        showDropdown: $showDropdown,
                        handler: { text, status, handler in
                            isNextButtonDissabled = status != .valid
                            handler(status)
                        }
                    )
                        .padding(.top, height * 0.0214)
                    PSDKText(phonePage.subTitle,
                             textColor: .psdkColorTextLow,
                             font: .psdkH8)
                        .padding(.top, 8)
                } else if screen == .otpPhone {
                    PSDKText(phoneVerificationPage.title,
                             font: .psdkH5)
                    Image.stepEmailIcon
                        .padding(.top, height * 0.03)
                    PSDKText("\(phoneVerificationPage.subTitle) \n\(PSDKSession.shared.getPhoneCountryCode() ?? "") \(PSDKSession.shared.getPhone() ?? "")")
                        .padding(.top, height * 0.0215)
                    PSDKTextField($validationText,
                                  hint: placeHolder.verificationCode,
                                  minLength: 6,
                                  maxLength: 6,
                                  keyboardType: .numberPad,
                                  handler: { text, status, handler in
                        isOtpNextButtonDissabled = status != .valid
                    })
                        .padding(.top, height * 0.0215)
                    if store.state.showTimer {
                        HStack {
                            PSDKText("\(countDownString()) \(phoneVerificationPage.resend)", textColor: .psdkColorTextLow)
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
                                            store.dispatch(PhoneNumberAction.hiddeTimer)
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
                        PSDKText(phoneVerificationPage.resend, textColor: .psdkColorPrimaryLigth200, font: .psdkH8)
                            .padding(.top, height * 0.04)
                            .onTapGesture {
                                if !phoneNumber.isEmpty, let phoneCountryCode = item?.code {
                                    store.dispatch(PhoneNumberAction.sendOtpPhone(
                                        phoneCountryCode: phoneCountryCode,
                                        phone: phoneNumber))
                                }
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
    
    func nextAction() {
        switch screen {
        case .phoneNumber:
            if !phoneNumber.isEmpty, let phoneCountryCode = item?.code {
                store.dispatch(PhoneNumberAction.sendOtpPhone(phoneCountryCode: phoneCountryCode, phone: phoneNumber))
            }
        case .otpPhone:
            store.dispatch(PhoneNumberAction.validateOTP(otp: validationText))
        }
    }
    
    func backAction() {
        if screen == .phoneNumber {
            store.parent?.dispatch(AppFlow.back)
        } else {
            withAnimation {
                store.dispatch(PhoneNumberAction.updateScreen(screen: .phoneNumber))
            }
        }
    }
    
}
