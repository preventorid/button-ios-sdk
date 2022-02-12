//
//  TextFieldWrapped.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 1/01/22.
//

import SwiftUI


struct PSDKDateTextFieldWrapped: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var isFocused: Bool
    
    private let textField = UITextField()
    fileprivate let datePickerView = UIDatePicker()
    
    let style: PSDKTextFieldStyle
    let placeholder: String
    let locale: Locale
    let isAutomaticSelection: Bool
    let didChangeDate: (Date) -> Void
    var coordinator: Coordinator?
    
    init(
        text: Binding<String>,
        isFocused: Binding<Bool>,
        placeholder: String,
        style: PSDKTextFieldStyle,
        locale: Locale,
        isAutomaticSelection: Bool,
        didChangeDate: @escaping (Date) -> Void
    ) {
        self._text = text
        self._isFocused = isFocused
        self.placeholder = placeholder
        self.style = style
        self.locale = locale
        self.isAutomaticSelection = isAutomaticSelection
        self.didChangeDate = didChangeDate
        coordinator = textField.delegate as? Coordinator
    }
    
    func makeUIView(context: Context) -> UITextField {
        let screenWidth = UIScreen.main.bounds.width
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                         buttonItem(withSystemItemStyle: .flexibleSpace),
                         buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        toolBar.backgroundColor = .black
        textField.inputAccessoryView = toolBar
        textField.text = text
        textField.font = style.font
        textField.textColor = style.foregroundColor
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.font: style.font,
                NSAttributedString.Key.foregroundColor: style.placeHolderColor
            ]
        )
        datePickerView.locale = locale
        datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
        datePickerView.addTarget(
            context.coordinator,
            action: #selector(Coordinator.datePickerDidChangeValue(_:)),
            for: .valueChanged
        )
        textField.inputView = datePickerView
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        textField.text = text   
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(parent: self)
        textField.delegate = coordinator
        return coordinator
    }
    
    func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
        let buttonTarget = style == .flexibleSpace ? nil : textField.delegate
        let action: Selector? = {
            switch style {
            case .cancel:
                return #selector(coordinator?.cancelAction)
            case .done:
                return #selector(coordinator?.doneAction)
            default:
                return nil
            }
        }()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                            target: buttonTarget,
                                            action: action)
        barButtonItem.tintColor = .psdkGrayLowEmphasis
        return barButtonItem
    }
    
}

extension PSDKDateTextFieldWrapped {
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        private var parent: PSDKDateTextFieldWrapped
        
        init(parent: PSDKDateTextFieldWrapped) {
            self.parent = parent
        }
        
        @objc func datePickerDidChangeValue(_ datePicker: UIDatePicker) {
         //   parent.didChangeDate(datePicker.date)
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isFocused = true
            if parent.text.isEmpty && parent.isAutomaticSelection {
                parent.didChangeDate(parent.datePickerView.date)
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isFocused = false
        }
        
        @objc func cancelAction() {
            parent.isFocused = false
            self.parent.textField.resignFirstResponder()
            ApplicationUtil.endEditing()
        }
        
        @objc func doneAction() {
            parent.didChangeDate(parent.datePickerView.date)
            parent.isFocused = false
            self.parent.textField.resignFirstResponder()
            ApplicationUtil.endEditing()
        }
        
    }
    
}
