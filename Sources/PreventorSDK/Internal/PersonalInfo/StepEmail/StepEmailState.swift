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
        
    }
    
    let screen: Screen
    let otpError: Bool
    let seconds: Double?
    let showTimer: Bool
    
    init(screen: Screen = .email,
         otpError: Bool = false,
         seconds: Double? = nil,
         showTimer: Bool = false) {
        self.screen = screen
        self.otpError = otpError
        self.seconds = seconds
        self.showTimer = showTimer
    }
    
}
