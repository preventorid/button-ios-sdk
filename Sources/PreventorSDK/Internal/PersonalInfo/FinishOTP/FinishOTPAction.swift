//
//  FinishOtpAction.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 30/12/21.
//

import Foundation

enum FinishOtpAction: ReduxAction {
    
    case updateScreen(screen: FinishOTPState.Screen)
    case continueOnboarding
    
}
