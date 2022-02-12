//
//  PSDKCountryTextField.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 7/01/22.
//

import SwiftUI

struct PSDKCountryTextField: View, DropdownDelegate, PSDKChooseTextFieldDelegate {
    
    typealias Item = CountryModel
    
    @Binding private var modalRouter: PSDKModalRouter
    @Binding private var text: String
    @Binding private var showDropdown: Bool
    @Binding private var item: Item?
    private let data: [Item]
    var showSharedField: Bool = true
    var body: some View {
        PSDKChooseTextField(
            $text,
            modalRouter: $modalRouter,
            showDropdown: $showDropdown,
            data: data,
            hint: LanguageManager.shared.language.placeholder.country,
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
        self.data = PSDKPhoneTextField.getData()
    }
    
    func filterData<T>(item: T, text: String) -> Bool {
        if let item = item as? Self.Item {
            return item.country.localizedCaseInsensitiveContains(text)
        }
        return false
    }
    
    func startView() -> AnyView {
        return HStack {
            if let item = item {
                PSDKText("\(item.flag)")
            } else {
                EmptyView()
            }
        }.toAnyView()
    }
    func createDropdownElement<Item>(_ item: Item) -> DropdownOptionElement<Item> {
        return DropdownOptionElement(item: item, content: { pressed in
            HStack {
                if let item = item as? Self.Item {
                    Text("\(item.flag)")
                        .padding(.leading, 24)
                    Text("\(item.country)")
                        .font(.psdkH8)
                        .foregroundColor(.psdkTextColorPrimaryLight)
                        .padding(.horizontal, 16)
                        .background(Color.clear)
                    Spacer()
                }
            }
            .toAnyView()
        })
    }
    
    func selectValue<Item>(_ item: Item) {
        if let item = item as? Self.Item {
            self.item = item
            self.text = item.country
        }
    }
    
}

extension PSDKCountryTextField {
    
    static func getData() -> [CountryModel] {
        let decoder = JSONDecoder()

        if let json = Bundle.readLocalFile(forName: "phones") {
            do {
                let people = try decoder.decode([CountryModel].self, from: json)
                return people
            } catch {
                return []
            }
        }
        return []
    }
    
}
