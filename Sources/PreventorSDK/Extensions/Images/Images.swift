//
//  Images.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 16/12/21.
//

import SwiftUI

// MARK: - UIImage Extension

extension UIImage {
    
    static func imageFromLocalBundle(named name: String) -> UIImage {
        guard let image = UIImage(named: name, in: Bundle.psdkUIKitBundle(), compatibleWith: nil) else {
            fatalError("Image not found")
        }
        return image
    }
    
}

extension UIImage {
    
    static var footerLogo: UIImage {
        UIImage.imageFromLocalBundle(named: "footer-logo")
    }
    
    static var biometricsStartCopy: UIImage {
        UIImage.imageFromLocalBundle(named: "biometrics-start-copy")
    }
    
    static var selectDocument: UIImage {
        UIImage.imageFromLocalBundle(named: "select_document")
    }
    
    static var worldCountries: UIImage {
        UIImage.imageFromLocalBundle(named: "world-countries")
    }
    
    static var documentDriverLicense: UIImage {
        UIImage.imageFromLocalBundle(named: "document-driver-license")
    }
    
    static var documentPassport: UIImage {
        UIImage.imageFromLocalBundle(named: "document-passport")
    }
    
    static var documentNationalId: UIImage {
        UIImage.imageFromLocalBundle(named: "document-national-id")
    }
    
    static var documentVisa: UIImage {
        UIImage.imageFromLocalBundle(named: "document-visa")
    }
    
    static var stepEmailIcon: UIImage {
        UIImage.imageFromLocalBundle(named: "step_email_icon")
    }
    
    static var errorOTPFlow: UIImage {
        UIImage.imageFromLocalBundle(named: "error_otp_flow")
    }
    
    static var withoutSignal: UIImage {
        UIImage.imageFromLocalBundle(named: "no_signal")
    }
    
    static var captureOff: UIImage {
        UIImage.imageFromLocalBundle(named: "capture-off")
    }
    
    static var captureOn: UIImage {
        UIImage.imageFromLocalBundle(named: "capture-on")
    }
    
    static var circleGreenFramework: UIImage {
        UIImage.imageFromLocalBundle(named: "circle-green-framework")
    }
    
    static var circleGreenOneTwo: UIImage {
        UIImage.imageFromLocalBundle(named: "circle-green-one-two")
    }
    
    static var circleGreenThree: UIImage {
        UIImage.imageFromLocalBundle(named: "circle-green-three")
    }
    
    static var circleRedOne: UIImage {
        UIImage.imageFromLocalBundle(named: "circle-red-one")
    }
    
    static var biometricsSelfie: UIImage {
        UIImage.imageFromLocalBundle(named: "biometrics_selfie")
    }
    
    static var scanDocumentError: UIImage {
        UIImage.imageFromLocalBundle(named: "scan-document-error")
    }
    
}

// MARK: - Image Extension

extension Image {
    
    static var footerLogo: Image {
        return Image(uiImage: .footerLogo)
    }
    
    static var biometricsStartCopy: Image {
        return Image(uiImage: .biometricsStartCopy)
    }
    
    static var selectDocument: Image {
        return Image(uiImage: .selectDocument)
    }
    
    static var worldCountries: Image {
        return Image(uiImage: .worldCountries)
    }
    
    static var documentDriverLicense: Image {
        return Image(uiImage: .documentDriverLicense)
    }
    
    static var documentPassport: Image {
        return Image(uiImage: .documentPassport)
    }
    
    static var documentNationalId: Image {
        return Image(uiImage: .documentNationalId)
    }
    
    static var documentVisa: Image {
        return Image(uiImage: .documentVisa)
    }
    
    static var stepEmailIcon: Image {
        return Image(uiImage: .stepEmailIcon)
    }
    
    static var errorOTPFlow: Image {
        return Image(uiImage: .errorOTPFlow)
    }
    
    static var withoutSignal: Image {
        return Image(uiImage: .withoutSignal)
    }
    
    static var captureOn: Image {
        return Image(uiImage: .captureOn)
    }
    
    static var captureOff: Image {
        return Image(uiImage: .captureOff)
    }
    
    static var circleGreenFramework: Image {
        return Image(uiImage: .circleGreenFramework)
    }
    
    static var circleRedOne: Image {
        return Image(uiImage: .circleRedOne)
    }
    
    static var circleGreenOneTwo: Image {
        return Image(uiImage: .circleGreenOneTwo)
    }
    
    static var circleGreenThree: Image {
        return Image(uiImage: .circleGreenThree)
    }
    
    static var biometricsSelfie: Image {
        return Image(uiImage: .biometricsSelfie)
    }
    
    static var scanDocumentError: Image {
        return Image(uiImage: .scanDocumentError)
    }
    
}

