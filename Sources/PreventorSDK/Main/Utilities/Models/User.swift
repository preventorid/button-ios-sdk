//
//  User.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 20/01/22.
//

import DocumentReader

struct Credentials {
    
    var xApiKey: String = "cnHl9mV33g6cE5TRg7PAK4xbC7i3m6o5iS56ZNoj"
    var xTenant: String = "preventordev"
    var xEnv: String = "playground"
    var xBanknu: String = "1"
    var secret: String = "preventor$$2021"
    
}

struct Config {
    
    var flowType: String = "WF-01_7581390e-3938-44bf-8cd2-4f97e9306510"
    var credentials: Credentials = Credentials()
    var cifCode: String = "CIFCODE-OK-SALGUERO-SO-130"
    
}

struct User {
    
    var config: Config = Config()
    var onboardingData: OnboardingData? = nil
    var data: UserDataModel = .init()
    var ocrValidations: [OcrValidationsResponse]? = nil
    
}

struct OnboardingData {
    
    let token: String
    let expiracy: Int
    let user: String
    let ticket: String
    
    init(from result: OnboardingResponse){
        token = result.token ?? ""
        expiracy = result.expiracy ?? 0
        user = result.user ?? ""
        ticket = result.ticket ?? ""
    }
    
}

struct UserDataModel {
    
    let fullName: String
    let givenNames: String
    let firstName: String
    let middleName: String
    let lastName: String
    let surnames: String
    let surname: String
    let secondSurname: String
    let gender: String
    let age: String
    let address: String
    let addressCountry: String
    let city: String
    let state: String
    let zipCode: String
    let dateOfBirth: String
    let nationality: String
    let type: String
    let maritalStatus: String
    let category: String
    let documentNumber: String
    let documentIssuingCountry: String
    let documentIssuingDate: String
    let documentExpirationDate: String
        
    init(fullName: String = "",
         givenNames: String = "",
         firstName: String = "",
         middleName: String = "",
         lastName: String = "",
         surnames: String = "",
         surname: String = "",
         secondSurname: String = "",
         gender: String = "",
         age: String = "",
         address: String = "",
         addressCountry: String = "",
         city: String = "",
         state: String = "",
         zipCode: String = "",
         dateOfBirth: String = "",
         nationality: String = "",
         type: String = "",
         maritalStatus: String = "",
         category: String = "",
         documentNumber: String = "",
         documentIssuingCountry: String = "",
         documentIssuingDate: String = "",
         documentExpirationDate: String = ""
    ) {
        self.fullName = fullName
        self.givenNames = givenNames
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.surnames = surnames
        self.surname = surname
        self.secondSurname = secondSurname
        self.gender = gender
        self.age = age
        self.address = address
        self.addressCountry = addressCountry
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.type = type
        self.maritalStatus = maritalStatus
        self.category = category
        self.documentNumber = documentNumber
        self.documentIssuingCountry = documentIssuingCountry
        self.documentIssuingDate = documentIssuingDate
        self.documentExpirationDate = documentExpirationDate
    }
    
    func toContinueOnboardingRequest() -> ContinueOnboardingRequest{
        .init(fullName: fullName,
              firstName: firstName,
              middleName: middleName,
              surname: surname,
              secondSurname: secondSurname,
              address: address,
              city: city,
              state: state,
              zipCode: zipCode,
              addressCountry: addressCountry,
              dateOfBirth: dateOfBirth,
              nationality: nationality,
              phone: .init(phoneCountryCode: PSDKSession.shared.getPhoneCountryCode(),
                           phoneNumber: PSDKSession.shared.getPhone()),
              email: PSDKSession.shared.getEmail() ?? "",
              givenNames: givenNames,
              surnames: surnames,
              lastName: lastName,
              gender: gender,
              age: age,
              maritalStatus: maritalStatus,
              category: category,
              type: type,
              documentNumber: documentNumber,
              documentIssuingCountry: documentIssuingCountry,
              documentIssuingDate: documentIssuingDate,
              documentExpirationDate: documentExpirationDate)
    }
    
}


