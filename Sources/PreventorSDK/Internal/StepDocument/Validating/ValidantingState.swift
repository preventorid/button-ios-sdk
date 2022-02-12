//
//  ValidantingState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 10/02/22.
//

import Foundation

struct ValidantingState: ReduxState {
    
    enum Screen {
        
        case verifying
        case result
        
    }
    
    let resultType: SelfieResultType?
    let screen: Screen
    
    init(screen: Screen = .verifying,
         resultType: SelfieResultType? = nil) {
        self.screen = screen
        self.resultType = resultType
    }

}

