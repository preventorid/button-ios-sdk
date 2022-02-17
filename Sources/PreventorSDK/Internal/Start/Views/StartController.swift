//
//  StartController.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 16/12/21.
//

import UIKit
import SwiftUI
import DocumentReader

struct StartController: UIViewControllerRepresentable {
    
    let controller: PSDKNavigationController
    let onDismissalAttempt: () -> Void
    
    init(_ delegate: ModuleAppCoordinator,
         onDismissalAttempt: @escaping ()->()
    ) {
        delegate.start()
        self.onDismissalAttempt = onDismissalAttempt
        self.controller = delegate.navigationController
        self.controller.modalPresentationStyle = .fullScreen
    }
    
    func makeUIViewController(context: Context) -> PSDKNavigationController {
        return controller
    }

    func updateUIViewController(_ uiViewController: PSDKNavigationController, context: Context) {
        context.coordinator.controller = self
        uiViewController.parent?.presentationController?.delegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        var controller: StartController
        
        init(_ controller: StartController) {
            self.controller = controller
        }
        
        override class func accessibilityScroll(_ direction: UIAccessibilityScrollDirection) -> Bool {
            false
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            .fullScreen
        }
        
        func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
            false
        }
        
        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            controller.onDismissalAttempt()
        }
    }
}
