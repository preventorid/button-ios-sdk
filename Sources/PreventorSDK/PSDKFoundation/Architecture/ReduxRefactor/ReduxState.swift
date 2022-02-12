//
//  ReduxState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation

// MARK: - State
/// The State is the logical representation of the View or the App. It can only be modified by a Store object.
public protocol ReduxState { }

protocol ReduxStateThrowable: ReduxState {
    associatedtype ErrorType: Error
    
    var error: ErrorType? { get set }
}

public struct PSDKEmptyState: ReduxState {
    
    init() { }
    
}

struct PSDKResultErrorState<T, Error: PSDKError>: ReduxState {
    
    let loading: Bool
    let error: Error?
    let data: T?
    
    init(loading: Bool = false,
                error: Error? = nil,
                data: T? = nil) {
        self.loading = loading
        self.error = error
        self.data = data
    }
    
    func with(loading: Bool? = false,
                     error: Error? = nil,
                     data: T? = nil) -> PSDKResultErrorState {
        PSDKResultErrorState(loading: loading ?? self.loading,
                            error: error ?? self.error,
                            data: data ?? self.data)
    }
    
}

struct PSDKNonNilResultErrorState<T, Error: PSDKError>: ReduxState {
    
    let loading: Bool
    let error: Error?
    let data: T
    
    init(loading: Bool = false,
                error: Error? = nil,
                data: T) {
        self.loading = loading
        self.error = error
        self.data = data
    }
    
    func with(loading: Bool? = false,
                     error: Error? = nil,
                     data: T? = nil) -> Self {
        PSDKNonNilResultErrorState(loading: loading ?? self.loading,
                                  error: error ?? self.error,
                                  data: data ?? self.data)
    }
    
}
