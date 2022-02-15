//
//  StepEmailReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 28/12/21.
//

import Foundation

class StepEmailReducer: ReduxReducer<StepEmailState> {
    
    override func reduce(state: StepEmailState, action: ReduxAction) -> StepEmailState {
        guard let action = action as? StepEmailAction else { return state }
        switch action {
        case let .updateScreen(screen):
            return .init(screen: screen)
        case .validateEmailError(_):
            return .init(screen: state.screen,
                         otpError: true)
        case let .showOtpScreen(seconds):
            return .init(screen: .otpEmail,
                         seconds: seconds,
                         showTimer: true)
        case .hiddeTimer:
            return .init(screen: .otpEmail,
                         showTimer: false)
        default: return state
        }
    }
    
}
