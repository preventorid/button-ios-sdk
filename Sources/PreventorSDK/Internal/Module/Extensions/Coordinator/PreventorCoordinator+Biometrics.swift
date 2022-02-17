//
//  StepDocumentCoordinator.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 23/12/21.
//

import UIKit
import AVFoundation

extension ModulePreventorCoordinator {
    
    internal func handleBiometricsDispatch(
        action: ReduxAction,
        store: DispatcherObject,
        parent: DispatcherObject?
    ) -> Bool {
        guard let action = action as? BiometricsAction else { return false }
        switch action {
        case .showStartVerification:
            showStartVerification()
        case .showTermsConditions:
            showTermsConditions()
        case .showChooseCountry:
            showChooseCountry()
        case .showDocumentType:
            showDocumentType()
        case .showReadyScan:
            cameraAutherized(continueWith: showReadyScan)
        case .showSelfieStep:
            cameraAutherized(continueWith: showSelfieStep)
        case .backToScanDocument:
            backToScanDocument()
        case .backToSelfie:
            backToSelfie()
        case .showValidatingView:
            showValidatingView(middleware: OnboardingMiddleware(repository: repository))
        case .showCameraSettings:
            presentCameraSettings()
        case let .nextScreen(isFirst):
            if isFirst {
                routingManager?.checkIndex = 0
            }
            nextScreen()
        case let .showBiometricsResult(resultType):
            showBiometricsResult(resultType: resultType)
        }
        return true
    }
    
    private func stepDebug() {
        let view = RifReaderView(store: store!)
        pushView(view: view, animated: true)
    }
    
    private func showStartVerification() {
        let store = ReduxStore<StartState>(
            parent: self.store,
            state: StartState(),
            reducer: StartReducer(),
            middlewares: [],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = StartVerificationView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showTermsConditions() {
        let store = ReduxStore<CameraDeniedState>(
            parent: self.store,
            state: CameraDeniedState(),
            reducer: CameraDeniedReducer(),
            middlewares: [],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = TermsConditionsView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func nextScreen() {
        if let routingManager = routingManager {
            if let vid = routingManager.getNextScreen() {
                switch vid {
                case .selfPortraitTaking:
                    cameraAutherized(continueWith: showSelfieStep)
                case .documentPhotoTaking:
                    cameraAutherized(continueWith: showReadyScan)
                case .nextModule:
                    showValidatingView(middleware: OnboardingMiddleware(repository: repository))
                default:
                    break
                }
            }
        } else {
            store?.parent?.dispatch(AppFlow.showError)
        }
    }
    
    private func backToSelfie() {
        popToView(String(describing: SelfieView.self))
        routingManager?.forcePosition(verificationId: .identityVerification, check: .selfPortraitTaking)
    }
    
    private func backToScanDocument() {
        popToView(String(describing: ReadyScanView.self))
        routingManager?.forcePosition(verificationId: .identityVerification, check: .documentPhotoTaking)
    }
    
    private func showChooseCountry() {
        let store = ReduxStore<CameraDeniedState>(
            parent: self.store,
            state: CameraDeniedState(),
            reducer: CameraDeniedReducer(),
            middlewares: [],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = ChooseCountryView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showDocumentType() {
        let store = ReduxStore<PSDKEmptyState>(
            parent: self.store,
            state: PSDKEmptyState(),
            reducer: PSDKEmptyReducer(),
            middlewares: [],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = DocumentTypeView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showReadyScan() {
        let type: DocumentModel.DocType = .current ?? .visa
        let scanMode: ReadyScanState.ScanMode = PSDKSession.shared.getDatabaseState() == .success ?
            .withRegula : .withOutRegula
        let store = ReduxStore<ReadyScanState>(
            parent: self.store,
            state: ReadyScanState(screen: .ready, type: type, scanMode: scanMode),
            reducer: ReadyScanReducer(),
            middlewares: [ReadyScanMiddleware()],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = ReadyScanView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func cameraAutherized(continueWith nextAction: @escaping () -> Void ) {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            nextAction()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    nextAction()
                } else {
                    self.store?.parent?.dispatch(AppFlow.showCameraAccessDenied)
                }
            })
        }
    }
    
    private func presentCameraSettings() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Camera access is denied",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    self.store?.dispatch(AppFlow.back)
                })
            }
        })
        presentViewController(alertController, animated: true, completion: {
            
        })
    }
    private func showSelfieStep() {
        let store = ReduxStore<SelfieState>(
            parent: self.store,
            state: SelfieState(),
            reducer: SelfieReducer(),
            middlewares: [],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = SelfieView(store: store)
        pushView(view: view, animated: true)
    }
    
    private func showBiometricsResult(resultType: BiometricsResultType) {
        if let store = store {
            let view = BiometricsResultView(store: store, type: resultType)
            pushView(view: view, animated: true)
        }
    }
    
}
