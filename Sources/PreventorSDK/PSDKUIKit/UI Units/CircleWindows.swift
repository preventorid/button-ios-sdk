//
//  CircleWindows.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 17/01/22.
//

import SwiftUI

struct CircleWindows: Shape {
    let size: CGSize
    let origin: CGPoint
    func path(in rect: CGRect) -> Path {
        var path = Rectangle().path(in: rect)
        path.addEllipse(in: CGRect(origin: origin, size: size))
        return path
    }
}
