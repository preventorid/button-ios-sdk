//
//  ModulePreventorCoordinator.swift
//  
//
//  Created by Alexander Rodriguez on 15/02/22.
//

import Foundation
import UIKit

protocol ModulePreventorCoordinatorDelegate {
    func showStartFlow()
}

final class ModulePreventorCoordinator: PSDKReduxCoordinator<PSDKEmptyState> {
    
    let routingManager: RoutingManager?
    var delegate: ModulePreventorCoordinatorDelegate?
    var repository: PreventorRepository
    
    init(presenter: UIViewController,
         repository: PreventorRepository,
         delegate: ModulePreventorCoordinatorDelegate?) {
        self.delegate = delegate
        self.routingManager = .init()
        self.repository = repository
        super.init(presenter: presenter)
    }
    
    override func handleDispatch(action: ReduxAction, store: DispatcherObject, parent: DispatcherObject?) -> Bool {
        if let action = action as? AppFlow {
            self.store?.parent?.dispatch(action)
            return true
        }
        guard let action = action as? ModulePreventorAction else {
            return false
        }
        switch action {
        case .biometrics(let action):
            return handleBiometricsDispatch(action: action, store: store, parent: parent)
        case .streamline(let action):
            return handleStreamlineDispatch(action: action, store: store, parent: parent)
        case let .showFinishApp(screen):
            showFinishApp(screen)
        }
        return true
    }
    
    override func start() {
        store?.dispatch(ModulePreventorAction.biometrics(.showStartVerification))
    }
    
    internal func showValidatingView(middleware: MiddlewareListenerObject) {
        let store = ReduxStore<PSDKEmptyState>(
            parent: self.store,
            state: PSDKEmptyState(),
            reducer: PSDKEmptyReducer(),
            middlewares: [middleware],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = ValidatingView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showFinishApp(_ screen: FinishAppState.Screen){
        let store = ReduxStore<FinishAppState>(
            parent: self.store,
            state: FinishAppState(screen: screen),
            reducer: FinishAppReducer(),
            middlewares: [ContinueOnboardingMiddleware(repository: repository)],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = FinishAppView(store: store)
        pushView(view: view, animated: true)
    }
    
}
