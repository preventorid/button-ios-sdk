//
//  PSDKButton.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 21/12/21.
//

import SwiftUI

struct PSDKButton<Label>: View where Label: View {
    
    var label: Label
    var action: (() -> Void)
  //  let icon: Image?
    let style: PSDKButtonStyle
    let padding: CGFloat
    @Binding private var hidden: Bool
    private var disabled: Bool
    let fullWidth: Bool
    let accessibilityIdentifier: String
    
    var body: some View {
        return GeometryReader { geometry in
            HStack {
                if !self.fullWidth {
                    Spacer()
                }
                if !self.hidden {
                    Button(action: {
                        self.action()
                    }, label: {
                        label
                            .multilineTextAlignment(.center)
                            .frame(width: self.fullWidth ? geometry.size.width : geometry.size.width * 0.808,
                                   height: self.style.size.height)
                            .foregroundColor(self.disabled ? self.style.disabledForegroundColor : self.style.foregroundColor)
                            .font(self.style.font)
                            .padding(.horizontal, self.padding)
                            .background(self.disabled ? self.style.disabledBackgroundColor : self.style.activeBackgroundColor)
                            .cornerRadius(self.style.cornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: self.style.cornerRadius)
                                    .stroke(self.disabled ? self.style.disabledBorderColor : self.style.activeBorderColor, lineWidth: 1)
                            )
                            .frame(minHeight: 44.0)
                            
                    })
                    .accessibility(identifier: accessibilityIdentifier)
                    .disabled(self.disabled)
                }
                if !self.fullWidth {
                    Spacer()
                }
            }
        }
            .frame(height: style.size.height)
    }
    
    /// - Parameters:
    ///     - style: The style of `self`, describing its attributes.
    ///     - hidden: The binding value that states if `self` is hidden or not.
    ///     - disabled: The binding value that states if `self` is disabled or not.
    ///     - icon: The icon image of `self`, describing its purpose.
    ///     - action: The action to perform when `self` is triggered.
    ///     - label: A view that describes the effect of calling `action`
    ///     - accessibilityIdentifier: identifier used for UI automation tests
    init(style: PSDKButtonStyle = PSDKButtonStyle(),
                hidden: Binding<Bool> = Binding.constant(false),
                disabled: Bool = false,
                icon: Image? = nil,
                action: @escaping () -> Void,
                fullWidth: Bool = false,
                accessibilityIdentifier: String? = nil,
                @ViewBuilder label: () -> Label,
                padding: CGFloat? = 0 ) {
        self.label = label()
        self._hidden = hidden
        self.disabled = disabled
        self.action = action
        self.style = style
//        self.icon = icon
        self.fullWidth = fullWidth
        self.accessibilityIdentifier = accessibilityIdentifier ?? ""
        self.padding = padding ?? 0
    }
    
}

@available(iOSApplicationExtension, unavailable)
extension PSDKButton where Label == Text {

    /// Creates an instance with a `Text` label generated from a title string.
    ///
    /// - Parameters:
    ///     - title: The title of `self`, describing its purpose.
    ///     - style: The style of `self`, describing its attributes.
    ///     - hidden: The binding value that states if `self` is hidden or not.
    ///     - disabled: The binding value that states if `self` is disabled or not.
    ///     - icon: The icon image of `self`, describing its purpose.
    ///     - action: The action to perform when `self` is triggered.
    init<S>(_ title: S,
                   style: PSDKButtonStyle = PSDKButtonStyle(),
                   hidden: Binding<Bool> = Binding.constant(false),
                   disabled: Bool = false,
                   icon: Image? = nil,
                   fullWidth: Bool = false,
                   accessibilityIdentifier: String? = nil,
                   action: @escaping () -> Void,
                   padding: CGFloat? = 32.0 ) where S: StringProtocol {
        self.label = Text(title)
        self._hidden = hidden
        self.disabled = disabled
        self.action = action
        self.style = style
 //       self.icon = icon
        self.fullWidth = fullWidth
        self.accessibilityIdentifier = accessibilityIdentifier ?? ""
        self.padding = padding ?? 32.0
    }
    
}
