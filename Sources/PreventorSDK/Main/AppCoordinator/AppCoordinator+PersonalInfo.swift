//
//  AppCoordinator+PersonalInfo.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 28/12/21.
//

import UIKit

extension AppCoordinator: ModulePersonalInfoCoordinatorDelegate {
    
    func showPersonalInfo() {
        guard let navigationController = self.navigationController else { return }
        let dependencies = ModulePersonalInfoDependencies(
            navigationController: navigationController,
            parentCoordinator: self,
            delegate: self,
            parentStore: store)
        ModulePersonalInfo.build(dependencies: dependencies)
    }
    
}
