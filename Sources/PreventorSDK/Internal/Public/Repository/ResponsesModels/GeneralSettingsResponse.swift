//
//  GeneralSettingsResponse.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 9/02/22.
//

import Foundation

// MARK: - GeneralSettingsResponse
struct GeneralSettingsResponse: Codable {
    var identityDocuments: [IdentityDocument]
    var biometricAuthentications: [BiometricAuthentication]
    var countryRestriction: CountryRestriction
    var deviceTracking: DeviceTracking
    var gdpr: Gdpr
    var theme: Theme?
    var defaultWorkflow: Workflow? = nil
    var workflows: [Workflow]?

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
    var authenticationType: String = ""
    var enabled: Bool?

    enum CodingKeys: String, CodingKey {
        case authenticationType = "authentication_type"
        case enabled
    }
}

// MARK: - CountryRestriction
struct CountryRestriction: Codable {
    var restrictionScreenEnabled: Bool = false
    var allowedCountries: [String] = []

    enum CodingKeys: String, CodingKey {
        case restrictionScreenEnabled = "restriction_screen_enabled"
        case allowedCountries = "allowed_countries"
    }
}

// MARK: - Workflow
struct Workflow: Codable {
    var name: String = ""
    var id: String = ""
    var verifications: [VerificationModel] = []
}

// MARK: - Verification
struct VerificationModel: Codable {
    var id: String = ""
    var name: String = ""
    var orderNumber: Int = 0
    var verificationRequired: Bool = false
    var verificationOrderLocked: Bool = false
    var checksOrderLocked: Bool = false
    var checks: [Check] = []

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
    var name: String = ""
    var id: String = ""
    var orderNumber: Int = 0
    var enabled: Bool?
    var checkRequired: Bool?
    var dependencies: [Dependency]?

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
    var verification: String = ""
    var check: String = ""
}

// MARK: - DeviceTracking
struct DeviceTracking: Codable {
    var enabled: Bool?
}

// MARK: - Gdpr
struct Gdpr: Codable {
    var dataRetentionDaysAmount: Int = 0
    var automaticRemoval: Bool = false

    enum CodingKeys: String, CodingKey {
        case dataRetentionDaysAmount = "data_retention_days_amount"
        case automaticRemoval = "automatic_removal"
    }
}

// MARK: - IdentityDocument
struct IdentityDocument: Codable {
    var enabled: Bool?
    var documentType: String = ""

    enum CodingKeys: String, CodingKey {
        case enabled
        case documentType = "document_type"
    }
}

// MARK: - Theme
struct Theme: Codable {
    var accentColor: ColorModel?
    var logo: String? = nil
    var language: String = ""
    var buttonsColor: ColorModel
    var fontFamily: FontFamily

    enum CodingKeys: String, CodingKey {
        case accentColor = "accent_color"
        case logo, language
        case buttonsColor = "buttons_color"
        case fontFamily = "font_family"
    }
}

// MARK: - ColorModel
struct ColorModel: Codable {
    var colorDefault: DeviceTracking?
    var custom: Custom

    enum CodingKeys: String, CodingKey {
        case colorDefault = "default"
        case custom
    }
}

// MARK: - Custom
struct Custom: Codable {
    var value: String = ""
    var enabled: Bool?
}

// MARK: - FontFamily
struct FontFamily: Codable {
    var paragraphButtons: String = ""
    var heading: String = ""

    enum CodingKeys: String, CodingKey {
        case paragraphButtons = "paragraph_buttons"
        case heading
    }
}
