//
//  ModulePersonalInfoCoordinator.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import UIKit

protocol ModulePersonalInfoCoordinatorDelegate: AnyObject {
    
}

final class ModulePersonalInfoCoordinator: PSDKReduxCoordinator<PSDKEmptyState> {
    
    let routingManager: RoutingManager?
    weak var delegate: ModulePersonalInfoCoordinatorDelegate?
    
    init(presenter: UIViewController, delegate: ModulePersonalInfoCoordinatorDelegate? = nil) {
        self.delegate = delegate
        self.routingManager = .init(verification: VerificationsID.twoFactorVerification.toVerification)
        super.init(presenter: presenter)
    }
    
    override func handleDispatch(action: ReduxAction, store: DispatcherObject, parent: DispatcherObject?) -> Bool {
        if let action = action as? AppFlow{
            self.store?.parent?.dispatch(action)
            return true
        }
        guard let action = action as? ModulePersonalInfoAction else { return false }
        switch action {
        case .showPersonalInfo:
            showPersonalInfo()
        case .showEditInfo:
            showEditInfo()
        case .showStepEmail:
            showStepEmail()
        case .showPhoneNumber:
            showPhoneNumber()
        case .showFinishOTP:
            showFinishOTP()
        case .nextScreen:
            nextScreen()
        }
        return true
    }
        
    override func start() {
        self.store?.dispatch(ModulePersonalInfoAction.showPersonalInfo)
    }
    
    func nextScreen() {
        if let routingManager = routingManager {
            if let vid = routingManager.getNextScreen() {
                switch vid {
                case .OTPEmail:
                    showStepEmail()
                case .OTPPhone:
                    showPhoneNumber()
                case .nextModule:
                    showFinishOTP()
                default:
                    break
                }
            }
        } else {
            store?.parent?.dispatch(AppFlow.showError)
        }
    }
    
    func showPersonalInfo(){
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
    
    func showEditInfo(){
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
    
    func showStepEmail(){
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
    
    func showPhoneNumber(){
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
    
    func showFinishOTP(){
        let store = ReduxStore<FinishOTPState>(
            parent: self.store,
            state: FinishOTPState(),
            reducer: FinishOTPReducer(),
            middlewares: [FinishOTPMiddleware(repository: PreventorRepository())],
            coordinator: self 
        )
        self.store?.addChild(store: store)
        let view = FinishOTPView(store: store)
        pushView(view: view, animated: true)
    }
    
}
