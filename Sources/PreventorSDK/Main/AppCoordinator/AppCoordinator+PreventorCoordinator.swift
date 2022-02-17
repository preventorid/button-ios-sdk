//
//  AppCoordinator+Start.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 16/12/21.
//

import Foundation
import UIKit

extension AppCoordinator: ModulePreventorCoordinatorDelegate {

    internal func showStartFlow() {
        guard let navigationController = self.navigationController else { return }
        let dependencies = ModulePreventorDependencies(
            navigationController: navigationController,
            parentCoordinator: self,
            delegate: self,
            repository: preventorRepository,
            parentStore: store)
        ModulePreventor.build(dependencies: dependencies)
    }

}
