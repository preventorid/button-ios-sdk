//
//  File.swift
//  
//
//  Created by Alexander Rodriguez on 3/02/22.
//

import Foundation

enum OtpType: String, Encodable {
    
    case EMAIL
    case SMS
    
}

struct OtpRequest: Encodable {
    
    let type: String
    let email: String?
    let phone: String?
    
    init(type: OtpType,
         email: String? = nil,
         phone: String? = nil) {
        self.type = type.rawValue
        self.email = email
        self.phone = phone
    }
    
}

struct ValidateOtpRequest: Encodable {
    let type: String
    let email: String?
    let phone: String?
    let code: String
    
    init(type: OtpType,
         email: String? = nil,
         phone: String? = nil,
         code: String) {
        self.type = type.rawValue
        self.email = email
        self.phone = phone
        self.code = code
    }
    
}
