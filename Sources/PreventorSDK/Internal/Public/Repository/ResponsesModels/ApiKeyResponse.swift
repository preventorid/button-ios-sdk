//
//  ApiKeyResponse.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 4/02/22.
//

import Foundation

struct ApiKeyResponse: Codable {
    
    var valid: Bool = false
    
}

struct AuthTokenResponse: Codable {
    
    let token: String
    let expiracy: Int
    
}
