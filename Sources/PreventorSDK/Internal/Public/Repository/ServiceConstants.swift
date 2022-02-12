//
//  ServiceConstantes.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 20/01/22.
//

import SwiftUI

struct ServiceConstants {
    
    static var envPath: String {
    #if DEV
        print("enviroment is DEV")
        return "dev"
    #elseif SANDBOX
        print("enviroment is SANDBOX")
        return "uat"
    #else
        print("not found environment: default release ")
        return "prod"
    #endif
    }
    
    static let HEALTH_CHECK_URL = "https://fl26t9vq8l.execute-api.us-east-2.amazonaws.com/\(envPath)/id/health"
    static let BASE_URL = "https://fl26t9vq8l.execute-api.us-east-2.amazonaws.com/\(envPath)/"
    static let BASE_URL_PVTID = "https://fl26t9vq8l.execute-api.us-east-2.amazonaws.com/\(envPath)/id/"
    static let LANGUAGE_CENTER_FILE = "https://cdn.preventor.com"
    
}

extension ServiceConstants {
    
    static let generalSettings = BASE_URL_PVTID + "v1/identity/settings/sdk/general"
    static let onboarding = BASE_URL_PVTID + "v1/identity/onboarding"
    static let cachedTransaction =  BASE_URL + "engine/transaction/{ticket}/status"
    static let sendOtp = BASE_URL + "engine/notifications/otp/transaction/{ticket}/generate"
    static let validateOtp = BASE_URL + "engine/notifications/otp/transaction/{ticket}/validate"
    static let continueOnboarding = BASE_URL + "engine/compliance/transaction/{ticket}"
    
}
