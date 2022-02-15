//
//  DocumentTypeView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 23/12/21.
//

import SwiftUI

struct DocumentTypeView: BaseView {
    
    var viewKey: ViewKey? {
        .documentType
    }
    @State var document: String = ""
    @ObservedObject private(set) var store: ReduxStore<PSDKEmptyState>
    @State var showDropdown: Bool = false
    @State var modalRouter: PSDKModalRouter = PSDKModalRouter()
    @State var item: PSDKDocumentTextfield.Item? = nil
    var demiModal: PSDKDemiModal? {
        PSDKDemiModal(presented: $showDropdown, router: modalRouter, opacity:  0.8 )
    }
    var textManager = LanguageManager.shared.language.pages.chooseDocument
    
    var contentBody: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
                VStack {
                    PSDKText(textManager.title, font: .psdkH5)
                        .padding(.top, height * 0.02)
                    Image.selectDocument
                        .padding(.top, height * 0.032)
                    PSDKText(textManager.subTitle)
                        .padding(.top, height * 0.015)
                        .padding(.horizontal, width * 0.02)
                        .animation(.default)
                    PSDKDocumentTextfield(
                        text: $document,
                        item: $item,
                        modalRouter: $modalRouter,
                        showDropdown: $showDropdown
                    )
                }
                .padding(.horizontal, width * 0.067)
        }
    }
    
    func nextAction() {
        if let documentType = item?.type {
            PSDKSession.shared.setDocumentType(documentType: documentType.rawValue)
            if PSDKSession.shared.withFlow() {
                store.parent?.dispatch(StepDocumentAction.nextScreen(true))
            } else {
                store.parent?.dispatch(StepDocumentAction.showReadyScan(type: documentType))
            }
        }
    }

}
