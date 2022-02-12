//
//  PhoneNumberReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 12/01/22.
//

class PhoneNumberReducer: ReduxReducer<PhoneNumberState> {
    
    override func reduce(state: PhoneNumberState, action: ReduxAction) -> PhoneNumberState {
        guard let action = action as? PhoneNumberAction else { return state }
        switch action {
        case let .updateScreen(screen):
            return .init(screen: screen)
        default: return state
        }
    }
    
}
