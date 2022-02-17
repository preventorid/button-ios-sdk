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
        
    }
    
    let screen: Screen
    let seconds: Double?
    let showTimer: Bool
    
    init(screen: Screen = .phoneNumber,
         seconds: Double? = nil,
         showTimer: Bool = false) {
        self.screen = screen
        self.seconds = seconds
        self.showTimer = showTimer
    }
    
}
