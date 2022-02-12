//
//  AppState.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

enum AppModule {
    
    case splash,
    settings,
    home
    
}

struct AppState: ReduxState {
    
    let currentModule: AppModule
    
    init(currentModule: AppModule = .splash) {
        self.currentModule = currentModule
    }
    
}
