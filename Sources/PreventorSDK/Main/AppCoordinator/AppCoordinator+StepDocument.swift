//
//  AppCoordinator+StepDocument.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 23/12/21.
//

import UIKit

extension AppCoordinator: StepDocumentCoordinatorDelegate {
    
    func getRepository() -> PreventorRepository {
        return preventorRepository
    }
    
    func showStepDocument() {
        guard let navigationController = self.navigationController else { return }
        let dependencies = StepDocumentDependecies(
            navigationController: navigationController,
            parentCoordinator: self,
            delegate: self,
            repository: preventorRepository,
            parentStore: store)
        StepDocument.build(dependencies: dependencies)
    }
    
}
