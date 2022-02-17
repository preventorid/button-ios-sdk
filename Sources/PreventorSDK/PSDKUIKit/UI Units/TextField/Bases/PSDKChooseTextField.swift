//
//  PSDKChooseTextField.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 22/12/21.
//

import SwiftUI

protocol PSDKChooseTextFieldDelegate {
    
    func startView() -> AnyView
    func selectValue<Item>(_ item: Item)
    
}

protocol DropdownDelegate {
    
    var showSharedField: Bool { get }
    func createDropdownElement<T>(_ item: T) -> DropdownOptionElement<T>
    func filterData<T>(item: T, text: String) -> Bool
    
}

extension DropdownDelegate {
    
    var showSharedField: Bool { false }
    
}


enum PressedMode {
    
    case pressStartIcon
    case pressEndIcon
    case pressAny
    
}

struct PSDKChooseTextField<Item: Identifiable>: View{
    
    @Binding private var modalRouter: PSDKModalRouter
    @Binding private var text: String
    @Binding private var showDropdown: Bool
    let delegate: (PSDKChooseTextFieldDelegate & DropdownDelegate)
    let data: [Item]
    let hint: String
    let regex: String
    let minLength: Int
    let maxLength: Int
    let keyboardType: UIKeyboardType
    let pressMode: PressedMode
    let editable: Bool
    let showEndView: Bool
    let handler: TextValidationHandler?
    var showSharedField: Bool {
        data.count > 5
    }
    
    private var startView: AnyView {
        return delegate.startView()
    }
    
    var body: some View {
        var tf = TextFieldBase(
                text: $text,
                hint: hint,
                regex: regex,
                editable: editable,
                minLength: minLength,
                maxLength: maxLength,
                keyboardType: keyboardType,
                handler: handler
            )
            .withStartView {
                HStack {
                    startView.onTapGesture {
                        showDropdown(.pressStartIcon)
                    }
                }
            }
        if showEndView {
            tf = tf.withEndView {
                withAnimation {
                    (showDropdown ? Image.arrowDropUpBlack : Image.arrowDropDownBlack)
                        .resizable()
                        .colorMultiply(.colorSurfaceHigh)
                        .frame(width: 18, height: 18, alignment: .center)
                        .onTapGesture {
                            showDropdown(.pressEndIcon)
                        }
                }
            }
        }
        return ZStack {
            tf
        }.onTapGesture {
            showDropdown(.pressAny)
        }
    }

    init(
        _ text: Binding<String>,
        modalRouter: Binding<PSDKModalRouter>,
        showDropdown: Binding<Bool>,
        data: [Item],
        hint: String = "",
        regex: String = "^[0-9 ]*$",
        pressMode: PressedMode = .pressAny,
        editable: Bool = false,
        minLength: Int = 0,
        maxLength: Int = TextFieldBase.infinity,
        showEndView: Bool = true,
        keyboardType: UIKeyboardType  = .default,
        handler: TextValidationHandler? = nil,
        delegate: (PSDKChooseTextFieldDelegate & DropdownDelegate)
    ){
        self.delegate = delegate
        self._text = text
        self.data = data
        self.hint = hint
        self.keyboardType = keyboardType
        self.regex = regex
        self.pressMode = pressMode
        self.editable = editable
        self.minLength = minLength
        self.maxLength = maxLength
        self.showEndView = showEndView
        self.handler = handler
        self._showDropdown = showDropdown
        self._modalRouter = modalRouter
    }

    func onTaped(_ item: Item) {
        delegate.selectValue(item)
        withAnimation {
            self.showDropdown = false
        }
        ApplicationUtil.endEditing()
    }
    
    func showDropdown(_ mode: PressedMode) {
        if pressMode == .pressAny || mode == pressMode {
            withAnimation {
                self.modalRouter.pushRoute(
                    PSDKModalRoute(
                    title: "",
                    view: Dropdown(
                        delegate: delegate,
                        options: data,
                        hint: hint,
                        showSharedField: showSharedField,
                        onTaped: onTaped)
                        .transition(.move(edge: .bottom))
                        .toAnyView
                    )
                )
                showDropdown.toggle()
            }
        }
    }
    
}

