//
//  ModulePreventorDependencies.swift
//  
//
//  Created by Alexander Rodriguez on 15/02/22.
//

import SwiftUI

struct ModulePreventorDependencies {
    
    unowned var navigationController: UINavigationController
    weak var parentCoordinator: PSDKNavigationCoordinator?
    var delegate: ModulePreventorCoordinatorDelegate?
    var repository: PreventorRepository
    let parentStore: DispatcherObject?
    
    init(navigationController: UINavigationController,
         parentCoordinator: PSDKNavigationCoordinator? = nil,
         delegate: ModulePreventorCoordinatorDelegate?,
         repository: PreventorRepository,
         parentStore: DispatcherObject?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.repository = repository
        self.delegate = delegate
        self.parentStore = parentStore
    }

}
