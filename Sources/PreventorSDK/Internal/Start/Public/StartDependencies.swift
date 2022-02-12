//
//  StartDependencies.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation
import UIKit

protocol StartCoordinatorDelegate: AnyObject {
    
    func showStartFlow(state: StartState.Result)
    
}

struct StartDependencies {

    unowned var navigationController: UINavigationController
    weak var parentCoordinator: PSDKNavigationCoordinator?
    weak var delegate: StartCoordinatorDelegate?
    let parentStore: DispatcherObject?
    let result: StartState.Result
    
    init(navigationController: UINavigationController,
                parentCoordinator: PSDKNavigationCoordinator? = nil,
                delegate: StartCoordinatorDelegate?,
                parentStore: DispatcherObject?,
                result: StartState.Result) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.delegate = delegate
        self.parentStore = parentStore
        self.result = result
        //Can init any other denpendency
    }

}
