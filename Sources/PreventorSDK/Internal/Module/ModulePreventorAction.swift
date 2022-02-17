//
//  ModulePreventorAction.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/02/22.
//

import Foundation

enum ModulePreventorAction: FlowAction {
    
    case showFinishApp(screen: FinishAppState.Screen)
    case biometrics(_ action: BiometricsAction)
    case streamline(_ action: StreamlineAction)
    
}
