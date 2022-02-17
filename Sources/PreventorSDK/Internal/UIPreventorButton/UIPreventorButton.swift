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
        let child = UIHostingController(rootView: PreventorButton())
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.frame = self.bounds
        addSubview(child.view)
    }
    
}
