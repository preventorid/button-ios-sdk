//
//  ReadyScanMiddleware.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 21/01/22.
//

import UIKit
import DocumentReader

final class ReadyScanMiddleware: PSDKReduxMiddleware<ReadyScanState> {

    override func handleDispatch(action: ReduxAction,
                                 store: DispatcherObject,
                                 parent: DispatcherObject?) {
        guard let action = action as? ReadyScanAction else { return }
        switch action {
        case let .saveFrontImage(image):
            saveFrontImage(image: image)
        case let .saveBackImage(image):
            saveBackImage(image: image)
        case let .hiddeRegulaScan(data):
            hiddeRegulaScan(data: data)
        default: break
        }
    }
    
    private func hiddeRegulaScan(data: DocumentReaderResults?) {
        guard let data = data else { return }
        PSDKSession.shared.setUserData(data: .init(from: data))
        if let image = data.getGraphicFieldImageByType(fieldType: .gf_DocumentImage, source: .rawImage, pageIndex: 0) {
            PSDKSession.shared.setDocumentFront(image: image)
        }
        if let image = data.getGraphicFieldImageByType(fieldType: .gf_DocumentImage, source: .rawImage, pageIndex: 1) {
            PSDKSession.shared.setDocumentBack(image: image)
        }
        if PSDKSession.shared.withFlow() {
            store?.parent?.dispatch(StepDocumentAction.nextScreen())
        } else {
            store?.parent?.dispatch(StepDocumentAction.showSelfieStep)
        }
    }
    
    private func saveFrontImage(image: UIImage) {
        if store?.state.type.quantity == .two {
            store?.dispatch(ReadyScanAction.updateScreen(screen: .takeBackPhoto))
        } else {
            if PSDKSession.shared.withFlow() {
                store?.parent?.dispatch(StepDocumentAction.nextScreen())
            } else {
                store?.parent?.dispatch(StepDocumentAction.showSelfieStep)
            }
        }
        PSDKSession.shared.setDocumentFront(image: image)
    }
    
    private func saveBackImage(image: UIImage) {
        if PSDKSession.shared.withFlow() {
        store?.parent?.dispatch(StepDocumentAction.nextScreen())
        } else {
            store?.parent?.dispatch(StepDocumentAction.showSelfieStep)
        }
        PSDKSession.shared.setDocumentBack(image: image)
    }
    
}
