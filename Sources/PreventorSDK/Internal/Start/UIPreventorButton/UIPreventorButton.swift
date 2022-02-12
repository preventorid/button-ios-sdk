//
//  UIPreventorButton.swift
//  
//
//  Created by Alexander Rodriguez on 4/02/22.
//

import UIKit
import SwiftUI

class UIPreventorButton: UIView {
    
    override public func awakeFromNib() {
        super.awakeFromNib();
        let child = UIHostingController(rootView: PreventorButton(
            config: PreventorSDKConfig(flowType: "WF-01_7581390e-3938-44bf-8cd2-4f97e9306510",
                                       cifCode: "CIFCODE-OK-SALGUERO-SO-130",
                                       apiKey: "cnHl9mV33g6cE5TRg7PAK4xbC7i3m6o5iS56ZNoj",
                                       tenant: "preventordev",
                                       env: "playground",
                                       banknu: "1",
                                       secret: "preventor$$2021")))
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.frame = self.bounds
        addSubview(child.view)
    }
    
}
