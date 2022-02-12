//
//  ValidantingReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 10/02/22.
//

import Foundation


class ValidantingReducer: ReduxReducer<ValidantingState> {
    
    override func reduce(state: ValidantingState, action: ReduxAction) -> ValidantingState {
        guard let action = action as? ValidantingAction else { return state }
        switch action {
        case let .updateScreen(screen):
            return .init(screen: screen)
        case let .handleResult(resultType):
            return .init(screen: .result, resultType: resultType)
        default: return state
        }
    }
    
}
