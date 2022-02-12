//
//  PSDKNavigationCoordinator.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import SwiftUI
import Combine

protocol PSDKNavigationCoordinator: AnyObject {
    
    var presenter: UIViewController { get set }
    var navigationController: UINavigationController? { get }
    var parent: PSDKNavigationCoordinator? { get set }
    var children: [PSDKNavigationCoordinator] { get set }
    var logger: PSDKLogger? { get }
    
    func start()
    func didPopViewController()
    func showLoader()
    func hideLoader()
    
}

extension PSDKNavigationCoordinator {
    
    func finish(completion: (() -> Void)? = nil) {
        for child in children {
            child.finish()
        }
        parent?.removeChild(self)
        presenter.dismiss(animated: true, completion: completion)
    }
    
    func addChild(coordinator: PSDKNavigationCoordinator) {
        coordinator.parent = self
        children.append(coordinator)
    }
    
    func removeChild(_ coordinator: PSDKNavigationCoordinator) {
        if children.last === coordinator {
            children.removeLast()
        } else {
            children.removeAll { $0 === coordinator }
        }
    }
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        navigationController?.setViewControllers(viewControllers, animated: animated)
    }
    
    func setRootTopViewController(animated: Bool) {
        if let topViewController = self.getTopestViewController(),
           !topViewController.isKind(of: UINavigationController.self) {
            self.setViewControllers([topViewController], animated: animated)
        }
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func popViewController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToView(_ viewIdentifier: String, animated: Bool = true) {
        guard let navigationController = navigationController else {
            return
        }
        navigationController.viewControllers.forEach { (viewController) in
            if let viewController = viewController as? PSDKHostingViewController, viewController.identifier.elementsEqual(viewIdentifier) {
                navigationController.popToViewController(viewController, animated: animated)
            }
        }
    }
    
    func dismissViewController(animated: Bool, completion: (() -> Void)? = nil) {
        if let presentedViewController = presenter.presentedViewController {
            presentedViewController.dismiss(animated: animated, completion: completion)
        }
    }
    
    func presentViewController(_ uiViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presenter.present(uiViewController, animated: animated, completion: completion)
    }
    
    func pushViewController(_ uiViewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(uiViewController, animated: animated)
    }
    
    func presentView<Content: View>(view: Content,
                                    modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                                    presentAnimated: Bool = true,
                                    presentCompletion: (() -> Void)? = nil,
                                    transparentBackground: Bool = false,
                                    hideNavigationBar: Bool = false,
                                    contentViewBackground: UIColor? = nil) {
        let rootView = UIHostingController(rootView: view)
        rootView.navigationController?.isNavigationBarHidden = hideNavigationBar
        if contentViewBackground != nil {
            rootView.view.backgroundColor = contentViewBackground
        }
        if transparentBackground {
            rootView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }
        let navigationController = PSDKNavigationController(rootViewController: rootView)
        navigationController.modalPresentationStyle = modalPresentationStyle
        DispatchQueue.main.async {[weak self] in
            self?.presentViewController(navigationController,
                                        animated: presentAnimated,
                                        completion: presentCompletion)
        }
    }
    
    func dismissView(animated: Bool, completion: (() -> Void)? = nil) {
        guard let viewController = self.getTopestViewController() else { return }
        viewController.dismiss(animated: animated, completion: completion)
    }
    
    func getTopestViewController() -> UIViewController? {
        guard let topViewController = navigationController?.topViewController else { return nil}
        if let presentedViewController = topViewController.presentedViewController {
            return presentedViewController
        } else {
            return topViewController
        }
    }
    
    @available(iOSApplicationExtension, unavailable)
    func addWindowSubView<Content: View>(_ view: Content) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
                  window.subviews.first(where: {$0.accessibilityIdentifier == "\(view.self)"}) == nil else {
                return
            }
            let viewHostinController = UIHostingController(rootView: view)
            viewHostinController.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            viewHostinController.view.accessibilityIdentifier = "\(view.self)"
            viewHostinController.view.frame = window.frame
            window.addSubview(viewHostinController.view)
        }
    }
    
    @available(iOSApplicationExtension, unavailable)
    func removeWindowSubView(_ viewDescription: String) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
                  let view = window.subviews.first(where: {$0.accessibilityIdentifier == viewDescription}) else {
                return
            }
            view.removeFromSuperview()
        }
    }
    
}
