//
//  ReadyScanAction.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import SwiftUI
import DocumentReader

enum ReadyScanAction: ReduxAction  {
    
    case updateScreen(screen: ReadyScanState.Screen)
    case showFrontPhoto(image: UIImage)
    case showBackPhoto(image: UIImage)
    case saveFrontImage(image: UIImage)
    case saveBackImage(image: UIImage)
    case showRegulaScan
    case hiddeRegulaScan(data: DocumentReaderResults?)
    
}
