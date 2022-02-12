//
//  PSDKNavigationSettings.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import UIKit
import SwiftUI

struct PSDKNavigationSettings {
    
    static var `default`: PSDKNavigationSettings = {
        PSDKNavigationSettings(
            statusBarStyle: .darkContent,
            navigationBarTintColor: UIColor.black,
            isOpaque: true
        )
    }()
    
    var title: String?
    var titleView: UIView?
    var navigationBarHidden: Bool
    var hidesBackButton: Bool
    var backButtonTitle: String?
    var leadingItems: [UIBarButtonItem]
    var trailingItems: [UIBarButtonItem]
    var navigationBarColor: UIColor
    var backgroundColor: UIColor
    var statusBarStyle: UIStatusBarStyle
    var navigationBarTintColor: UIColor
    var isOpaque: Bool
    
    init(title: String? = nil,
                titleView: UIView? = nil,
                navigationBarHidden: Bool = false,
                hidesBackButton: Bool = false,
                backButtonTitle: String? = nil,
                leadingItems: [UIBarButtonItem] = [],
                trailingItems: [UIBarButtonItem] = [],
                navigationBarColor: UIColor = .psdkWhite,
                backgroundColor: UIColor = UIColor.psdkWhite,
                statusBarStyle: UIStatusBarStyle = .lightContent,
                navigationBarTintColor: UIColor = .colorSurfaceHigh,
                isOpaque: Bool = false) {
        self.title = title
        self.titleView = titleView
        self.navigationBarHidden = navigationBarHidden
        self.hidesBackButton = hidesBackButton
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
        self.navigationBarColor = navigationBarColor
        self.backgroundColor = backgroundColor
        self.statusBarStyle = statusBarStyle
        self.navigationBarTintColor = navigationBarTintColor
        self.backButtonTitle = backButtonTitle
        self.isOpaque = isOpaque
    }
    
}
