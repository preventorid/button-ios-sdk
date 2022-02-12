//
//  CameraDeniedReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation

class CameraDeniedReducer: ReduxReducer<CameraDeniedState> {
    
    static func reduce(currentState: CameraDeniedState, for action: ReduxAction) -> CameraDeniedState {
        guard let action = action as? CameraDeniedAction else { return currentState }
        switch action {
            
        default:
            return currentState
        }
    }
    
}
