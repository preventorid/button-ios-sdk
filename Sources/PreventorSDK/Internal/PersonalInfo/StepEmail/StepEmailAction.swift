//
//  StepEmailAction.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 28/12/21.
//

enum StepEmailAction: ReduxAction  {
    
    case updateScreen(screen: StepEmailState.Screen)
    case sendOtpEmail(email: String)
    case validateOtpEmail(code: String)
    case validateEmailError(_ message: String)
    
}
