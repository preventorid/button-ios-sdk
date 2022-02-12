//
//  ModuleStart.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 16/12/21.
//

import Foundation

struct ModuleStart {
    
    static func build(dependencies: StartDependencies) {
        let coordinator = StartCoordinator(presenter: dependencies.navigationController,
                                           delegate: dependencies.delegate)
        
        let moduleStore = ReduxBarrierStore<StartState>(
            parent: dependencies.parentStore,
            state: StartState(result: dependencies.result),
            reducer: StartReducer(),
            coordinator: coordinator,
            appCoordinator: dependencies.parentCoordinator as? AppCoordinator
        )
        dependencies.parentCoordinator?.addChild(coordinator: coordinator)
        dependencies.parentStore?.addChild(store: moduleStore)
        moduleStore.dispatch(StartFlowAction.showStartVerification)
    }

}
