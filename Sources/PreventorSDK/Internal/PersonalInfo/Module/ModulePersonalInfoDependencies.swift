//
//  ModulePersonalInfoDependencies.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import UIKit

struct ModulePersonalInfoDependencies {

    let navigationController: UINavigationController
    weak var parentCoordinator: PSDKNavigationCoordinator?
    weak var delegate: ModulePersonalInfoCoordinatorDelegate?
    weak var parentStore: DispatcherObject?
    
    init(navigationController: UINavigationController,
                parentCoordinator: PSDKNavigationCoordinator? = nil,
                delegate: ModulePersonalInfoCoordinatorDelegate?,
                parentStore: DispatcherObject?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.delegate = delegate
        self.parentStore = parentStore
        //Can init any other denpendency
    }

}
