//
//  PreventorButton.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import SwiftUI
import UIKit

@available(iOSApplicationExtension, unavailable)
public struct PreventorButton: View {
    
    @State private var isPresented = false
    @State private var isLoading = false
    @State private var timer: Timer? = nil
    private var module = ModuleAppCoordinator()
    private var animation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    private var dissabled: Bool {
        isLoading && PSDKSession.shared.getInitializeState() != .none
    }
    private var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    public var body: some View {
        let button = Button(action: {
            if PreventorSDK.shared.config?.isValid() ?? false {
                validateApiKey()
            } else {
                PreventorSDK.shared.delegate?.onError(error: .MISSING_PARAMETERS)
            }
        }){
            HStack(alignment: .center){
                Image.preventorButtonLeftIcon
                    .rotationEffect(Angle(degrees: self.isLoading ? 360 : 0.0))
                    .animation(self.isLoading ? foreverAnimation : .default)
                    .padding(.leading, 21)
                    .onDisappear { self.isLoading = false }
                Text("VERIFY ME")
                    .font(Font.psdkH8)
                    .foregroundColor(.psdkTextColorPrimaryLight)
                    .padding(.leading, 13)
                    .padding(.trailing, 26)
            }
            .padding(.vertical, 9)
        }
        .cornerRadius(8)
        .background(RoundedRectangle(cornerRadius: 8)
                        .fill(Color.psdkWhite)
                        .shadow(color: .psdkShadowBoxButtonColor, radius: 8, x: 0, y: 2)
        )
        .disabled(dissabled)
        return VStack {
            if #available(iOS 14.0, *) {
                button
                .fullScreenCover(isPresented: $isPresented) {
                    StartController(module, onDismissalAttempt: onDismissalAttempt)
                }
            } else {
                button
                .sheet(isPresented: $isPresented) {
                    StartController(module, onDismissalAttempt: onDismissalAttempt)
                }
            }
        }
        .animation(.easeInOut(duration: 0.3))
        .onAppear {
            self.module.navigationController.finish = { error in
                if let error = error {
                    PreventorSDK.shared.delegate?.onError(error: error)
                } else {
                    PreventorSDK.shared.delegate?.onFinish()
                }
                withAnimation {
                    self.isPresented = false
                }
            }
        }
    }
    
    public init() {
        
    }
    
    func validateApiKey() {
        isLoading = true
        if PSDKSession.shared.getInitializeState() == .success {
            PreventorSDK.shared.validateApiKey(
                complete: { success in
                    isLoading = false
                    if success {
                        withAnimation {
                            isPresented = true
                        }
                        PreventorSDK.shared.delegate?.onStart()
                    } else {
                        withAnimation {
                            isPresented = false
                        }
                        PreventorSDK.shared.delegate?.onError(error: .BIOMETRIC_AUTHENTICATION_FAILED)
                    }
                })
        } else if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                switch PSDKSession.shared.initializeState {
                case .success:
                    validateApiKey()
                    timer.invalidate()
                case .failed:
                    timer.invalidate()
                default:
                    break
                }
            }
        }
    }
    
    func onDismissalAttempt() {
        
    }
    
}
