//
//  PSDKPhoneTextField.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 29/12/21.
//

import SwiftUI

struct PSDKPhoneTextField: View, DropdownDelegate, PSDKChooseTextFieldDelegate {
    
    typealias Item = CountryModel
    
    @Binding private var modalRouter: PSDKModalRouter
    @Binding private var text: String
    @Binding private var showDropdown: Bool
    @Binding private var item: Item?
    private let data: [Item]
    private let handler: TextValidationHandler
    var showSharedField: Bool = true
    
    var body: some View {
        PSDKChooseTextField(
            $text,
            modalRouter: $modalRouter,
            showDropdown: $showDropdown,
            data: data,
            hint: LanguageManager.shared.language.placeholder.phoneNumber,
            regex: "^[0-9 ]*$",
            pressMode: .pressStartIcon,
            editable: item != nil,
            minLength: 9,
            maxLength: 11,
            showEndView: false,
            keyboardType: .numberPad,
            handler: handler,
            delegate: self
        )
            .onAppear {
                if item == nil {
                    item = data.first
                }
            }
    }
    
    init (
        text: Binding<String>,
        item: Binding<Item?>,
        modalRouter: Binding<PSDKModalRouter>,
        showDropdown:  Binding<Bool>,
        handler: @escaping TextValidationHandler)
    {
        self._text = text
        self._item = item
        self._showDropdown = showDropdown
        self._modalRouter = modalRouter
        self.handler = handler
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
                PSDKText("\(item.flag)   +\(item.code)")
                withAnimation {
                    (showDropdown ? Image.arrowDropUpBlack : Image.arrowDropDownBlack)
                        .resizable()
                        .frame(width: 18, height: 18, alignment: .center)
                        .foregroundColor(.colorSurfaceHigh)
                }
            } else {
                EmptyView()
            }
        }.toAnyView()
    }
    
    func createDropdownElement<Item>(_ item: Item) -> DropdownOptionElement<Item> {
        return DropdownOptionElement(item: item, content: { pressed in
            HStack {
                if let item = item as? Self.Item {
                    Text("\(item.flag)  \(item.country) (+\(item.code))")
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
        }
    }
    
}

extension PSDKPhoneTextField {
    
    static func getData() -> [CountryModel] {
        let decoder = JSONDecoder()

        if let json = readLocalFile(forName: "phones") {
            do {
                let people = try decoder.decode([CountryModel].self, from: json)
                return people
            } catch {
                print(error)
                return []
            }
        }
        return []
    }
    
    static private func readLocalFile(forName name: String) -> Data? {
        do {
            guard let bundle = Bundle.psdkUIKitBundle() else {
                return nil
            }
            if let bundlePath = bundle.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
}

struct CountryModel: Decodable, Identifiable  {
    
    public var id = UUID()
    let flag: String
    let ic: String
    let country: String
    let code: String
    
    enum CodingKeys: String, CodingKey {
       case flag, country, code, ic
    }
    
}
