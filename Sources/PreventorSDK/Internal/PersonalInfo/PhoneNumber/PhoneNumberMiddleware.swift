//
//  PhoneNumberMiddleware.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 12/01/22.
//

import UIKit

final class PhoneNumberMiddleware: PSDKReduxMiddleware<PhoneNumberState> {

    private let animationTime = 5.0
    private let repository: PreventorRepository
    private let max = 5
    private var count = 0
    
    init(repository: PreventorRepository) {
        self.repository = repository
    }
    
    override func handleDispatch(action: ReduxAction,
                                 store: DispatcherObject,
                                 parent: DispatcherObject?) {
        guard let action = action as? PhoneNumberAction else { return }
        switch action {
        case let .validateOTP(otp):
            validateOTP(otp)
        case let .sendOtpPhone(phoneCountryCode, phone):
            sendOtpPhone(phoneCountryCode: phoneCountryCode,
                         phone: phone)
        default: break
        }
    }
    
    private func sendOtpPhone(phoneCountryCode: String, phone: String) {
        repository.sendOtp(
            request: .init(type: .SMS, phone: "\(phoneCountryCode)\(phone)"),
            success: {[weak self] result in
//                if result.sent == SentStatus.OK.rawValue {
                    PSDKSession.shared.setPhone(phone: phone)
                    PSDKSession.shared.setPhoneCountryCode(phoneCountryCode: phoneCountryCode)
                    self?.store?.dispatch(PhoneNumberAction.updateScreen(screen: .otpPhone))
//                }
            },
            failure: {[weak self] error in
                self?.biometricsFailed()
            })
    }
    
    private func validateOTP(_ code: String) {
        repository.validateOtp(
            request: .init(type: .SMS, phone: PSDKSession.shared.getPhone(), code: code),
            success: {[weak self] result in
                //if result.validation == SentStatus.OK.rawValue {
                    self?.store?.parent?.dispatch(ModulePersonalInfoAction.nextScreen)
                //}
            },
            failure: {[weak self] error in
                self?.biometricsFailed()
            })
        
    }
    
}
