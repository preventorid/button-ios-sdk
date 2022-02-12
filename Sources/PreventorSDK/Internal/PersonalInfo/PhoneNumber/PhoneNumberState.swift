//
//  PhoneNumberState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 12/01/22.
//

import Foundation

struct PhoneNumberState: ReduxState {
    
    enum Screen {
        
        case phoneNumber
        case otpPhone
        case verifying
        
    }
    
    let screen: Screen
    
    init(screen: Screen = .phoneNumber) {
        self.screen = screen
    }
    
}
