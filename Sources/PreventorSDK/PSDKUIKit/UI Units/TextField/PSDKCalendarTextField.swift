//
//  PSDKTextFieldCalendar.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 31/12/21.
//

import Foundation
import SwiftUI

struct PSDKTextFieldCalendar: View {
    @Binding var text: String
    @State var showPicker: Bool = false
    @State var date: Date = Date()
    @State var isFocused = false
    @State var isDisabled = false
    var locale: Locale = .current
    var hint: String = ""
    var lightContent = true
    var isAutomaticSelection: Bool = false
    var placeholderColor: UIColor {
        lightContent ? .psdkTextColorPrimaryLight : .psdkTextColorPrimaryLight
    }
    var displayFormat = "MMM, dd, YYYY"
    var valueFormat = "YYYY-MM-dd"
    
    var body: some View {
        VStack {
            TextFieldBase(
                text: $text,
                hint: hint
            )
                .withEndView {
                    Image.calendarTodayActive
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                }
                .withCustomTextField {
                    PSDKDateTextFieldWrapped (
                        text: $text,
                        isFocused: $isFocused,
                        placeholder: hint,
                        style: .init(
                            font: .psdkH8,
                            foregroundColor: .psdkTextColorPrimaryLight,
                            placeHolderColor: placeholderColor
                        ),
                        locale: locale,
                        isAutomaticSelection: isAutomaticSelection,
                        didChangeDate: { newDate in
                            update(with: newDate)
                        }
                        )
                }
        }
    }

    private func update(with date: Date) {
       text = date.getStringDate(dateFormat: displayFormat, locale: locale).capitalized
    }
    
    init(text: Binding<String>,
         hint: String
    ) {
        self._text = text
        self.hint = hint
    }
    
}
