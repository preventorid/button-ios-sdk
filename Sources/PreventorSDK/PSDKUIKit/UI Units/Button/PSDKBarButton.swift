//
//  PSDKBarButton.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 17/01/22.
//

import UIKit

class PSDKBarButton: UIBarButtonItem {
    
    var customAction: () -> Void
    init(image: UIImage?,
         style: UIBarButtonItem.Style,
         customAction: @escaping () -> Void = {}
    ) {
        self.customAction = customAction
        super.init()
        self.image = image
        self.style = style
        self.target = self
        self.action = #selector(tapAction)
    }
    
    required init?(coder: NSCoder) {
        customAction = {
            
        }
        super.init(coder: coder)
    }
    
    @objc func tapAction() {
        customAction()
    }
    
}
