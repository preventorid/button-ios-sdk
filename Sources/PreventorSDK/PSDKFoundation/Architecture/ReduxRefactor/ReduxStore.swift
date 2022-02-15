//
//  ReduxStore.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import SwiftUI
import Combine

// MARK: - StoreProtocol
/// The StoreProtocol is the main interface which every Views will interact with.
protocol StoreProtocol: ObservableObject, DispatcherObject {
    
    associatedtype StateType: ReduxState
    
    var state: StateType { get }
    var reducer: ReduxReducer<StateType> { get }
    var parent: DispatcherObject? { get }
    var children: [DispatcherObject] { get }
    var middlewares: [MiddlewareListenerObject] { get }
    var coordinator: CoordinatorListenerObject? { get }
    var logger: PSDKLogger? { get }
    
}

class ReduxBarrierStore<StateType: ReduxState>: ReduxStore<StateType> {
    
    private let queue: DispatchQueue = DispatchQueue(label: "PSDK.reduxbarrierstore.queue",
                                                     qos: .userInteractive,
                                                     attributes: .concurrent,
                                                     autoreleaseFrequency: .inherit,
                                                     target: .main)
    
    override func dispatch(_ action: ReduxAction) {
        let block = {
            DispatchQueue.main.async {
                /// 1 Dispatch flow action
                if (action is FlowAction || action is CoordinatorAction),
                   let coordinator = self.coordinator,
                   coordinator.handleDispatch(action: action,
                                              store: self,
                                              parent: self.parent) {
                    return
                }
                /// 2 Dispatch action on store
                self.state = self.reducer.reduce(state: self.state,
                                                 action: action)
                /// 3 Dispatch middleware actions
                self.middlewares.forEach {
                    $0.handleDispatch(action: action,
                                      store: self,
                                      parent: self.parent)
                }
                /// 4 Dispatch action on every child
                self.children.forEach {
                    $0.dispatch(action)
                }
            }
        }
        if action.wait {
            self.queue.sync(flags: .barrier, execute: block)
        } else {
            self.queue.async(execute: block)
        }
    }
    
}

class ReduxSemaphoreStore<StateType: ReduxState>: ReduxStore<StateType> {
    
    override func dispatch(_ action: ReduxAction) {
        /// 1 Dispatch flow action
        if (action is FlowAction || action is CoordinatorAction),
           let coordinator = self.coordinator,
           coordinator.handleDispatch(action: action,
                                      store: self,
                                      parent: self.parent) {
            return
        }
        let group = DispatchGroup()
        if action.wait {
            group.enter()
        }
        DispatchQueue.main.async {
            /// 2 Dispatch action on store
            self.state = self.reducer.reduce(state: self.state,
                                             action: action)
            if action.wait { group.leave() }
        }
        let block = {
            /// 3 Dispatch middleware actions
            self.middlewares.forEach {
                $0.handleDispatch(action: action,
                                  store: self,
                                  parent: self.parent)
            }
            /// 4 Dispatch action on every child
            self.children.forEach {
                $0.dispatch(action)
            }
        }
        group.notify(queue: .main, execute: block)
    }
    
}

// MARK: - Store
/// A Store is the only mutable object in a Redux-like Architecture.
/// It's main goal is to manage the State and handle and publish all State updates.
/// PSDKStore is an open class, though you can inherit it and extend it's behaviour.
class ReduxStore<StateType: ReduxState>: StoreProtocol {
    
    private(set) weak var parent: DispatcherObject?
    // MARK: - State
    /// The State is the logical representation of the View or the App. It can only be modified by a Store object.
    @Published var state: StateType
    // MARK: - Reducer:
    /// A Reducer is a static function that helps us reduce our current State into a new State, given a specific Action
    private(set) var reducer: ReduxReducer<StateType>
    // MARK: - Children:
    /// Store can have child stores
    private(set) var children: [DispatcherObject] = []
    private(set) var middlewares: [MiddlewareListenerObject] = []
    private(set) var coordinator: CoordinatorListenerObject?
    private(set) var logger: PSDKLogger?
    private(set) weak var appCoordinator: AppCoordinator?
    private let queue: DispatchQueue = DispatchQueue(label: "PSDK.reduxstore.queue",
                                                     qos: .userInteractive,
                                                     attributes: .concurrent,
                                                     autoreleaseFrequency: .inherit,
                                                     target: .main)
    // MARK: - Initializers:
    
    init(parent: DispatcherObject? = nil,
                state: StateType,
                reducer: ReduxReducer<StateType>,
                middlewares: [MiddlewareListenerObject] = [],
                coordinator: CoordinatorListenerObject? = nil,
                appCoordinator: AppCoordinator? = nil,
                logger: PSDKLogger? = nil) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
        self.assignStoreToMiddlewares()
        self.coordinator = coordinator
        self.appCoordinator = appCoordinator
        self.assignStoreToCoordinator()
        self.logger = logger
        self.parent = parent
    }
    
    // MARK: - Functions:
    
    func dispatch(_ action: ReduxAction) {
        self.queue.async {
            /// 1 Dispatch flow action
            if (action is FlowAction || action is CoordinatorAction),
               let coordinator = self.coordinator,
               coordinator.handleDispatch(action: action,
                                          store: self,
                                          parent: self.parent) {
                return
            }
            DispatchQueue.main.async {
                /// 2 Dispatch action on store
                self.state = self.reducer.reduce(state: self.state,
                                                 action: action)
                if action.wait {
                    self.queue.resume()
                }
            }
            /// 3 Dispatch middleware actions
            self.middlewares.forEach {
                $0.handleDispatch(action: action,
                                  store: self,
                                  parent: self.parent)
            }
            /// 4 Dispatch action on every child
            self.children.forEach {
                $0.dispatch(action)
            }
        }
        if action.wait {
            self.queue.suspend()
        }
    }
    
    func addChild(store: DispatcherObject) {
        guard let index = children.firstIndex(where: {
            (type(of: $0) == type(of: store))
        }) else {
            children.append(store)
            return
        }
        children[index] = store
    }
    
    func addParent(store: DispatcherObject?) {
        self.parent = store
    }
    
    func getStore<T: ReduxState>(ofType type: T.Type) -> ReduxStore<T>? {
        return children.compactMap { $0 as? ReduxStore<T> }.first
    }
    
    func addMiddleware(middleware: MiddlewareListenerObject) {
        self.middlewares.append(middleware)
        self.assignStoreToMiddlewares()
    }
    
    private func assignStoreToMiddlewares() {
        self.middlewares.enumerated().forEach { self.middlewares[$0.offset].dispatcher = self }
    }
    
    /// The coordinator assigns his dispatcher only once when it is not null
    private func assignStoreToCoordinator() {
        self.coordinator?.dispatcher = self.coordinator?.dispatcher ?? self
    }
    
    func addCoordinator(coordinator: CoordinatorListenerObject?) {
        self.coordinator = coordinator
        self.assignStoreToCoordinator()
    }
    
}
