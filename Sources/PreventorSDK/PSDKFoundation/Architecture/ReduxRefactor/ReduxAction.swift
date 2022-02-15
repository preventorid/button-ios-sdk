//
//  ReduxAction.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation
import Combine
import Alamofire

// MARK: - Action
/// An Action could be any struct or object that could be evaluated by the Reducer in order to make a new state
protocol ReduxAction {
    
    /**
     * if true suspends the invocation of blocks on a dispatch object, by default is false.
     *
     * A suspended dispatch object will not invoke any blocks associated with it. The
     * suspension of dispatch object will occur after call reduce,
     * resume of dispatch object will occur the reduce object completes.
     */
    var wait: Bool { get }
    
}

extension ReduxAction {
    
    var wait: Bool { false }
    
}

protocol DispatcherObject: AnyObject {
    
    /// Dispatches an action and reduces the Store's state
    func dispatch(_ action: ReduxAction)
    func addChild(store: DispatcherObject)
    func addParent(store: DispatcherObject?)
    
}

protocol ListenerObject: AnyObject {
    var dispatcher: DispatcherObject? {get set}
    
}

extension ListenerObject {
    var dispatcher: DispatcherObject? {
        get {
            nil
        }
        set {
            dispatcher = newValue
        }
    }
}

protocol MiddlewareListenerObject: ListenerObject {
    
    var subscriptions: Set<AnyCancellable> { get }
    func handleDispatch(action: ReduxAction,
                        store: DispatcherObject,
                        parent: DispatcherObject?)
    
}

protocol CoordinatorListenerObject: ListenerObject {
    
    /// returns true if the coordinator handles the flow, and false if it doesn't
    func handleDispatch(action: ReduxAction,
                        store: DispatcherObject,
                        parent: DispatcherObject?) -> Bool
    
}

extension CoordinatorListenerObject {
    
    func handleDispatch(action: ReduxAction,
                        store: DispatcherObject,
                        parent: DispatcherObject?) -> Bool {
        return false
    }
    
}

class PSDKReduxMiddleware<State: ReduxState>: MiddlewareListenerObject {
    
    open var subscriptions = Set<AnyCancellable>()
    weak var dispatcher: DispatcherObject?
    weak var store: ReduxStore<State>? {
        self.dispatcher as? ReduxStore<State>
    }
    
    func handleDispatch(action: ReduxAction,
                             store: DispatcherObject,
                             parent: DispatcherObject?) {
        return
    }
    
    final func handleError(error: AFError?) -> Bool {
        if let error = error,
            let errorCode = error.responseCode,
            399 < errorCode && errorCode < 501 {
            debugPrint(error)
            biometricsFailed()
            return true
        }
        return false
    }
    
    final func biometricsFailed() {
        store?.parent?.dispatch(AppFlow.showError)
    }
    
    init() { }
    
}
