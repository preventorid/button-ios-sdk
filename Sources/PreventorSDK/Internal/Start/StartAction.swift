//
//  StartAction.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation

enum StartAction: ReduxAction {
    
    case setLoading(_ isLoading: Bool)
    case setError(_ error: PSDKError)
    case nextStep
    
}
