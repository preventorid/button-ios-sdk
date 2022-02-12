//
//  SelfieReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 12/01/22.
//

class SelfieReducer: ReduxReducer<SelfieState> {
    
    override func reduce(state: SelfieState, action: ReduxAction) -> SelfieState {
        guard let action = action as? SelfieAction else { return state }
        switch action {
        case let .updateScreen(screen):
            return .init(screen: screen)
        }
    }
    
}