struct Dropdown<Item: Identifiable>: View{
    
    @State var text: String = ""
    var hint: String
    var options: [Item]
    let onTaped: (Item) -> Void
    let delegate: DropdownDelegate
    
    var body: some View {
        VStack {
            if delegate.showSharedField {
                TextFieldBase(text: $text, hint: hint)
                    .withEndView {
                        Image.iconSearch
                    }
                    .padding(.horizontal, 16)
            }
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 0) {
                    if !text.isEmpty {
                        let searchData = options.filter { value in
                            delegate.filterData(item: value, text: text)
                        }
                        ForEach(searchData) { item in
                            delegate.createDropdownElement(item)
                                .withCusstomTapped(tapped: self.onTaped)
                        }
                    } else {
                        ForEach(options) { item in
                            delegate.createDropdownElement(item)
                                .withCusstomTapped(tapped: self.onTaped)
                        }
                    }
                    
                }
            }
            .frame(minHeight: 0,
                   maxHeight: delegate.showSharedField ? .infinity: CGFloat(options.count) * 48)
        }
        .background(Color.psdkWhite)
    }
    
    init(
        delegate: DropdownDelegate,
        options: [Item],
        hint: String = "",
        showSharedField: Bool,
        onTaped: @escaping (Item) -> Void
    ) {
        self.delegate = delegate
        self.options = options
        self.hint = hint
        self.onTaped = onTaped
    }
    
}

struct DropdownOptionElement<Item1> : View{
    
    typealias Item = Item1
    
    let content: (Bool) -> AnyView
    let item: Item
    var onTapped: (Item) -> Void = { _ in
        
    }
    @State private var pressed: Bool = false
    
    var body: some View {
        content(pressed)
        .frame(height: 48, alignment: .center)
        .background(pressed ? Color.psdkColorTextFieldMedium : Color.psdkWhite)
        .onTapGesture {
            onTapped(item)
        }
        .onLongPressGesture( pressing: { pressed in
            self.pressed = pressed
        }, perform: {
            onTapped(item)
        })
    }
    
    init(item: Item, content: @escaping (Bool) -> AnyView){
        self.item = item
        self.content = content
    }
    
}

extension DropdownOptionElement {
    
    func withCusstomTapped(tapped: @escaping (Item) -> Void ) -> DropdownOptionElement {
        var new = self
        new.onTapped = tapped
        return new
    }
    
}

struct DocumentModel: Identifiable  {
    
    let id = UUID()
    let type: DocType
    
    var icon: Image {
        switch type {
        case .passport:
            return .documentPassportActive
        case .driverLicense:
            return .documentDriverActive
        case .idCard:
            return .documentNationalActive
        case .visa:
            return .documentVisaActive
        }
    }
    var document: String {
        type.description
    }
    
    enum Quantity: Int {
        case one = 1
        case two = 2
    }
    
    enum DocType: String {
        
        case passport = "PASSPORT"
        case driverLicense = "DRIVER_LICENSE"
        case idCard = "ID_CARD"
        case visa = "VISA"
        
        var description: String {
            switch self {
            case .passport:
                return LanguageManager.shared.language.placeholder.passport
            case .driverLicense:
                return LanguageManager.shared.language.placeholder.driverLicense
            case .idCard:
                return LanguageManager.shared.language.placeholder.idCard
            case .visa:
                return LanguageManager.shared.language.placeholder.visa
            }
        }
        
        var quantity: Quantity {
            switch self {
            case .visa, .passport:
                return .one
            case .idCard, .driverLicense:
                return .two
            }
        }
        
        static var current: DocType? {
            DocumentModel.DocType(rawValue: PSDKSession.shared.getDocumentType())
        }
        
    }
    
}
