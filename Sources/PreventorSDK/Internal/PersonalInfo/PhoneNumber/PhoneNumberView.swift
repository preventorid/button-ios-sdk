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
    var screen: PhoneNumberState.Screen {
        store.state.screen
    }
    
    @State var showDropdown: Bool = false
    @State var modalRouter: PSDKModalRouter = PSDKModalRouter()
    @State private var item: PSDKPhoneTextField.Item? = nil
    @State var isNextButtonDissabled: Bool = true
    @State var isOtpNextButtonDissabled: Bool = true
    let phonePage = LanguageManager.shared.language.pages.phone
    let phoneVerificationPage = LanguageManager.shared.language.pages.phoneVerification
    let placeHolder = LanguageManager.shared.language.placeholder
    var demiModal: PSDKDemiModal? {
        PSDKDemiModal(presented: $showDropdown, router: modalRouter, opacity:  0.8 )
    }
    var customBackButton: UIBarButtonItem? {
        return hidesBackButton ? nil : PSDKBarButton(
            image: .navigationBackButton,
            style: .plain,
            customAction: backAction)
    }
    var showNextButton: Bool {
        screen != .verifying
    }
    var hidesBackButton: Bool {
        screen == .verifying
    }
    var hiddenTrailingItems: Bool {
        screen == .verifying
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
                    PSDKText(phoneVerificationPage.resend, textColor: .psdkColorPrimaryLigth200, font: .psdkH8)
                        .padding(.top, height * 0.04)
                        .onTapGesture {
                            if !phoneNumber.isEmpty, let phoneCountryCode = item?.code {
                                store.dispatch(PhoneNumberAction.sendOtpPhone(
                                    phoneCountryCode: phoneCountryCode,
                                    phone: phoneNumber))
                            }
                        }
                    HStack {
                        PSDKText("00:59:00 \(phoneVerificationPage.resend)", textColor: .psdkColorTextLow)
                        Spacer()
                    }
                    .padding(.top, height * 0.011)
                } else if screen == .verifying {
                    ProgressView()
                        .onAppear {
                            updateNavigationSettings()
                        }
                }
                Spacer()
            }
            .padding(.top, 15)
            .padding(.horizontal, width * 0.067)
            .animation(.default)
        }
    }
    
    func nextAction() {
        switch screen {
        case .phoneNumber:
            if !phoneNumber.isEmpty, let phoneCountryCode = item?.code {
                store.dispatch(PhoneNumberAction.sendOtpPhone(phoneCountryCode: phoneCountryCode, phone: phoneNumber))
            }
        case .otpPhone:
            store.dispatch(PhoneNumberAction.validateOTP(otp: validationText))
        default: break
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
    
    func updateNavigationSettings() {
        if let coordinator = store.coordinator as? ModulePersonalInfoCoordinator,
           let settings = navigationSettings {
            coordinator.updateNavigationSettings(settings: settings, animated: true)
        }
    }
    
}
