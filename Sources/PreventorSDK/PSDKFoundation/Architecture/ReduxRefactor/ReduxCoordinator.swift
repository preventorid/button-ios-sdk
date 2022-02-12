//
//  ReduxCoordinator.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import SwiftUI

protocol CoordinatorAction: ReduxAction {}

protocol FlowAction: ReduxAction {}

protocol ReduxCoordinator {
    
    var presenter: UIViewController { get }
    var navigationController: UINavigationController? { get }
    var logger: PSDKLogger? { get }
    
}

extension ReduxCoordinator {
    
    func setRootView<Content: ReduxView>(view: Content,
                                         with viewID: String? = nil,
                                         animated: Bool) {
        let destinationHosting = PSDKHostingViewController(rootView: view,
                                                          identifier: viewID,
                                                          logger: self.logger)
        self.navigationController?.setViewControllers([destinationHosting],
                                                      animated: animated)
    }
    
    func pushView<Content: ReduxView>(view: Content,
                                      with viewID: String? = nil,
                                      animated: Bool) {
        let destinationHosting = PSDKHostingViewController(rootView: view,
                                                          identifier: viewID,
                                                          logger: self.logger)
        destinationHosting.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(destinationHosting,
                                                 animated: animated)
    }
    
    func presentView<Content: ReduxView>(view: Content,
                                         with viewID: String? = nil,
                                         animated: Bool,
                                         fullScreen: Bool = false,
                                         completion: (() -> Void)? = nil) {
        let destinationHosting = PSDKHostingViewController(rootView: view,
                                                          identifier: viewID,
                                                          logger: self.logger)
        if fullScreen {
            destinationHosting.modalPresentationStyle = .fullScreen
        }
        guard let topViewController = navigationController?.topViewController else { return }
        if let presentedViewController = topViewController.presentedViewController {
            presentedViewController.present(destinationHosting,
                                            animated: animated,
                                            completion: completion)
        } else {
            topViewController.present(destinationHosting,
                                      animated: animated,
                                      completion: completion)
        }
    }
    
    func pushView<Content: View>(view: Content,
                                 with viewID: String? = nil,
                                 animated: Bool) {
        let destinationHosting = PSDKHostingViewController(rootView: view,
                                                          identifier: viewID,
                                                          logger: self.logger)
        navigationController?.pushViewController(destinationHosting,
                                                 animated: animated)
    }
    
    func setRootView<Content: View>(view: Content,
                                    with viewID: String? = nil,
                                    animated: Bool) {
        let destinationHosting = PSDKHostingViewController(rootView: view,
                                                          identifier: viewID,
                                                          logger: self.logger)
        self.navigationController?.setViewControllers([destinationHosting],
                                                      animated: animated)
    }
    
    func presentView<Content: View>(view: Content,
                                    with viewID: String? = nil,
                                    animated: Bool,
                                    fullScreen: Bool = false,
                                    completion: (() -> Void)? = nil) {
        let destinationHosting = PSDKHostingViewController(rootView: view,
                                                          identifier: viewID,
                                                          logger: self.logger)
        if fullScreen {
            destinationHosting.modalPresentationStyle = .fullScreen
        }
        guard let topViewController = navigationController?.topViewController else { return }
        if let presentedViewController = topViewController.presentedViewController {
            presentedViewController.present(destinationHosting,
                                            animated: animated,
                                            completion: completion)
        } else {
            topViewController.present(destinationHosting,
                                      animated: animated,
                                      completion: completion)
        }
    }
    
}
