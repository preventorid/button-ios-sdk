//
//  SelfieState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 12/01/22.
//

import SwiftUI

struct SelfieState: ReduxState {
    
    enum Screen {
        
        case intro
        case selfie
        
    }
    
    let screen: Screen
    
    init(screen: Screen = .intro) {
        self.screen = screen
    }

}


