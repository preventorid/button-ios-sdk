//
//  ModulePreventor.swift
//  
//
//  Created by Alexander Rodriguez on 15/02/22.
//

import Foundation

struct ModulePreventor {
    
    static func build(dependencies: ModulePreventorDependencies) {
        
        let coordinator = ModulePreventorCoordinator(presenter: dependencies.navigationController,
                                                     repository: dependencies.repository,
                                           delegate: dependencies.delegate)
        let moduleStore = ReduxBarrierStore<PSDKEmptyState>(
            parent: dependencies.parentStore,
            state: PSDKEmptyState(),
            reducer: PSDKEmptyReducer(),
            coordinator: coordinator,
            appCoordinator: dependencies.parentCoordinator as? AppCoordinator
        )
        dependencies.parentCoordinator?.addChild(coordinator: coordinator)
        dependencies.parentStore?.addChild(store: moduleStore)
        coordinator.start()
    }
    
}