extension UserDataModel {
    
    init(from data: UserDataModelResponse) {
        fullName = data.fullName ?? ""
        firstName = data.firstName ?? ""
        middleName = data.middleName ?? ""
        givenNames = data.givenNames ?? ""
        lastName = data.lastName ?? ""
        surnames = data.surnames ?? ""
        surname = data.surname ?? ""
        secondSurname = data.secondSurname ?? ""
        gender = data.gender ?? ""
        age = data.age ?? ""
        address = data.address ?? ""
        addressCountry = data.addressCountry ?? ""
        city = data.city ?? ""
        state = data.state ?? ""
        zipCode = data.zipCode ?? ""
        dateOfBirth = data.dateOfBirth ?? ""
        nationality = data.nationality ?? ""
        type = data.type ?? ""
        maritalStatus = data.maritalStatus ?? ""
        category = data.category ?? ""
        documentNumber = data.documentNumber ?? ""
        documentIssuingCountry = data.documentIssuingCountry ?? ""
        documentIssuingDate = data.documentIssuingDate ?? ""
        documentExpirationDate = data.documentExpirationDate ?? ""
    }
    
    init(from data: DocumentReaderResults) {
        self.givenNames = data.getTextFieldValueByType(fieldType: .ft_Given_Names) ?? ""
        let names = givenNames.split(separator: " ")
        self.firstName = names.first?.description ?? ""
        self.middleName = names.count > 1 ? names[1].description : ""
        self.lastName = names.last?.description ?? ""
        self.fullName = data.getTextFieldValueByType(fieldType: .ft_Surname_And_Given_Names) ?? ""
        let surname = data.getTextFieldValueByType(fieldType: .ft_Surname) ?? ""
        let secondSurname = data.getTextFieldValueByType(fieldType: .ft_Second_Surname) ?? ""
        self.surname = surname
        self.secondSurname = secondSurname
        self.surnames = surname + " " + secondSurname
        self.gender = data.getTextFieldValueByType(fieldType: .ft_Sex) ?? ""
        self.age = data.getTextFieldValueByType(fieldType: .ft_Age) ?? ""
        self.address = data.getTextFieldValueByType(fieldType: .ft_Address) ?? ""
        self.addressCountry = data.getTextFieldValueByType(fieldType: .ft_Address_Country) ?? ""
        self.city = data.getTextFieldValueByType(fieldType: .ft_Address_City) ?? ""
        self.state = data.getTextFieldValueByType(fieldType: .ft_Address_State) ?? ""
        self.zipCode = data.getTextFieldValueByType(fieldType: .ft_Address_Zipcode) ?? ""
        self.dateOfBirth = data.getTextFieldValueByType(fieldType: .ft_Date_of_Birth) ?? ""
        self.nationality = data.getTextFieldValueByType(fieldType: .ft_Nationality) ?? ""
        self.documentIssuingDate = data.getTextFieldValueByType(fieldType: .ft_Date_of_Issue) ?? ""
        self.documentExpirationDate = data.getTextFieldValueByType(fieldType: .ft_Date_of_Expiry) ?? ""
        self.documentIssuingCountry = data.getTextFieldValueByType(fieldType: .ft_Issuing_State_Name) ?? ""
        self.maritalStatus = data.getTextFieldValueByType(fieldType: .ft_Marital_Status) ?? ""
        self.category = data.getTextFieldValueByType(fieldType: .ft_Category) ?? ""
        self.documentNumber = data.getTextFieldValueByType(fieldType: .ft_Personal_Number) ?? ""
        if let docType = data.documentType?.first?.dType {
            switch docType {
            case .identityCard:
                type = LanguageManager.shared.language.placeholder.idCard
            case .passport:
                type = LanguageManager.shared.language.placeholder.passport
            case .visa:
                type = LanguageManager.shared.language.placeholder.visa
            case .driverCard:
                type = LanguageManager.shared.language.placeholder.driverLicense
            default:
                type = ""
            }
        } else {
            type = ""
        }
    }
}
