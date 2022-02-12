//
//  File.swift
//  
//
//  Created by Alexander Rodriguez on 31/01/22.
//

import Foundation

struct OtpResponse: Decodable {
    
    let status: Int?
    let code: String?
    let sent: String?
    let message: String?
    
}

enum SentStatus: String {
    
    case OK
    
}

struct ValidateOtpResponse: Decodable {
    
    let status: Int?
    let code: String?
    let validation: String?
    let message: String
    
}
