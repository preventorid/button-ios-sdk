//
//  PSDKDocumentTextfield.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 7/01/22.
//

import SwiftUI

struct PSDKDocumentTextfield: View, DropdownDelegate, PSDKChooseTextFieldDelegate {
    
    typealias Item = DocumentModel
    
    @Binding private var modalRouter: PSDKModalRouter
    @Binding private var text: String
    @Binding private var showDropdown: Bool
    @Binding private var item: Item?
    private let data: [Item]
    
    var body: some View {
        PSDKChooseTextField(
            $text,
            modalRouter: $modalRouter,
            showDropdown: $showDropdown,
            data: data,
            hint: LanguageManager.shared.language.placeholder.selectTypeId,
            delegate: self
        )
    }
    
    init (
        text: Binding<String>,
        item: Binding<Item?>,
        modalRouter: Binding<PSDKModalRouter>,
        showDropdown:  Binding<Bool>)
    {
        self._text = text
        self._item = item
        self._showDropdown = showDropdown
        self._modalRouter = modalRouter
        var _data: [Item] = []
        PSDKSession.shared.generalConfig?.identityDocuments.forEach { doc in
            if doc.enabled ?? false, let docType = DocumentModel.DocType(rawValue: doc.documentType) {
                _data.append(.init(type: docType))
            }
        }
        self.data = _data
    }
    
    func filterData<T>(item: T, text: String) -> Bool {
        true
    }
    
    func startView() -> AnyView {
        return HStack {
            self.item?.icon.foregroundColor(.colorEmphasisHigh)
        }.toAnyView()
    }
    
    func selectValue<Item>(_ item: Item) {
        if let item = item as? Self.Item {
            self.item = item
            self.text = item.document
        }
    }
    
    func createDropdownElement<Item>(_ item: Item) -> DropdownOptionElement<Item> {
        return DropdownOptionElement(item: item, content: { pressed in
            HStack {
                if let item = item as? Self.Item {
                    item.icon
                        .foregroundColor(pressed ? .colorEmphasisHigh: .colorSurfaceHigh)
                        .padding(.leading, 24)
                    Text(item.document)
                        .font(.psdkH8)
                        .foregroundColor(.psdkTextColorPrimaryLight)
                        .padding(.horizontal, 16)
                        .background(Color.clear)
                }
                Spacer()
            }
            .toAnyView()
        })
    }
    
}
