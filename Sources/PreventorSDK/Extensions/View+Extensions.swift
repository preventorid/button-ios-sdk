//
//  View+Extensions.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 18/12/21.
//

import SwiftUI
import Combine

extension View {
    
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarHidden(true)
                NavigationLink(
                    destination: view
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    @available(iOSApplicationExtension, unavailable)
    func withKeyboardEnabled(bottom: CGFloat = 16) -> some View {
        ModifiedContent(content: self, modifier: OffsetKeyboard(bottom: bottom))
    }
    
    func hola(when shouldShow: Bool) -> some View {
        Text("hola")
    }
    
    func placeholder<Content: View>(
            when: Bool,
            alignment: Alignment = .leading,
            @ViewBuilder _ placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(when ? 1 : 0)
                .animation(.default)
            self
        }
    }
    
    func toAnyView() -> AnyView {
        AnyView(self)
    }
    
    @ViewBuilder
    func demiModal(_ modal: PSDKDemiModal?) -> some View {
        if let modal = modal {
            self.modifier(modal)
        } else {
            self
        }
    }
    
    func demiModal(presented: Binding<Bool>,
                   router: PSDKModalRouter,
                   opacity: Double = 0.8) -> some View {
        self.modifier(PSDKDemiModal(presented: presented, router: router, opacity: opacity))
    }
    
    func demiModal<Modal: View>(presented: Binding<Bool>,
                                title: String,
                                opacity: Double = 0.8,
                                @ViewBuilder _ body: () -> Modal) -> some View {
        self.modifier(PSDKDemiModal(presented: presented, title: title, opacity: opacity, body))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}

@available(iOSApplicationExtension, unavailable)
struct OffsetKeyboard: ViewModifier {
    
    @State private var offset: CGFloat = 0
    @State private var isKeyboardShowing: Bool = false
    private let bottom: CGFloat
    init(bottom: CGFloat = 16) {
        self.bottom = bottom
    }
    @State private var keyboardHeight: CGFloat = 0.0
    
    func body(content: Content) -> some View {
        Group {
            if #available(iOS 14.0, *) {
                content.onTapGesture {
                    ApplicationUtil.endEditing()
                }
            } else {
                GeometryReader { geometry in
                content
                    .padding(.bottom, -(self.offset))
                    .offset(x: 0, y: -(self.offset))
                    .onReceive(Publishers.keyboardHeight) { (keyboardHeight) in
                        self.isKeyboardShowing = keyboardHeight > 0
                        if self.keyboardHeight != keyboardHeight {
                            self.keyboardHeight = keyboardHeight
                            withAnimation(Animation.easeOut(duration: 0.16)) {
                                let keyboardTop = (geometry.frame(in: .global).height + geometry.safeAreaInsets.top) - keyboardHeight
                                let focusedTextInputBottom = (UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0) + self.bottom
                                self.offset = (focusedTextInputBottom > keyboardTop ?
                                    (focusedTextInputBottom - keyboardTop) : 0)
                            }
                        }
                    }
                }
                .onTapGesture {
                    if self.isKeyboardShowing {
                        ApplicationUtil.endEditing()
                    }
                }
            }
        }
    }
    
}

extension UIResponder {
    @available(iOSApplicationExtension, unavailable)
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    private static weak var _currentFirstResponder: UIResponder?

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }

    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
    
}

extension Notification {
    
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
    
}

extension Publishers {
    
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
    
}
