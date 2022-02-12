//
//  StartReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation

class StartReducer: ReduxReducer<StartState> {
    
    static func reduce(currentState: StartState, for action: ReduxAction) -> StartState {
        guard let action = action as? StartAction else { return currentState }
        switch action {
        case let .setError(error):
            return StartState(error: error)
        case let .setLoading(isLoading):
            return .init(loading: isLoading, error: currentState.error)
        default:
            return currentState
        }
    }
    
}
