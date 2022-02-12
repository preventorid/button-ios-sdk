//
//  ValidantingAction.swift
//  
//
//  Created by Alexander Rodriguez on 10/02/22.
//

import Foundation

enum ValidantingAction: ReduxAction  {
    
    case updateScreen(screen: ValidantingState.Screen)
    case validateInfo
    case handleResult(resultType: SelfieResultType)
    
}
