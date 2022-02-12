//
//  FinishOTPMiddleware.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 30/12/21.
//

import SwiftUI

final class FinishOTPMiddleware: PSDKReduxMiddleware<FinishOTPState> {

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
        guard let action = action as? FinishOtpAction else { return }
        switch action {
        case .continueOnboarding:
            continueOnboarding()
        default: break
        }
    }
    
    private func callCachedTransaction() {
        if count < max {
            self.biometricsFailed()
            return
        }
        count += 1
        self.repository.cachedTransaction(
            ticket: PSDKSession.shared.getTicket(),
            success: { [weak self] response in
                guard let status = TransactionStatus(rawValue: response.status ?? "") else {
                    return
                }
                switch status {
                case .AWAITING, .VERIFIED:
                    PSDKSession.shared.setUser(user: response)
                    PreventorSDK.shared.delegate?.onSubmitted()
                    self?.store?.dispatch(FinishOtpAction.updateScreen(screen: .congratulations))
                case .FAILED:
                    self?.biometricsFailed()
                    break
                default:
                    self?.callCachedTransaction()
                    break
                }
            },
            failure: { [weak self] error in
                print(error)
                if !(self?.handleError(error: error) ?? false) {
                    self?.biometricsFailed()
                }
            })
    }
    
    private func continueOnboarding() {
        let userData = PSDKSession.shared.getUserData()
        repository.continueOnboarding(
            request: userData.toContinueOnboardingRequest(),
            success: { [weak self] result in
                self?.callCachedTransaction()
            },
            failure: { [weak self]  error in
                if !(self?.handleError(error: error) ?? false) {
                    self?.biometricsFailed()
                }
            }
        )
    }
    
}
