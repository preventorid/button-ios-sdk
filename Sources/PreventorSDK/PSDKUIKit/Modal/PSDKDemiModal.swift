//
//  PSDKDemiModal.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 03/01/22.
//

import Foundation
import SwiftUI

struct PSDKDemiModal: ViewModifier {
    
    @ObservedObject private var router: PSDKModalRouter
    @Binding private var presented: Bool
    @State private var didPresent: Bool = false
    private let opacity: Double
    var paddingTop = 60.0
    
    init(presented: Binding<Bool>, router: PSDKModalRouter, opacity: Double = 0.8) {
        self._presented = presented
        self.router = router
        self.opacity = (opacity >= 1.0 ? 1.0 : (opacity <= 0.0 ? 0.0 : opacity))
    }
    
    init<Modal: View>(presented: Binding<Bool>, title: String, opacity: Double = 0.8, @ViewBuilder _ body: () -> Modal) {
        self._presented = presented
        self.router = PSDKModalRouter(root: PSDKModalRoute(title: title, view: body().toAnyView))
        self.opacity = (opacity >= 1.0 ? 1.0 : (opacity <= 0.0 ? 0.0 : opacity))
    }
    
    var backButtonIcon: String {
        if self.router.canGoBack {
            return "chevron.left"
        } else {
            return "xmark"
        }
    }
    
    private var header: some View {
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 54, height: 4, alignment: .center)
                    .foregroundColor(.psdkColorTextLow)
                    .padding(.vertical, 8)
                Spacer()
            }.frame(height: 20)
    }
    
    func body(content: Content) -> some View {
        return Group {
            if self.presented {
                content.overlay(
                        GeometryReader { proxy in
                            ZStack(alignment: .bottom) {
                                Color.black
                                    .opacity(opacity)
                                    .edgesIgnoringSafeArea(.all)
                                    .onTapGesture {
                                        self.dismiss()
                                    }
                                if didPresent {
                                    DraggableView(dragDirection: .downwards, minimumDrag: 68, didDrag: {
                                        self.dismiss()
                                    }) {
                                        VStack {
                                            self.header
                                            self.router.currentRoute?.view
                                            .transition(.scale)
                                        }
                                        .padding(.bottom, UIDevice.hasNotch ? 40 : 0)
                                        .frame(width: proxy.size.width, alignment: .bottom)
                                        .background(Color.psdkWhite)
                                        .cornerRadius(20, corners: [.topLeft, .topRight])
                                        .allowsHitTesting(true)
                                        .transition(.move(edge: .bottom))
                                    }
                                    .padding(.top, paddingTop)
                                }
                            }
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottom)
                            .onAppear {
                                withAnimation(.easeInOut) {
                                    self.didPresent = true
                                }
                            }
                            .onDisappear {
                                self.didPresent = false
                            }
                        }
                        
                    )
            } else {
                content
            }
        }
    }
    
    func dismiss() {
        defer {
            self.router.dismiss()
        }
        withAnimation(.easeInOut(duration: 0.2)) {
            self.didPresent.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.presented.toggle()
        }
    }
    
    func backButtonAction() {
        if self.router.canGoBack {
            self.router.popRoute()
        } else {
            dismiss()
        }
    }
    
}
