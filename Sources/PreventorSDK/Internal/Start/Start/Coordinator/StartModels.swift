//
//  StartModels.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 17/01/22.
//

import Foundation

struct StringWithAttributes: Hashable, Identifiable {
    
    let id = UUID()
    let string: String
    let attrs: [NSAttributedString.Key: Any]
    
    static func == (lhs: StringWithAttributes, rhs: StringWithAttributes) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
