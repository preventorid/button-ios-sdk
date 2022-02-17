//
//  ModulePersonalInfoCoordinator.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import UIKit

extension ModulePreventorCoordinator {
    
    internal func handleStreamlineDispatch(action: StreamlineAction,
                                    store: DispatcherObject,
                                    parent: DispatcherObject?
    ) -> Bool {
        switch action {
        case .showPersonalInfo:
            showPersonalInfo()
        case .showEditInfo:
            showEditInfo()
        case .showStepEmail:
            showStepEmail()
        case .showPhoneNumber:
            showPhoneNumber()
        case .nextScreen:
            nextScreen()
        case .showValidatingView:
            showValidatingView(middleware: ContinueOnboardingMiddleware(repository: repository))
        }
        return true
    }
    
    private func nextScreen() {
        if let routingManager = routingManager {
            if let vid = routingManager.getNextScreen() {
                switch vid {
                case .OTPEmail:
                    showStepEmail()
                case .OTPPhone:
                    showPhoneNumber()
                case .nextModule:
                    showValidatingView(middleware: ContinueOnboardingMiddleware(repository: repository))
                default:
                    break
                }
            }
        } else {
            store?.parent?.dispatch(AppFlow.showError)
        }
    }
    
    private func showPersonalInfo(){
        let store = ReduxStore<PersonalInfoState>(
            parent: self.store,
            state: PersonalInfoState(),
            reducer: PSDKEmptyReducer(),
            middlewares: [],
            coordinator: self 
        )
        self.store?.addChild(store: store)
        let view = PersonalInfoView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showEditInfo(){
        let store = ReduxStore<EditInfoState>(
            parent: self.store,
            state: EditInfoState(),
            reducer: PSDKEmptyReducer(),
            middlewares: [],
            coordinator: self 
        )
        self.store?.addChild(store: store)
        let view = EditInfoView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showStepEmail(){
        let store = ReduxStore<StepEmailState>(
            parent: self.store,
            state: StepEmailState(),
            reducer: StepEmailReducer(),
            middlewares: [StepEmailMiddleware(repository: PreventorRepository())],
            coordinator: self 
        )
        self.store?.addChild(store: store)
        let view = StepEmailView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showPhoneNumber(){
        let store = ReduxStore<PhoneNumberState>(
            parent: self.store,
            state: PhoneNumberState(),
            reducer: PhoneNumberReducer(),
            middlewares: [PhoneNumberMiddleware(repository: PreventorRepository())],
            coordinator: self 
        )
        self.store?.addChild(store: store)
        let view = PhoneNumberView(store: store)
        pushView(view: view, animated: true)
    }
    
}
