//
//  RegulaScan+SubViews.swift
//  
//
//  Created by Alexander Rodriguez on 31/01/22.
//

import Foundation
import SwiftUI
import DocumentReader

protocol RegulaScanViewDelegate {
    
    func getController() -> UIViewController
    func complete(data: DocumentReaderResults?)
    func handleError()
    func showScaner() -> Bool
    
}

struct RegulaScanView: UIViewControllerRepresentable {
    
    var delegate: RegulaScanViewDelegate
    unowned var controller: UIViewController
    
    init(delegate: RegulaScanViewDelegate) {
        self.delegate = delegate
        controller = delegate.getController()
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        context.coordinator.controller = self
        uiViewController.parent?.presentationController?.delegate = context.coordinator
        if delegate.showScaner() {
            initializeReader()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func setScenario() {
        DocReader.shared.processParams.scenario = RGL_SCENARIO_FULL_PROCESS
        DocReader.shared.customization.tintColor = .psdkColorPrimaryLigth200
        DocReader.shared.customization.resultStatusBackgroundColor = .colorGreenNormal
        DocReader.shared.processParams.timeoutFromFirstDocType = 999.00
        DocReader.shared.processParams.multipageProcessing = PSDKSession.shared.getQuantity() == .two ? true : false
        DocReader.shared.functionality.showSkipNextPageButton = false
        DocReader.shared.customization.cameraFrameBorderWidth = 4
        DocReader.shared.customization.cameraFrameDefaultColor = .colorEmphasisHigh
        DocReader.shared.customization.cameraFrameActiveColor = .psdkColorPrimaryLigth200
        DocReader.shared.customization.statusTextFont = .psdkH7
        DocReader.shared.customization.showResultStatusMessages = true
        DocReader.shared.customization.resultStatusTextFont = .psdkH6
        DocReader.shared.customization.cameraFrameOffsetWidth = 30
        DocReader.shared.functionality.showTorchButton = false
        DocReader.shared.functionality.orientation = .portrait
    }
    
    func showScanner() {
        print(controller)
        DocReader.shared.showScanner(controller) { (action, result, error) in
            switch action {
            case .complete:
                guard let result = result else {
                    self.delegate.complete(data: nil)
                    return
                }
                self.delegate.complete(data: result)
            case .error:
                if let error = error {
                    print("Error: \(error)")
                }
            default:
                break
            }
        }
    }
    
    func initializeReader() {
        do {
            guard let licensePath = Bundle.module.path(forResource: "regula.license", ofType: nil) else { return }
            let licenseData = try Data(contentsOf: URL(fileURLWithPath: licensePath))
            let config = DocReader.Config(license: licenseData)
            
            DocReader.shared.initializeReader(config: config) { (success, error) in
                if success {
                    self.setScenario()
                    self.showScanner()
                } else if let error = error {
                    // DocumentReader not initialized
                    print(error)
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        var controller: RegulaScanView
        
        init(_ controller: RegulaScanView) {
            self.controller = controller
        }
        
        override class func accessibilityScroll(_ direction: UIAccessibilityScrollDirection) -> Bool {
            false
        }
        
        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            
        }
    }
    
}



