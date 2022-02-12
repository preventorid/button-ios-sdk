//
//  GeneralSettingsResponse.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 9/02/22.
//

import Foundation

// MARK: - GeneralSettingsResponse
struct GeneralSettingsResponse: Codable {
    let identityDocuments: [IdentityDocument]
    let biometricAuthentications: [BiometricAuthentication]
    let countryRestriction: CountryRestriction
    let deviceTracking: DeviceTracking
    let gdpr: Gdpr
    let theme: Theme
    let defaultWorkflow: Workflow
    let workflows: [Workflow]

    enum CodingKeys: String, CodingKey {
        case identityDocuments = "identity_documents"
        case biometricAuthentications = "biometric_authentications"
        case countryRestriction = "country_restriction"
        case deviceTracking = "device_tracking"
        case gdpr, theme
        case defaultWorkflow = "default_workflow"
        case workflows
    }
}

// MARK: - BiometricAuthentication
struct BiometricAuthentication: Codable {
    let authenticationType: String
    let enabled: Bool

    enum CodingKeys: String, CodingKey {
        case authenticationType = "authentication_type"
        case enabled
    }
}

// MARK: - CountryRestriction
struct CountryRestriction: Codable {
    let restrictionScreenEnabled: Bool
    let allowedCountries: [String]

    enum CodingKeys: String, CodingKey {
        case restrictionScreenEnabled = "restriction_screen_enabled"
        case allowedCountries = "allowed_countries"
    }
}

// MARK: - Workflow
struct Workflow: Codable {
    let name, id: String
    let verifications: [VerificationModel]
}

// MARK: - Verification
struct VerificationModel: Codable {
    let id, name: String
    let orderNumber: Int
    let verificationRequired, verificationOrderLocked, checksOrderLocked: Bool
    let checks: [Check]

    enum CodingKeys: String, CodingKey {
        case id, name
        case orderNumber = "order_number"
        case verificationRequired = "required"
        case verificationOrderLocked = "verification_order_locked"
        case checksOrderLocked = "checks_order_locked"
        case checks
    }
}

// MARK: - Check
struct Check: Codable {
    let name, id: String
    let orderNumber: Int
    let enabled, checkRequired: Bool?
    let dependencies: [Dependency]?

    enum CodingKeys: String, CodingKey {
        case name, id
        case orderNumber = "order_number"
        case enabled
        case checkRequired = "required"
        case dependencies
    }
}

// MARK: - Dependency
struct Dependency: Codable {
    let verification, check: String
}

// MARK: - DeviceTracking
struct DeviceTracking: Codable {
    let enabled: Bool
}

// MARK: - Gdpr
struct Gdpr: Codable {
    let dataRetentionDaysAmount: Int
    let automaticRemoval: Bool

    enum CodingKeys: String, CodingKey {
        case dataRetentionDaysAmount = "data_retention_days_amount"
        case automaticRemoval = "automatic_removal"
    }
}

// MARK: - IdentityDocument
struct IdentityDocument: Codable {
    let enabled: Bool
    let documentType: String

    enum CodingKeys: String, CodingKey {
        case enabled
        case documentType = "document_type"
    }
}

// MARK: - Theme
struct Theme: Codable {
    let accentColor: ColorModel
    let logo, language: String
    let buttonsColor: ColorModel
    let fontFamily: FontFamily

    enum CodingKeys: String, CodingKey {
        case accentColor = "accent_color"
        case logo, language
        case buttonsColor = "buttons_color"
        case fontFamily = "font_family"
    }
}

// MARK: - ColorModel
struct ColorModel: Codable {
    let colorDefault: DeviceTracking
    let custom: Custom

    enum CodingKeys: String, CodingKey {
        case colorDefault = "default"
        case custom
    }
}

// MARK: - Custom
struct Custom: Codable {
    let value: String
    let enabled: Bool
}

// MARK: - FontFamily
struct FontFamily: Codable {
    let paragraphButtons, heading: String

    enum CodingKeys: String, CodingKey {
        case paragraphButtons = "paragraph_buttons"
        case heading
    }
}
