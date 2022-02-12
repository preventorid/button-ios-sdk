//
//  StepDocumentAction.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 23/12/21.
//

import Foundation

enum StepDocumentAction: FlowAction {
    
    case showChooseCountry
    case showDocumentType
    case showReadyScan(type: DocumentModel.DocType)
    case showSelfieStep
    case backToScanDocument
    case backToSelfie
    case nextScreen(_ isFirst: Bool = false)
    
}
