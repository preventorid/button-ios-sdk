//
//  MainNavigationController.swift
//  Berlin-iOS
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import SwiftUI

final class PSDKNavigationController: UINavigationController {
    
    private var navigationSettings: PSDKNavigationSettings?
    public var finish: (PreventorSDKErrorCode?) -> Void = { _ in }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let settings = navigationSettings {
            return settings.statusBarStyle
        } else if self.traitCollection.userInterfaceStyle == .dark {
            return .darkContent
        } else {
            return .lightContent
        }
    }
    
    func finalize(with error: PreventorSDKErrorCode?) {
        finish(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let isRootViewController = self.viewControllers.isEmpty
        if !isRootViewController && viewController.isKind(of: PSDKHostingViewController.self) {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func setupNavigationBar(navigationSettings: PSDKNavigationSettings, animated: Bool) {
        self.navigationSettings = navigationSettings
        setNeedsStatusBarAppearanceUpdate()
        self.setNavigationBarHidden(navigationSettings.navigationBarHidden, animated: animated)
        let navigationBarAppearance = UINavigationBarAppearance()
        if navigationSettings.isOpaque {
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = navigationSettings.navigationBarColor
            navigationBarAppearance.shadowColor = .clear
        } else {
            navigationBarAppearance.configureWithTransparentBackground()
        }
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: navigationSettings.navigationBarTintColor]
        
        var backButton = UIImage.navigationBackButton
            .resized(to: CGSize(width: 30, height: 30))
        let alignment = backButton.alignmentRectInsets
        backButton = backButton.withAlignmentRectInsets(.init(top: alignment.top,
                                                              left: alignment.left,
                                                              bottom: alignment.bottom + 5,
                                                              right: alignment.right))
        navigationBarAppearance.setBackIndicatorImage(backButton,
            transitionMaskImage: backButton)
        
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.compactAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.tintColor = navigationSettings.navigationBarTintColor
    }

}
