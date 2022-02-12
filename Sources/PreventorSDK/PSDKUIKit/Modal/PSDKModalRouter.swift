//
//  PSDKModalRouter.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 03/01/22.//

import SwiftUI
import Combine

class PSDKModalRouter: ObservableObject {
    
    @Published var currentRoute: PSDKModalRoute?
    @Published var canGoBack: Bool = false
    var navigationStack: [PSDKModalRoute] {
        didSet {
            self.canGoBack = navigationStack.count > 1
        }
    }
    
    init() {
        self.navigationStack = []
    }
    
    init(root: PSDKModalRoute) {
        self.currentRoute = root
        self.navigationStack = [root]
    }
    
    func pushRoute(_ route: PSDKModalRoute) {
        navigationStack.append(route)
        withAnimation(.easeIn(duration: 0.2)) {
            self.currentRoute = route
        }
    }
    
    func popRoute() {
        if navigationStack.popLast() != nil, let newLast = navigationStack.last {
            withAnimation(.easeOut(duration: 0.2)) {
                self.currentRoute = newLast
            }
        }
    }
    
    func dismiss() {
        self.navigationStack = []
    }
    
}

struct PSDKModalRoute: Equatable {
    
    let id: String
    let navigationTitle: String
    let view: AnyView
    
    init(title: String, @ViewBuilder view: () -> AnyView) {
        self.id = UUID().uuidString
        self.navigationTitle = title
        self.view = view()
    }
    
    static func == (lhs: PSDKModalRoute, rhs: PSDKModalRoute) -> Bool {
        lhs.id == rhs.id
    }
    
}
