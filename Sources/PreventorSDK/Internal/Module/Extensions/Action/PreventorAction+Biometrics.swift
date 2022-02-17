//
//  BiometricsAction.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 23/12/21.
//

import Foundation

enum BiometricsAction: FlowAction {
    
    case showStartVerification
    case showTermsConditions
    case showChooseCountry
    case showDocumentType
    case showReadyScan(type: DocumentModel.DocType)
    case showSelfieStep
    case backToScanDocument
    case backToSelfie
    case showValidatingView
    case showCameraSettings
    case nextScreen(_ isFirst: Bool = false)
    case showBiometricsResult(resultType: BiometricsResultType)
    
}
