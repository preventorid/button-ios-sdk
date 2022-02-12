//
//  ReduxReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation

// MARK: - Reducer:
/// A Reducer is a class that helps us reduce our current State into a new State, given a specific Action

class ReduxReducer<StateType: ReduxState> {
    
    init() {}
    
    func reduce(state: StateType, action: ReduxAction) -> StateType {
        return state
    }
    
}

class PSDKEmptyReducer<StateType: ReduxState>: ReduxReducer<StateType> {
    
}
