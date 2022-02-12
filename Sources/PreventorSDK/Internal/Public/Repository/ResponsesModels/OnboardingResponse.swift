//
//  OnboardingResponse.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 20/01/22.
//

import Foundation

struct OnboardingResponse: Decodable {
    
    let status: Int?
    let code: String?
    let message: [String]?
    let token: String?
    let expiracy: Int?
    let user: String?
    let ticket: String?
}

struct ErrorResponse: Decodable {
    
    let status: Int?
    let code: String?
    let message: String?
    
}

enum TransactionStatus: String {
    
    case PROCESSING
    case TCKTNTFND
    case AWAITING
    case VERIFIED
    case SUCCESSFUL
    case FAILED
    
}

enum ProcessType: String {
    
    case DOCUMENT_DATA_EXTRACTION
    case GET_TOKEN
    case PHOTO_VERIFICATION
    case PORTRAIT_UPLOAD
    case ENROLLMENT
    
}
