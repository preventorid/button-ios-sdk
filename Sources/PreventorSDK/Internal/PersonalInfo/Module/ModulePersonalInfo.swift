//
//  ModulePersonalInfo.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import Foundation

struct ModulePersonalInfo {
    
    static func build(dependencies: ModulePersonalInfoDependencies) {
        let coordinator = ModulePersonalInfoCoordinator(presenter: dependencies.navigationController,
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
