//
//  AppCoordinator.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 03/01/22.
//

import Foundation
import UIKit
import DocumentReader

final class AppCoordinator: PSDKReduxCoordinator<AppState> {
    
    internal let preventorRepository: PreventorRepository
    
    init(presenter: UIViewController,
                  repository: PreventorRepository) {
        self.preventorRepository = repository
        super.init(presenter: presenter,
                   logger: nil)
    }
    
    // MARK: - CoordinatorListenerObject -
    
    override func handleDispatch(action: ReduxAction,
                                 store: DispatcherObject,
                                 parent: DispatcherObject?) -> Bool {
        guard let action = action as? AppFlow else {
            return false
        }
        switch action {
        case .back:
            self.popViewController(animated: true)
        case let .initial(restult):
            self.prepareDatabase()
            self.showStartFlow(state: restult)
        case .stepDocument:
            self.showStepDocument()
        case .personalInfo:
            self.showPersonalInfo()
        case let .showCancelVerification(reason):
            showCancelVerification(reason: reason)
        case .showError:
            showErrorView()
        case let .finishSDK(error):
            finishSDK(with: error)
        }
        return true
    }
    
    private func showCancelVerification(reason: PreventorSDKErrorCode) {
        let store = ReduxStore<PSDKEmptyState>(
            parent: self.store,
            state: PSDKEmptyState(),
            reducer: PSDKEmptyReducer(),
            middlewares: [],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = CancelVerificationView(store: store, reason: reason)
        pushView(view: view, animated: true)
    }
    
    private func showErrorView() {
        let store = ReduxStore<PSDKEmptyState>(
            parent: store,
            state: PSDKEmptyState(),
            reducer: PSDKEmptyReducer(),
            middlewares: [],
            coordinator: self,
            appCoordinator: self)
        
        self.store?.addChild(store: store)
        let view = ErrorView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func initializeReader() {
        do {
            guard let licensePath = Bundle.module.path(forResource: "regula.license", ofType: nil) else { return }
            let licenseData = try Data(contentsOf: URL(fileURLWithPath: licensePath))
            let config = DocReader.Config(license: licenseData)
            
            DocReader.shared.initializeReader(config: config) { (success, error) in
                if success {
                    PSDKSession.shared.setDatabaseState(databaseState: .success)
                } else {
                    PSDKSession.shared.setDatabaseState(databaseState: .failed)
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    private func prepareDatabase() {
        DocReader.shared.prepareDatabase(databaseID: "Full") {[weak self] (success, error) in
            if success {
                self?.initializeReader()
            } else {
                PSDKSession.shared.setDatabaseState(databaseState: .failed)
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    func finishSDK(with error: PreventorSDKErrorCode? = nil) {
        if let nav = navigationController as? PSDKNavigationController{
            PSDKSession.shared.clear()
            nav.popToRootViewController(animated: true)
            nav.finalize(with: error)
        }
    }
    
    @objc func backAction() {
        store?.dispatch(StepEmailAction.updateScreen(screen: .email))
    }
    
    @objc func popViewController(_ animated: Bool) {
        if navigationController?.viewControllers.count == 1 {
            if let nav = navigationController as? PSDKNavigationController{
                nav.finalize(with: .CANCELLED_BY_USER)
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
