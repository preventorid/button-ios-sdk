//
//  StepEmailState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 28/12/21.
//

struct StepEmailState: ReduxState {
    
    enum Screen {
        
        case email
        case otpEmail
        case verifying
        
    }
    
    let screen: Screen
    let otpError: Bool
    
    init(screen: Screen = .email,
         otpError: Bool = false) {
        self.screen = screen
        self.otpError = otpError
    }
    
}
