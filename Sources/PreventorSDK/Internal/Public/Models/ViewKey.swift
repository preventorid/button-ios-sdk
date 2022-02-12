//
//  ViewKey.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 18/12/21.
//

import Foundation

enum ViewKey: Int, CaseIterable {
    
    case cameraDenied = 0
    case chooseCountry = 1
    case documentType = 2
    case readyDocument = 3
    case personalInfo = 4
    
}

enum ViewID: String {
    
    case selfPortraitTaking = "2fb1d3df-9295-4d29-8286-6405ffc7004c"
    case documentPhotoTaking = "c80c9e83-9134-4b1d-838f-a79650662064"
    case userInteraction =  "46b17fed-ecf1-4992-b489-4e365c7376eb"
    case userConfirmation = "a2e387a5-1b22-496f-a83f-ea509c15e284"
    case OTPPhone = "50f2a791-282c-4fee-90a1-74048688c732"
    case OTPEmail = "4be0a3a6-bc28-44c6-b18e-278930de9ca7"
    case nextModule = "nextModule"
    
    func toCheck(from verification: VerificationModel) -> Check? {
        if self == .nextModule {
            return nil
        }
        return verification.checks.first { check in
            check.id == self.rawValue
        }
    }
    
}

enum VerificationsID: String {
    
    case identityVerification = "bdb29669-ef0a-4a73-8512-b1bdbeaa1287"
    case userConfirmation = "1b965d3d-5935-4028-bdee-3129b27e603f"
    case twoFactorVerification = "f7bafbe4-4f04-4fce-806f-34c3a9b94ea7"
    
    var toVerification: VerificationModel? {
        PSDKSession.shared.currentWorkflow?.verifications.first { verification in
            verification.id == self.rawValue
        }
    }
    
}
