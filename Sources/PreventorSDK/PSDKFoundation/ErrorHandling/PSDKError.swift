//
//  PSDKError.swift
//  PSDKFoundation
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation

protocol PSDKError: Error {
    
    var code: String { get }
    var title: String { get }
    var message: String { get }
    var domain: String { get }
    
}
