//
//  PreventorButtonDelegate.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import SwiftUI

class ModuleAppCoordinator {
    
    let navigationController = PSDKNavigationController()
    let repository = PreventorRepository()
    var wasInitialized = false

    private(set) lazy var appCoordinator = AppCoordinator(presenter: self.navigationController,
                                                          repository: self.repository)
    
    
    private(set) lazy var store = ReduxStore<AppState>(state: AppState(),
                                                       reducer: AppReducer(),
                                                       coordinator: self.appCoordinator,
                                                       logger: nil)
    init() {
        self.store.dispatch(AppFlow.initial(.onStart))
    }
    
}
