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
    
    init(screen: Screen = .verifing) {
        self.screen = screen
    }
    
}
