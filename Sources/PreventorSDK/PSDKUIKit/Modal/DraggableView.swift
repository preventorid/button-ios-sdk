//
//  DraggableView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 03/01/22.
//

import Foundation
import SwiftUI

struct DraggableView<Content: View>: View {
    
    enum DragDirection {
        case vertical, horizontal, downwards, upwards
    }
    
    var content: Content
    var direction: DragDirection
    var didDrag: () -> Void
    let minimumDrag: CGFloat
    @State private var dragAmount = CGSize.zero
    @State private var frame: CGSize = CGSize.zero
    
    init(dragDirection: DragDirection,
                minimumDrag: CGFloat,
                didDrag: @escaping () -> Void,
                @ViewBuilder _ content: () -> Content) {
        self.direction = dragDirection
        self.minimumDrag = minimumDrag
        self.content = content()
        self.didDrag = didDrag
    }
    
    var body: some View {
        content
            .offset(self.dragAmount)
            .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: CoordinateSpace.global)
                    .onChanged { (value) in
                        switch direction {
                        case .vertical:
                            self.dragAmount = CGSize(width: 0, height: value.translation.height)
                        case .horizontal:
                            self.dragAmount = CGSize(width: value.translation.width, height: 0)
                        case .downwards:
                            let translationHeight = value.translation.height
                            let height = translationHeight > 0 ? translationHeight : 0
                            self.dragAmount = CGSize(width: 0, height: height)
                        case .upwards:
                            let translationHeight = value.translation.height
                            let height = translationHeight < 0 ? translationHeight : 0
                            self.dragAmount = CGSize(width: 0, height: height)
                        }
                    }
                    .onEnded { value in
                        var dragLength: CGFloat = 0
                        switch direction {
                        case .vertical:
                            dragLength = value.translation.height
                        case .horizontal:
                            dragLength = value.translation.width
                        case .downwards:
                            let translationHeight = value.translation.height
                            let height = translationHeight > 0 ? translationHeight : 0
                            dragLength = height
                        case .upwards:
                            let translationHeight = value.translation.height
                            let height = translationHeight < 0 ? translationHeight : 0
                            dragLength = height
                        }
                        if dragLength >= minimumDrag {
                            self.didDrag()
                        } else {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                self.dragAmount = CGSize.zero
                            }
                        }
                    }
            )
    }
    
}
