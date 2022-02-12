//
//  NSAttributtes+Extensions.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 17/01/22.
//

import Foundation

extension NSAttributedString {
    var stringsWithAttributes: [StringWithAttributes] {
        var attributes = [StringWithAttributes]()
        enumerateAttributes(in: NSRange(location: 0, length: length), options: []) { (attrs, range, _) in
            let string = attributedSubstring(from: range).string
            let components = string.components(separatedBy: " ")
            components.forEach { component in
                let item = component + " "
                attributes.append(StringWithAttributes(string: item, attrs: attrs))
            }
        }
        return attributes
    }
}
