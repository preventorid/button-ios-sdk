//
//  AppState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

enum AppFlow: FlowAction {
    
    case back
    case initial(_ result: StartState.Result)
    case stepDocument
    case personalInfo
    case finishSDK(error: PreventorSDKErrorCode? = nil)
    case showCancelVerification(reason: PreventorSDKErrorCode)
    case showCameraAccessDenied
    case showError
    
}
