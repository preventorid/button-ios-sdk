//
//  PSDKEmailTextField.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 29/12/21.
//

import SwiftUI

struct PSDKEmailTextField: View {
    
    @Binding var text: String
    let hint: String
    let handler: TextValidationHandler?
    let onSubmit: (ValidationResult) -> Void
    
    var body: some View {
        TextFieldBase(
            text: $text,
            hint: hint,
            regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}",
            maxLength: 320,
            autocapitalization: .none,
            keyboardType: .emailAddress,
            handler: handler,
            onSubmit: onSubmit)
            .withEndView {
                withAnimation {
                    ZStack {
                        if !text.isEmpty {
                            Image.navigationClose
                            .resizable()
                            .frame(width: 18, height: 18, alignment: .center)
                            .onTapGesture {
                                text = ""
                            }
                        }
                    }
                }
            }
    }
    
    init(_ text: Binding<String>,
         hint: String,
         handler: TextValidationHandler? = nil,
         onSubmit: @escaping (ValidationResult) -> Void) {
        self._text = text
        self.hint = hint
        self.handler = handler
        self.onSubmit = onSubmit
    }
    
}
