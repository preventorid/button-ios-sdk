//
//  ReculaScanView.swift
//  
//
//  Created by Alexander Rodriguez on 31/01/22.
//

import SwiftUI

struct ReculaScanView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<PSDKEmptyState>
    
    var contentBody: some View {
        GeometryReader { proxy in
            EmptyView()
        }
    }
    
    func nextAction() {
        
    }
    
}
