//
//  PersonalInfoState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import Foundation

struct PersonalInfoState: ReduxState {
    
    enum Screen {
        
        case verifing
        case result
        
    }
    
    let screen: Screen
    let resultType: SelfieResultType?
    
    init(screen: Screen = .verifing,
         resultType: SelfieResultType? = nil) {
        self.screen = screen
        self.resultType = resultType
    }
    
}
