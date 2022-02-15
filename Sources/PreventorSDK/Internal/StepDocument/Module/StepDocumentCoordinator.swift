//
//  StepDocumentCoordinator.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 23/12/21.
//

import UIKit
import AVFoundation

protocol StepDocumentCoordinatorDelegate: AnyObject {
    
}

final class StepDocumentCoordinator: PSDKReduxCoordinator<PSDKEmptyState> {
    
    private weak var delegate: StepDocumentCoordinatorDelegate?
    private let repository: PreventorRepository
    private let routingManager: RoutingManager?
    
    init(_ dependencies: StepDocumentDependecies) {
        self.delegate = dependencies.delegate
        self.repository = dependencies.repository
        routingManager = RoutingManager(verification: VerificationsID.identityVerification.toVerification, maxCheckIndex: 2)
        super.init(presenter: dependencies.navigationController)
    }
    
    override func handleDispatch(action: ReduxAction, store: DispatcherObject, parent: DispatcherObject?) -> Bool {
        if let action = action as? AppFlow {
            self.store?.parent?.dispatch(action)
            return true
        }
        guard let action = action as? StepDocumentAction else { return false }
        switch action {
        case .showChooseCountry:
            showChooseCountry()
        case .showDocumentType:
            showDocumentType()
        case let .showReadyScan(type):
            cameraAutherized(continueWith: {
                self.showReadyScan(type: type)
            })
        case .showSelfieStep:
            cameraAutherized(continueWith: showSelfieStep)
        case .backToScanDocument:
            backToScanDocument()
        case .showValidatingView:
            showValidatingView()
        case .backToSelfie:
            backToSelfie()
        case .showCameraSettings:
            presentCameraSettings()
        case let .nextScreen(isFirst):
            if isFirst {
                routingManager?.checkIndex = 0
            }
            nextScreen()
        }
        return true
    }

    override func start() {
        self.store?.dispatch(StepDocumentAction.showDocumentType)
    }
    
    func nextScreen() {
        if let routingManager = routingManager {
            if let vid = routingManager.getNextScreen() {
                switch vid {
                case .selfPortraitTaking:
                    cameraAutherized(continueWith: showSelfieStep)
                case .documentPhotoTaking:
                    showReadyScan(type: .current ?? .visa)
                case .nextModule:
                    cameraAutherized(continueWith: showValidatingView)
                default:
                    break
                }
            }
        } else {
            store?.parent?.dispatch(AppFlow.showError)
        }
    }
    
    func backToSelfie() {
        popToView(String(describing: SelfieView.self))
    }
    
    func backToScanDocument() {
        popToView(String(describing: ReadyScanView.self))
    }
    
    private func showChooseCountry(){
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
    
    func showDocumentType(){
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
    
    func showReadyScan(type: DocumentModel.DocType){
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
    func showSelfieStep() {
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
    
    func showValidatingView() {
        let store = ReduxStore<ValidantingState>(
            parent: self.store,
            state: ValidantingState(),
            reducer: ValidantingReducer(),
            middlewares: [ValidantingMiddleware(repository: repository)],
            coordinator: self
        )
        self.store?.addChild(store: store)
        let view = ValidatingView(store: store)
        pushView(view: view, animated: true)
    }
    
}
