//
//  PSDKReduxCoordinator.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import SwiftUI
import Combine

protocol CoordinatorStore: ListenerObject {
    associatedtype State: ReduxState
    
    var store: ReduxStore<State>? { get set }
    
}

extension CoordinatorStore {
    
    weak var store: ReduxStore<State>? {
        get {
            return self.dispatcher as? ReduxStore<State>
        } set {
            _ = newValue
        }
    }
    
}

class PSDKReduxEmptyCoordinator: PSDKReduxCoordinator<PSDKEmptyState> { }

class PSDKReduxCoordinator<State: ReduxState>: PSDKNavigationCoordinator, ReduxCoordinator, CoordinatorListenerObject, CoordinatorStore {
    open var subscriptions = Set<AnyCancellable>()
//    weak var dispatcher: DispatcherObject?
    var presenter: UIViewController
    weak var navigationController: UINavigationController? {
        return presenter as? UINavigationController
    }
    weak var parent: PSDKNavigationCoordinator?
    var children: [PSDKNavigationCoordinator] = []
    private(set) var logger: PSDKLogger?
    var _dispatcher: DispatcherObject?
    weak var dispatcher: DispatcherObject? {
        get {
            _dispatcher
        }
        set {
            _dispatcher = newValue
            _ = newValue
        }
    }
    
    init(presenter: UIViewController,
                logger: PSDKLogger? = nil) {
        self.presenter = presenter
        self.logger = logger
    }
    
    open func start() {
        
    }
    
    open func didPopViewController() {
        // This method is called after the view is popped or dismissed
    }
    
    open func showLoader() {
        
    }
    
    open func hideLoader() {
        
    }
    
    func updateNavigationSettings(settings: PSDKNavigationSettings, animated: Bool) {
        if let viewController = self.navigationController?.topViewController as? PSDKHostingViewController {
            viewController.updateNavigationBar(navigationSettings: settings, animated: animated)
        }
    }
    
    open func endEditing() {
        navigationController?.navigationBar.window?.endEditing(true)
    }
    
    open func handleDispatch(action: ReduxAction,
                             store: DispatcherObject,
                             parent: DispatcherObject?) -> Bool {
        return false
    }
    
}
