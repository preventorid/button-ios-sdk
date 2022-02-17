//
//  BaseView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 18/12/21.
//

import SwiftUI
import UIKit

protocol BaseView: ReduxStoreView {
    
    associatedtype ContentBody: View
    
    @ViewBuilder var contentBody: Self.ContentBody { get }
    var customBackButton: UIBarButtonItem? { get }
    var trailingItems: [UIBarButtonItem] { get }
    var hideTrailingItems: Bool { get }
    var hideBackButton: Bool { get }
    var showProgressBar: Bool { get }
    var showNextButton: Bool { get }
    var showPrevButton: Bool { get }
    var nextButtonStyle: PSDKButtonStyle { get }
    var prevButtonStyle: PSDKButtonStyle { get }
    var viewKey: ViewKey? { get }
    var nextButtonText: String { get }
    var prevButtonText: String { get }
    var nextButtonDisabled: Bool { get }
    var demiModal: PSDKDemiModal? { get }
    func nextAction()
    func prevAction()
    
}

extension BaseView {
    
    var customBackButton: UIBarButtonItem? { nil }
    var hideBackButton: Bool { false }
    var showProgressBar: Bool { viewKey != nil }
    var showNextButton: Bool { true }
    var nextButtonStyle: PSDKButtonStyle {
        PSDKButtonStyle(type: .filled,
                               contentMode: .light,
                               isRounded: true)
    }
    var prevButtonStyle: PSDKButtonStyle {
        PSDKButtonStyle(type: .outlined,
                               contentMode: .light,
                               isRounded: true)
    }
    var prevButtonText: String {
        LanguageManager.shared.language.button.edit
    }
    var nextButtonText: String {
        LanguageManager.shared.language.button.next
    }
    var showPrevButton: Bool {
        false
    }
    var nextButtonDisabled: Bool {
        false
    }
    var viewKey: ViewKey? { nil }
    
    var trailingItems: [UIBarButtonItem] {
        var trailingItems: [UIBarButtonItem] = []
        let profileButton = PSDKBarButton(
            image: .navigationClose.resized(to: CGSize(width: 30, height: 30)),
            style: .plain,
            customAction: {
                store.parent?.dispatch(AppFlow.showCancelVerification(
                    reason: .CANCELLED_BY_USER))
            })
        trailingItems.append(profileButton)
        return trailingItems
    }
    
    var hideTrailingItems: Bool {
        false
    }
        
    private var progress: Double {
        guard let index = viewKey else { return 0 }
        return Double(index.rawValue) / Double(ViewKey.allCases.count)
    }
    
    var demiModal: PSDKDemiModal? { nil }
    
    var navigationSettings: PSDKNavigationSettings? {
        
        return PSDKNavigationSettings(
            titleView: UIImageView(image: UIImage.navigationLogo),
            navigationBarHidden: false,
            hideBackButton: hideBackButton || customBackButton != nil,
            leadingItems: customBackButton == nil ? [] : [customBackButton!],
            trailingItems: hideTrailingItems ? [] : trailingItems,
            navigationBarColor: .psdkWhite,
            isOpaque: true
        )
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading, spacing: 0) {
                self.contentBody
                if showProgressBar {
                    ProgressBar(
                        minValue: 0,
                        maxValue: 1,
                        currentValue: progress,
                        barHeight: 5,
                        verticalPadding: 0,
                        isRounded: false)
                    .padding(.top, 20)
                    .padding(.horizontal, reader.size.width * 0.067)
                }
                if showPrevButton || showNextButton {
                    HStack {
                        if showPrevButton {
                            PSDKButton(
                                style: prevButtonStyle,
                                action: {
                                    prevAction()
                                },
                                fullWidth: true,
                                label: {
                                    Text(prevButtonText)
                                })
                                .disabled(nextButtonDisabled)
                        }
                        if showNextButton {
                            PSDKButton(
                                style: nextButtonStyle,
                                disabled: nextButtonDisabled,
                                action: {
                                    nextAction()
                                },
                                fullWidth: true,
                                label: {
                                    Text(nextButtonText)
                                })
                        }
                    }
                    .padding(.bottom, 25)
                    .padding(.top, 16)
                    .padding(.horizontal, reader.size.width * 0.067)
                }
                HStack {
                    PSDKText(LanguageManager.shared.language.footer.poweredBy, font: .psdkL3)
                    Image.footerLogo
                        .frame(width: 62, height: 13, alignment: .center)
                }
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: 48,
                       alignment: .center)
                .background(Color.psdkGrayLowEmphasis)
            }
            .frame(height: reader.size.height)
            .demiModal(demiModal)
        }
    //
    }
    
    func prevAction() {}
    
}
