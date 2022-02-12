//
//  PhoneNumberAction.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 12/01/22.
//

import Foundation

enum PhoneNumberAction: ReduxAction  {
    
    case updateScreen(screen: PhoneNumberState.Screen)
    case sendOtpPhone(phoneCountryCode: String, phone: String)
    case validateOTP(otp: String)
    
}
