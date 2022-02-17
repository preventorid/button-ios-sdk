//
//  ReadyScanState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import UIKit

struct ReadyScanState: ReduxState {
    
    enum Screen {
        
        case ready
        case takeFrontPhoto
        case takeBackPhoto
        case showFrontPhoto
        case showBackPhoto
        
    }
    
    enum ScanMode {
        
        case withRegula
        case withOutRegula
        
    }
    
    let screen: Screen
    let type: DocumentModel.DocType
    let scanMode: ScanMode
    let image: UIImage?
    let showRegulaScan: Bool
    
    init(screen: Screen = .ready,
         type: DocumentModel.DocType,
         scanMode: ScanMode = .withOutRegula,
         image: UIImage? = nil,
         showRegulaScan: Bool = false) {
        self.screen = screen
        self.type = type
        self.scanMode = scanMode
        self.image = image
        self.showRegulaScan = showRegulaScan
    }

}
