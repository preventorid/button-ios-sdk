//
//  PreventorSDKDelegate.swift
//  
//
//  Created by Alexander Rodriguez on 4/02/22.
//

import Foundation

public protocol PreventorSDKDelegate {
    
    func onStart()
    func onFinish()
    func onError(error: PreventorSDKErrorCode)
    func onSubmitted()
    
}
