//
//  Languaje.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 14/01/22.
//

import Foundation

// MARK: - Language
struct Language: Codable {
    let button: ButtonText
    let validation: Validation
    let message: Message
    let label: LabelModel
    let placeholder: Placeholder
    let pages: Pages
    let footer: Footer

    enum CodingKeys: String, CodingKey {
        case button = "Button"
        case validation = "Validation"
        case message = "Message"
        case label = "Label"
        case placeholder = "Placeholder"
        case pages = "Pages"
        case footer = "Footer"
    }
}

// MARK: - ButtonText
struct ButtonText: Codable {
    let verifyMe, loading, next, start: String
    let iamReady, tryAgain, edit, confirm: String
    let save, finish, front, back: String
    let retake, retry, goSettings, no: String
    let yesConfirm, openCamera, send, noReturn: String

    enum CodingKeys: String, CodingKey {
        case verifyMe = "VerifyMe"
        case loading = "Loading"
        case next = "Next"
        case start = "Start"
        case iamReady = "IamReady"
        case tryAgain = "TryAgain"
        case edit = "Edit"
        case confirm = "Confirm"
        case save = "Save"
        case finish = "Finish"
        case front = "Front"
        case back = "Back"
        case retake = "Retake"
        case retry = "Retry"
        case goSettings = "GoSettings"
        case no = "No"
        case yesConfirm = "YesConfirm"
        case openCamera = "OpenCamera"
        case send = "Send"
        case noReturn = "NoReturn"
    }
}

// MARK: - Footer
struct Footer: Codable {
    let poweredBy: String

    enum CodingKeys: String, CodingKey {
        case poweredBy = "PoweredBy"
    }
}

// MARK: - LabelModel
struct LabelModel: Codable {
    let labelRequired: String

    enum CodingKeys: String, CodingKey {
        case labelRequired = "Required"
    }
}

// MARK: - Message
struct Message: Codable {
    let enterTheFollowinglink, anErrorOccurred, noInternet, invalidEmailOrTries: String
    let enablePermissions, sizeImage: String

    enum CodingKeys: String, CodingKey {
        case enterTheFollowinglink = "EnterTheFollowinglink"
        case anErrorOccurred = "AnErrorOccurred"
        case noInternet = "NoInternet"
        case invalidEmailOrTries = "InvalidEmailOrTries"
        case enablePermissions = "EnablePermissions"
        case sizeImage = "SizeImage"
    }
}

// MARK: - Pages
struct Pages: Codable {
    let integrationButtonText: IntegrationButton
    let usage: Usage
    let setting: Setting
    let invite: GenericView
    let letsGetYouVerified: LetsGetYouVerified
    let secureLinkSent: SecureLinkSent
    let start: GenericView
    let prepareSteps: PrepareSteps
    let chooseCountry: GenericView
    let chooseDocument: GenericView
    let globalDocument: GlobalDocument
    let prepareSelfie: GenericView
    let cameraSelfie: CameraSelfie
    let verifyingIdentity: ContinueOnboarding
    let tryAgainDocument, tryAgainSelfie: GenericView
    let personalInformation: PersonalInformation
    let editPersonalInformation: EditPersonalInformation
    let email: GenericView
    let emailVerification: Verification
    let phone: GenericView
    let phoneVerification: Verification
    let continueOnboarding: ContinueOnboarding
    let identityVerificationSubmitted, streamLineSubmitted: GenericView
    let congratulations: Congratulations
    let deniedAccessCamera: DeniedAccessCamera
    let cancelVerification, error: GenericView

    enum CodingKeys: String, CodingKey {
        case integrationButtonText = "IntegrationButton"
        case usage = "Usage"
        case setting = "Setting"
        case invite = "Invite"
        case letsGetYouVerified = "LetsGetYouVerified"
        case secureLinkSent = "SecureLinkSent"
        case start = "Start"
        case prepareSteps = "PrepareSteps"
        case chooseCountry = "ChooseCountry"
        case chooseDocument = "ChooseDocument"
        case globalDocument = "GlobalDocument"
        case prepareSelfie = "PrepareSelfie"
        case cameraSelfie = "CameraSelfie"
        case verifyingIdentity = "VerifyingIdentity"
        case tryAgainDocument = "TryAgainDocument"
        case tryAgainSelfie = "TryAgainSelfie"
        case personalInformation = "PersonalInformation"
        case editPersonalInformation = "EditPersonalInformation"
        case email = "Email"
        case emailVerification = "EmailVerification"
        case phone = "Phone"
        case phoneVerification = "PhoneVerification"
        case continueOnboarding = "ContinueOnboarding"
        case identityVerificationSubmitted = "IdentityVerificationSubmitted"
        case streamLineSubmitted = "StreamLineSubmitted"
        case congratulations = "Congratulations"
        case deniedAccessCamera = "DeniedAccessCamera"
        case cancelVerification = "CancelVerification"
        case error = "Error"
    }
}

