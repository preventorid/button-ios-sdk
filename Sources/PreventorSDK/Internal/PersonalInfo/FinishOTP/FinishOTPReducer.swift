//
//  FinishOTPReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 30/12/21.
//

import Foundation

class FinishOTPReducer: ReduxReducer<FinishOTPState> {
    
    override func reduce(state: FinishOTPState, action: ReduxAction) -> FinishOTPState {
        guard let action = action as? FinishOtpAction else {
            return state
        }
        switch action {
        case let .updateScreen(screen):
            return .init(onValidation: false,
                         screen: screen)
        default: return state
        }
        
    }
    
}
