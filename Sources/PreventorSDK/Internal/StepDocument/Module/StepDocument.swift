//
//  StepDocument.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 23/12/21.
//

import Foundation

//struct StepDocument {
//    
//    static func build(dependencies: StepDocumentDependecies) {
//        let coordinator = StepDocumentCoordinator(dependencies)
//        let moduleStore = ReduxBarrierStore<PSDKEmptyState>(
//            parent: dependencies.parentStore,
//            state: PSDKEmptyState(),
//            reducer: PSDKEmptyReducer(),
//            coordinator: coordinator,
//            appCoordinator: dependencies.parentCoordinator as? AppCoordinator
//        )
//        dependencies.parentCoordinator?.addChild(coordinator: coordinator)
//        dependencies.parentStore?.addChild(store: moduleStore)
//        coordinator.start()
//    }
//
//}
