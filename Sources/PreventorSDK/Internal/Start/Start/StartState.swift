//
//  StartState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation

struct StartState: ReduxState {
    
    enum Result {
        
        case onFinish
        case onSubmitted
        case onError
        case onStart
        
    }
    
    let result: Result?
    let loading: Bool
    let error: PSDKError?
    
    init(loading: Bool = true,
         result: Result? = nil,
         error: PSDKError? = nil) {
        self.loading = loading
        self.result = result
        self.error = error
    }

}
