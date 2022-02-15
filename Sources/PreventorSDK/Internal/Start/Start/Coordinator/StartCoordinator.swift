//
//  StartCoordinator.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation
import UIKit

final class StartCoordinator: PSDKReduxCoordinator<StartState> {
    
    weak var delegate: StartCoordinatorDelegate?
    
    init(presenter: UIViewController, delegate: StartCoordinatorDelegate?) {
        self.delegate = delegate
        super.init(presenter: presenter)
    }
    
    override func start() {
        self.store?.dispatch(StartFlowAction.showStartVerification)
    }
    
    override func handleDispatch(action: ReduxAction, store: DispatcherObject, parent: DispatcherObject?) -> Bool {
        if let action = action as? AppFlow{
            self.store?.parent?.dispatch(action)
            return true
        }
        
        guard let action = action as? StartFlowAction else { return false }
        switch action {
        case .showStartVerification:
            showStartVerification()
        case .showTermsConditions:
            showTermsConditions()
        case .stepDocument:
            stepDocument()
        }
        return true
    }
    
    private func stepDebug(){
        let store = ReduxStore<StepEmailState>(
            parent: self.store,
            state: StepEmailState(screen: .otpEmail, seconds: 20, showTimer: true),
            reducer: StepEmailReducer(),
            middlewares: [],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = StepEmailView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func stepDocument() {
        let store = ReduxStore<CameraDeniedState>(
            parent: self.store,
            state: CameraDeniedState(),
            reducer: CameraDeniedReducer(),
            middlewares: [],
            coordinator: self 
        )
        self.store?.addChild(store: store)
        let view = ChooseCountryView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showStartVerification() {
        let store = ReduxStore<StartState>(
            parent: self.store,
            state: StartState(),
            reducer: StartReducer(),
            middlewares: [],
            coordinator: self 
        )
        self.store?.addChild(store: store)
        let view = StartVerificationView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showTermsConditions() {
        let store = ReduxStore<CameraDeniedState>(
            parent: self.store,
            state: CameraDeniedState(),
            reducer: CameraDeniedReducer(),
            middlewares: [],
            coordinator: self 
        )
        self.store?.addChild(store: store)
        let view = TermsConditionsView(store: store)
        pushView(view: view, animated: true)
    }
    
}