// MARK: - CameraSelfie
struct CameraSelfie: Codable {
    let correct, outside, far: GenericView

    enum CodingKeys: String, CodingKey {
        case correct = "Correct"
        case outside = "Outside"
        case far = "Far"
    }
}

// MARK: - GenericView
struct GenericView: Codable {
    let title, subTitle: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case subTitle = "SubTitle"
    }
}

// MARK: - Congratulations
struct Congratulations: Codable {
    let title: String
    let subTitle: SubTitle

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case subTitle = "SubTitle"
    }
}

// MARK: - SubTitle
struct SubTitle: Codable {
    let identityVerification, streamline: String

    enum CodingKeys: String, CodingKey {
        case identityVerification = "IdentityVerification"
        case streamline = "Streamline"
    }
}

// MARK: - ContinueOnboarding
struct ContinueOnboarding: Codable {
    let title: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
    }
}

// MARK: - DeniedAccessCamera
struct DeniedAccessCamera: Codable {
    let title, subTitleMicroFrontEnd, subTitleMobile: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case subTitleMicroFrontEnd = "SubTitleMicroFrontEnd"
        case subTitleMobile = "SubTitleMobile"
    }
}

// MARK: - EditPersonalInformation
struct EditPersonalInformation: Codable {
    let nameTab, addressTab, nationalityTab: ContinueOnboarding

    enum CodingKeys: String, CodingKey {
        case nameTab = "NameTab"
        case addressTab = "AddressTab"
        case nationalityTab = "NationalityTab"
    }
}

// MARK: - Verification
struct Verification: Codable {
    let title, subTitle, resend: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case subTitle = "SubTitle"
        case resend = "Resend"
    }
}

// MARK: - GlobalDocument
struct GlobalDocument: Codable {
    let passport, driverLicense, idCard, visa, global: GenericView
    let subTitle2: String

    enum CodingKeys: String, CodingKey {
        case passport = "Passport"
        case driverLicense = "DriverLicense"
        case idCard = "IdCard"
        case visa = "Visa"
        case global = "Global"
        case subTitle2 = "SubTitle2"
    }
}

// MARK: - IntegrationButton
struct IntegrationButton: Codable {
    let title, subTitle, menuTitle, theme: String
    let usage, website, contact, verifications: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case subTitle = "SubTitle"
        case menuTitle = "MenuTitle"
        case theme = "Theme"
        case usage = "Usage"
        case website = "Website"
        case contact = "Contact"
        case verifications = "Verifications"
    }
}

// MARK: - LetsGetYouVerified
struct LetsGetYouVerified: Codable {
    let title: String
    let option1, option2: Option
    let prepareDocument, useSmartphone: PrepareDocument
    let privacyPolicy, dontHaveSmartphone, letsGetYouVerifiedContinue: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case option1 = "Option1"
        case option2 = "Option2"
        case prepareDocument = "PrepareDocument"
        case useSmartphone = "UseSmartphone"
        case privacyPolicy = "PrivacyPolicy"
        case dontHaveSmartphone = "DontHaveSmartphone"
        case letsGetYouVerifiedContinue = "Continue"
    }
}

// MARK: - Option
struct Option: Codable {
    let label, title, optionDescription: String

    enum CodingKeys: String, CodingKey {
        case label = "Label"
        case title = "Title"
        case optionDescription = "Description"
    }
}

// MARK: - PrepareDocument
struct PrepareDocument: Codable {
    let title, prepareDocumentDescription: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case prepareDocumentDescription = "Description"
    }
}

// MARK: - PersonalInformation
struct PersonalInformation: Codable {
    let cardPersonalInformation: CardPersonalInformation
    let cardAddress: ContinueOnboarding
    let cardDocument: CardDocument

    enum CodingKeys: String, CodingKey {
        case cardPersonalInformation = "CardPersonalInformation"
        case cardAddress = "CardAddress"
        case cardDocument = "CardDocument"
    }
}

// MARK: - CardDocument
struct CardDocument: Codable {
    let title, idType, idNumber, issuingBy: String
    let issuedDate, expiryDate: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case idType = "IdType"
        case idNumber = "IdNumber"
        case issuingBy = "IssuingBy"
        case issuedDate = "IssuedDate"
        case expiryDate = "ExpiryDate"
    }
}

