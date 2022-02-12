//
//  StepEmailMiddleware.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/01/22.
//

final class StepEmailMiddleware: PSDKReduxMiddleware<StepEmailState> {
    
    private let repository: PreventorRepository
    
    init(repository: PreventorRepository) {
        self.repository = repository
    }
    
    override func handleDispatch(action: ReduxAction,
                                 store: DispatcherObject,
                                 parent: DispatcherObject?) {
        guard let action = action as? StepEmailAction else {
            return
        }
        
        switch action {
        case let .sendOtpEmail(email):
            sendOtpEmail(email: email)
        case let .validateOtpEmail(code):
            validateOtpEmail(code: code)
        default: break
        }
    }
    
    private func sendOtpEmail(email: String) {
        repository.sendOtp(
            request: .init(type: .EMAIL, email: email),
            success: {[weak self] result in
                if result.sent == SentStatus.OK.rawValue {
                    PSDKSession.shared.setEmail(email: email)
                    self?.store?.dispatch(StepEmailAction.updateScreen(screen: .otpEmail))
                }
            },
            failure: {[weak self] error in
                self?.biometricsFailed()
            })
    }
    
    private func validateOtpEmail(code: String) {
        repository.validateOtp(
            request: .init(type: .EMAIL, email: PSDKSession.shared.getEmail(), code: code),
            success: {[weak self] result in
                if result.validation == SentStatus.OK.rawValue {
                    self?.store?.parent?.dispatch(ModulePersonalInfoAction.nextScreen)
                }
            },
            failure: {[weak self] error in
                self?.biometricsFailed()
            })
    }
    
}
