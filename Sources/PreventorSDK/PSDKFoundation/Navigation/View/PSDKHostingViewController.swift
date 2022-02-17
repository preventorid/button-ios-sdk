//
//  PSDKHostingViewController.swift
//  PSDKFoundation
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import SwiftUI

typealias ViewSetup = (didLayout: Bool, animated: Bool)

final class PSDKHostingViewController: UIHostingController<AnyView> {
    
    private var viewSetup: ViewSetup = (false, false)
    private(set) var identifier: String
    private(set) var navigationSettings: PSDKNavigationSettings?
    var customNavigationController: PSDKNavigationController? {
        return self.navigationController as? PSDKNavigationController
    }
    var didPopViewController: (() -> Void)?
    private var logger: PSDKLogger?
    
    init<RootView: ReduxView>(rootView: RootView,
                                     identifier: String? = nil,
                                     logger: PSDKLogger? = nil) {
        self.navigationSettings = rootView.navigationSettings
        if let id = identifier {
            self.identifier = id
        } else {
            self.identifier = String(describing: RootView.self)
        }
        self.logger = logger
        super.init(rootView: AnyView(rootView))
        self.view.backgroundColor = self.navigationSettings?.backgroundColor
        self.navigationItem.backButtonTitle = ""
    }
    
    init<RootView: View>(rootView: RootView,
                                identifier: String? = nil,
                                logger: PSDKLogger? = nil) {
        if let id = identifier {
            self.identifier = id
        } else {
            self.identifier = String(describing: RootView.self)
        }
        self.logger = logger
        super.init(rootView: AnyView(rootView))
        self.view.backgroundColor = self.navigationSettings?.backgroundColor
        self.navigationItem.backButtonTitle = ""
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.viewSetup.didLayout {
            self.setupNavigationBar(self.viewSetup.animated)
        }
        self.viewSetup = (false, false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar(animated)
        self.viewSetup = (true, animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParent {
            self.didPopViewController?()
        }
    }

    func updateNavigationBar(navigationSettings: PSDKNavigationSettings?, animated: Bool) {
        self.navigationSettings = navigationSettings
        self.setupNavigationBar(animated)
    }

    private func setupNavigationBar(_ animated: Bool) {
        guard let navigationBarSettings = navigationSettings else { return }
        // Setup NavigationBar
        self.customNavigationController?.setupNavigationBar(navigationSettings: navigationBarSettings, animated: animated)
        // Setup NavigationItem Properties
            // Setup Title or TitleView
        if let navigationTitle = navigationBarSettings.title {
            self.navigationItem.title = navigationTitle
        } else if let navigationTitleView = navigationBarSettings.titleView {
            self.navigationItem.titleView = navigationTitleView
        }
            // Back Button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.setHidesBackButton(
            navigationBarSettings.hideBackButton,
            animated: animated
        )
        
            // Leading Items
        self.navigationItem.setLeftBarButtonItems(
            navigationBarSettings.leadingItems,
            animated: animated
        )
            // Trailing Items
        self.navigationItem.setRightBarButtonItems(
            navigationBarSettings.trailingItems,
            animated: animated
        )
    }
    
}
