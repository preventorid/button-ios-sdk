//
//  OnboardingRequest.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 20/01/22.
//

import Lottie

struct OnboardingRequest: Codable {
    
    let transactionType: String
    let documentType: String
    let flow: String
    let cifcode: String
    let portraits: PortraitsRequest
    let documents: PortraitsRequest
    
}

struct PhoneRequest: Codable {
    
    let phoneCountryCode: String?
    let phoneNumber: String?
    
}

struct PortraitsRequest: Codable {
    
    let picture1: String?
    let picture2: String?
    
}

struct ContinuePhoneRequest: Encodable {
    
    let phoneCountryCode: String?
    let phoneNumber: String?
    
    enum CodingKeys: String, CodingKey {
        
        case phoneCountryCode = "phone_country_code"
        case phoneNumber = "phone_number"
    }
    
}

struct ContinueOnboardingRequest: Encodable {
       
    var fullName: String = ""
    var firstName: String = ""
    var middleName: String = ""
    var surname: String = ""
    var secondSurname: String = ""
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var zipCode: String = ""
    var addressCountry: String = ""
    var dateOfBirth: String = ""
    var nationality: String = ""
    let phone: ContinuePhoneRequest
    var email: String = ""
    var givenNames: String = ""
    var surnames: String = ""
    var lastName : String = ""
    var gender: String = ""
    var age: String = ""
    var maritalStatus: String = ""
    var category: String = ""
    var type: String = ""
    var documentNumber: String = ""
    var documentIssuingCountry: String = ""
    var documentIssuingDate: String = ""
    var documentExpirationDate: String = ""
    
    enum CodingKeys: String, CodingKey {
        
        case fullName = "fullname"
        case firstName = "first_name"
        case middleName = "middle_name"
        case surname = "surname"
        case secondSurname = "second_surname"
        case address = "address"
        case city = "city"
        case state = "state"
        case zipCode = "zipcode"
        case addressCountry = "address_country"
        case dateOfBirth = "date_of_birth"
        case nationality = "nationality"
        case phone = "phone"
        case email = "email"
        case givenNames = "given_names"
        case surnames
        case lastName = "last_name"
        case gender
        case age
        case maritalStatus = "marital_status"
        case category
        case type
        case documentNumber = "document_number"
        case documentIssuingCountry = "document_issuing_country"
        case documentIssuingDate = "document_issuing_date"
        case documentExpirationDate = "document_expiration_date"
        
    }

}
