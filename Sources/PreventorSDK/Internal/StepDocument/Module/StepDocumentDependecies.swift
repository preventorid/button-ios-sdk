//
//  StepDocumentDependecies.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 23/12/21.
//

import Foundation
import UIKit

struct StepDocumentDependecies {

    let navigationController: UINavigationController
    weak var parentCoordinator: PSDKNavigationCoordinator?
    weak var delegate: StepDocumentCoordinatorDelegate?
    let repository: PreventorRepository
    let parentStore: DispatcherObject?
    
    init(navigationController: UINavigationController,
         parentCoordinator: PSDKNavigationCoordinator? = nil,
         delegate: StepDocumentCoordinatorDelegate?,
         repository: PreventorRepository,
         parentStore: DispatcherObject?
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.delegate = delegate
        self.repository = repository
        self.parentStore = parentStore
        //Can init any other denpendency
    }

}
