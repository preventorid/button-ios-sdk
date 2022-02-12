//
//  UserDataResponse.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/01/22.
//

struct UserDataResponse: Decodable {
    
    let status: String?
    let data: UserDataModelResponse?
    let ocrValidations: [OcrValidationsResponse]?
    let error: UserDataResponseError?
    
    init(data: UserDataModelResponse?) {
        self.status = nil
        self.data = data
        self.ocrValidations = nil
        self.error = nil
    }
}

struct UserDataResponseError: Decodable {
    
    let process: String?
    let message: String?
    let code: String?
    
}

struct OcrValidationsResponse: Decodable {
    
    let fieldName: String
    let required: String
    
}

struct UserDataModelResponse: Decodable {
    
    let fullName: String?
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let givenNames: String?
    let surnames: String?
    let surname: String?
    let secondSurname: String?
    let age: String?
    let address: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let addressCountry: String?
    let dateOfBirth: String?
    let nationality: String?
    let documentNumber: String?
    let documentIssuingDate: String?
    let documentIssuingCountry: String?
    let documentExpirationDate: String?
    let category: String?
    let maritalStatus: String?
    let type: String?
    let gender: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "fullname"
        case firstName = "first_name"
        case middleName = "middle_name"
        case givenNames = "given_names"
        case lastName = "last_name"
        case surname
        case surnames = "surnames"
        case secondSurname = "second_surname"
        case age
        case address
        case city = "city"
        case state = "state"
        case zipCode = "zipcode"
        case addressCountry = "address_country"
        case dateOfBirth = "date_of_birth"
        case nationality = "nationality"
        case documentNumber = "document_number"
        case documentIssuingDate = "document_issuing_date"
        case documentIssuingCountry = "document_issuing_country"
        case documentExpirationDate = "document_expiration_date"
        case category
        case maritalStatus = "marital_status"
        case type
        case gender
        
    }
    
}