// MARK: - CardPersonalInformation
struct CardPersonalInformation: Codable {
    let title: String
    let sex: Sex
    let nationality, dob, age: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case sex = "Sex"
        case nationality = "Nationality"
        case dob = "Dob"
        case age = "Age"
    }
}

// MARK: - Sex
struct Sex: Codable {
    let male, female: String

    enum CodingKeys: String, CodingKey {
        case male = "Male"
        case female = "Female"
    }
}

// MARK: - PrepareSteps
struct PrepareSteps: Codable {
    let title: String
    let steps: Steps
    let agreements: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case steps = "Steps"
        case agreements = "Agreements"
    }
}

// MARK: - Steps
struct Steps: Codable {
    let step1, step2, step3, step4: String

    enum CodingKeys: String, CodingKey {
        case step1 = "Step1"
        case step2 = "Step2"
        case step3 = "Step3"
        case step4 = "Step4"
    }
}

// MARK: - SecureLinkSent
struct SecureLinkSent: Codable {
    let title, subTitle, subTitle2, didntReceiveTheText: String
    let resendLink: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case subTitle = "SubTitle"
        case subTitle2 = "SubTitle2"
        case didntReceiveTheText = "DidntReceiveTheText"
        case resendLink = "ResendLink"
    }
}

// MARK: - Setting
struct Setting: Codable {
    let title, logo, logoParameters, url: String
    let selectFlow, button, backgroundColor, fontColor: String
    let steps, themeColor, font, selectFont: String
    let browse, heading, paragraph: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case logo = "Logo"
        case logoParameters = "LogoParameters"
        case url = "Url"
        case selectFlow = "SelectFlow"
        case button = "Button"
        case backgroundColor = "BackgroundColor"
        case fontColor = "FontColor"
        case steps = "Steps"
        case themeColor = "ThemeColor"
        case font = "Font"
        case selectFont = "SelectFont"
        case browse = "Browse"
        case heading = "Heading"
        case paragraph = "Paragraph"
    }
}

// MARK: - Usage
struct Usage: Codable {
    let verifications, playground: String

    enum CodingKeys: String, CodingKey {
        case verifications = "Verifications"
        case playground = "Playground"
    }
}

// MARK: - Placeholder
struct Placeholder: Codable {
    let selectTypeId, fullName, firstName, middleName: String
    let surname, address, state, city: String
    let zipCode, country, nationality, dob: String
    let emailAddress, verificationCode, phoneNumber, passport: String
    let driverLicense, idCard, visa, enterEmail: String
    let enterPhone: String

    enum CodingKeys: String, CodingKey {
        case selectTypeId = "SelectTypeId"
        case fullName = "FullName"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case surname = "Surname"
        case address = "Address"
        case state = "State"
        case city = "City"
        case zipCode = "ZipCode"
        case country = "Country"
        case nationality = "Nationality"
        case dob = "Dob"
        case emailAddress = "EmailAddress"
        case verificationCode = "VerificationCode"
        case phoneNumber = "PhoneNumber"
        case passport = "Passport"
        case driverLicense = "DriverLicense"
        case idCard = "IdCard"
        case visa = "Visa"
        case enterEmail = "EnterEmail"
        case enterPhone = "EnterPhone"
    }
}

// MARK: - Validation
struct Validation: Codable {
    let fieldRequired, enterVerificationCode: String
    let email: Email
    let phoneNumber: PhoneNumber

    enum CodingKeys: String, CodingKey {
        case fieldRequired = "FieldRequired"
        case enterVerificationCode = "EnterVerificationCode"
        case email = "Email"
        case phoneNumber = "PhoneNumber"
    }
}

// MARK: - Email
struct Email: Codable {
    let invalid, pleaseEnter, noInvited: String

    enum CodingKeys: String, CodingKey {
        case invalid = "Invalid"
        case pleaseEnter = "PleaseEnter"
        case noInvited = "NoInvited"
    }
}

// MARK: - PhoneNumber
struct PhoneNumber: Codable {
    let invalid, invalidCountryCode, tooShort, tooLong: String
    let pleaseEnter: String

    enum CodingKeys: String, CodingKey {
        case invalid = "Invalid"
        case invalidCountryCode = "InvalidCountryCode"
        case tooShort = "TooShort"
        case tooLong = "TooLong"
        case pleaseEnter = "PleaseEnter"
    }
}
