//
//  TextFieldBase.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 29/12/21.
//

import Foundation
import SwiftUI
import Combine

typealias TextValidationHandler = (_ text: String, _ currentStatus: ValidationResult, _ validationResult: @escaping (_ result: ValidationResult) -> Void) -> Void

enum ValidationResult: Equatable {
    
    case none
    case valid
    case invalid(_ errorMessage: String?)
    case warning
    
}

struct TextFieldBase: View {
    
    static let infinity = -1
    @Binding var text: String
    @Binding private var validation: ValidationResult
    @State var validationResult: ValidationResult = .none
    @State var isFocused: Bool = false
    @State var prevText: String = ""
    private var coordinator: Coordinator? = nil
    var editable: Bool
    var content: AnyView?
    var startView: AnyView?
    var endView: AnyView?
    var autocapitalization: UITextAutocapitalizationType
    var keyboardType: UIKeyboardType
    let handler: TextValidationHandler?
    let onSubmit: ((ValidationResult) -> Void)?
    let onChanged: ((String) -> Void)?
    let hint: String
    var formatRegex: String
    var minLength: Int
    var maxLength: Int
    var hitColor: Color {
        switch validationResult {
        case .invalid:
            return .psdkRed
        default:
            return .psdkColorTextLow
        }
    }
    var tintColor: Color {
        switch validationResult {
        case .invalid:
            return .psdkRed
        default:
            return .colorSurfaceHigh
        }
    }
    var message: String? {
        switch validationResult {
        case let .invalid(value):
            return value
        default :
            return nil
        }
    }
    var outlineColor: Color {
        switch validationResult {
        case .invalid:
            return .psdkColorSemanticDanger
        default:
            return .psdkColorTextFieldMedium
        }
    }
    var lineWidth: CGFloat {
        switch validationResult {
        case .invalid:
            return 2.0
        default:
            return 1.0
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 5) {
                
                HStack(spacing: 0) {
                    if let view = startView {
                        view
                            .padding(.leading, 12)
                    }
                    if let customContent = content {
                        customContent
                            .padding(.horizontal, 16)
                    } else {
                        TextField("", text: $text, onEditingChanged: { isFocused in
                            self.isFocused = isFocused
                            if !isFocused {
                                submit()
                            }
                        })
                            .disableAutocorrection(true)
                            .autocapitalization(autocapitalization)
                            .keyboardType(keyboardType)
                            .placeholder(when: text.isEmpty, {
                                PSDKText(hint, textColor: .psdkColorTextLow, font: .psdkH8 )
                            })
                            .font(.psdkH8)
                            .foregroundColor(.psdkTextColorPrimaryLight)
                            .padding(.horizontal, 16)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .disabled(!editable)
                            .onReceive(Just(text)) { text in
                                onChangedDefault(text: text)
                            }
                    }
                    
                    if let view = endView {
                        view
                            .padding(.trailing, 16)
                            .foregroundColor(tintColor)
                            .frame(alignment: .trailing)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .frame(height: 56, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(outlineColor, lineWidth: lineWidth)
                )
                .padding(.top, 7)
                if let message = self.message {
                    Text(message)
                        .font(.psdkL3)
                        .foregroundColor(.psdkRed)
                        .frame(alignment: .leading)
                        .padding(.leading, 16)
                        .animation(.default)
                }
            }
            if !hint.isEmpty && !text.isEmpty {
                Text(hint)
                    .padding(.horizontal, 4)
                    .background(Color.psdkWhite)
                    .offset(x: 12, y: 0)
                    .foregroundColor(hitColor)
                    .font(.psdkL3)
                    .animation(.linear)
            }
        }
    }
    
    init(
        text: Binding<String>,
        hint: String,
        validation: Binding<ValidationResult>? = nil,
        regex: String = "(?s).*",
        editable: Bool = true,
        minLength: Int = 0,
        maxLength: Int = infinity,
        autocapitalization: UITextAutocapitalizationType = .sentences,
        keyboardType: UIKeyboardType = .default,
        handler: TextValidationHandler? = nil,
        onChanged: ((String) -> Void)? = nil,
        onSubmit: ((ValidationResult) -> Void)? = nil
    ) {
        self._validation = validation ?? .constant(.none)
        self.coordinator = Coordinator()
        self.hint = hint
        self._text = text
        self.handler = handler
        self.editable = editable
        self.minLength = minLength
        self.maxLength = maxLength
        self.autocapitalization = autocapitalization
        self.keyboardType = keyboardType
        self.onSubmit = onSubmit
        self.formatRegex = regex
        self.startView = nil
        self.endView = nil
        self.onChanged = onChanged
    }
    
}

extension TextFieldBase {
    
    func withStartView<Content: View>(_ view: @escaping () -> Content) -> TextFieldBase {
        var textField = self
        textField.startView = AnyView(view())
        return textField
    }
    
    func withEndView<Content: View>(_ view: @escaping () -> Content) -> TextFieldBase {
        var textField = self
        textField.endView = AnyView(view())
        return textField
    }
    
    func withCustomTextField<Content: View>(_ view: @escaping () -> Content) -> TextFieldBase {
        var textField = self
        textField.content = AnyView(view())
        return textField
    }
    
    private func submit() {
        validateFormat(showError: true)
        onSubmit?(validationResult)
    }
    
    private func onChangedDefault(text: String){
        if prevText != text {
            if onChanged != nil {
                onChanged?(text)
            } else {
                if isFocused {
                    validateFormat(showError: false)
                }
                if maxLength != TextFieldBase.infinity &&
                    self.text.count >= maxLength {
                    self.text = String(text.prefix(maxLength))
                    dismissKeyboard()
                }
            }
            prevText = text
        }
    }
    
    private func validateFormat(showError: Bool) {
        if text.isEmpty {
            validationResult = showError ? .invalid("Debe completar este campo") : .warning
        } else if text.count < minLength {
            validationResult = showError ? .invalid("El codigo debe tener \(minLength) digitos") : .warning
        } else if text.isValidWithRegex(self.formatRegex) {
            validationResult = .valid
        } else {
            validationResult = showError ? .invalid("Error message") : .warning
        }
        if handler != nil {
            handler?(text, validationResult) { result in
                withAnimation {
                    validationResult = result
                }
            }
        }
    }
    
    private class Coordinator {
        var lastText: String = ""
    }
    
}
