//
//  PSDKTextField.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 28/12/21.
//

import Foundation
import SwiftUI

struct PSDKTextField: View {
    
    @Binding var text: String
    let hint: String
    let keyboardType: UIKeyboardType
    let handler: TextValidationHandler?
    let maxLength: Int
    let minLength: Int
    let formatText: String
    
    var body: some View {
        TextFieldBase(
            text: $text,
            hint: hint,
            regex: formatText,
            minLength: minLength,
            maxLength: maxLength,
            keyboardType: keyboardType,
            handler: handler)
            .withEndView{
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
         formatText: String = "(?s).*",
         minLength: Int = 0,
         maxLength: Int = TextFieldBase.infinity,
         keyboardType: UIKeyboardType = .default,
         handler: TextValidationHandler? = nil
    ) {
        self._text = text
        self.hint = hint
        self.formatText = formatText
        self.maxLength = maxLength
        self.minLength = minLength
        self.keyboardType = keyboardType
        self.handler = handler
    }
    
}
