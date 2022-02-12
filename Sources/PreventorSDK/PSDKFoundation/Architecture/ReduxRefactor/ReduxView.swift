//
//  ReduxView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation
import SwiftUI

protocol ReduxView: View {
    
    var navigationSettings: PSDKNavigationSettings? { get }
    
}

extension ReduxView {
    
    var navigationSettings: PSDKNavigationSettings? {
        .default
    }
    
}

protocol ReduxStoreView: ReduxView {
    
    associatedtype ViewState: ReduxState
    
    var store: ReduxStore<ViewState> { get }
    
}

protocol ReduxSemaphoreStoreView: ReduxView {
    
    associatedtype ViewState: ReduxState
    
    var store: ReduxSemaphoreStore<ViewState> { get }
    
}

protocol ReduxBarrierStoreView: ReduxView {
    
    associatedtype ViewState: ReduxState
    
    var store: ReduxBarrierStore<ViewState> { get }
    
}

protocol ReduxParentView: ReduxStoreView {
    
    var parentStore: DispatcherObject? { get }
    
}
