//
//  AppCoordinator+Start.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 16/12/21.
//

import Foundation
import UIKit

extension AppCoordinator: StartCoordinatorDelegate {
    
    func showStartFlow(state result: StartState.Result){
        guard let navigationController = self.navigationController else { return }
        let dependencies = StartDependencies(
            navigationController: navigationController,
            parentCoordinator: self,
            delegate: self,
            parentStore: store,
            result: result)
        ModuleStart.build(dependencies: dependencies)
    }
    
}
