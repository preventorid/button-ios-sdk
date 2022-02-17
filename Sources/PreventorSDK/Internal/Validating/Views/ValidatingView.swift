//
//  ValidatingView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 10/02/22.
//

import SwiftUI

struct ValidatingView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<PSDKEmptyState>
    
    var showNextButton: Bool { false }
    var hideBackButton: Bool { true }
    var hideTrailingItems: Bool { true }
    
    var contentBody: some View {
        ProgressView()
        .onAppear {
            store.dispatch(ValidantingAction.validateInfo)
        }
    }
    
    func nextAction() {
        //Any
    }
    
}
