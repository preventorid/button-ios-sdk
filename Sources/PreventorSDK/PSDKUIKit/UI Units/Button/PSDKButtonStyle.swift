//
//  PSDKButtonStyle.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 21/12/21.
//


import SwiftUI

struct PSDKButtonStyle {
    
    enum ContentMode {
        
        case light, dark
        
    }
    
    enum Size {
        
        case small, regular, large
        
        var height: CGFloat {
            switch self {
            case .small:
                return 32.0
            case .regular:
                return 40.0
            case .large:
                return 52.0
            }
        }
        
    }
    
    enum ButtonType {
        case plain, filled, outlined
    }
    
    let type: ButtonType
    let contentMode: ContentMode
    let size: Size
    let backgroundColor: Color?
    let isRounded: Bool
    
    var foregroundColor: Color {
        switch self.contentMode {
        case .dark:
            return .psdkTextColorPrimaryLight
        case .light:
            switch self.type {
            case .filled:
                return .psdkWhite
            default:
                return .psdkColorPrimaryLigth200
            }
        }
    }
    
    var disabledForegroundColor: Color {
        switch self.contentMode {
        case .dark:
            return .psdkWhite
        case .light:
            return .psdkWhite
        }
    }
    
    var activeBackgroundColor: Color {
        switch self.type {
        case .filled:
            guard let backgroundColor = self.backgroundColor else {
                return .psdkColorPrimaryLigth100
            }
            return backgroundColor
        default:
            return .clear
        }
    }
    
    var pressedBackgroundColor: Color {
        switch self.type {
        case .filled:
            return .psdkColorPrimaryLigth100
        default:
            return .clear
        }
    }
    
    var disabledBackgroundColor: Color {
        switch self.type {
        case .filled:
            switch self.contentMode {
            case .dark:
                return .colorSurfaceHigh
            case .light:
                return .colorSurfaceHigh
            }
        default:
            return .clear
        }
    }
    
    var activeBorderColor: Color {
        switch self.type {
        case .outlined:
            return .psdkColorPrimaryLigth200
        default:
            return .clear
        }
    }

    var pressedBorderColor: Color {
        switch self.type {
        case .outlined:
            return .psdkColorPrimaryLigth200
        default:
            return .clear
        }
    }
    
    var disabledBorderColor: Color {
        switch self.type {
        case .outlined:
            return .colorSurfaceHigh
        default:
            return .clear
        }
    }
    
    var font: Font {
        switch self.size {
        case .small:
            return Font.psdkL3
        case .regular:
            return .psdkH8
        case .large:
            return .psdkH7
        }
    }
    
    var cornerRadius: CGFloat { isRounded ? 8: 0 }
    
    init(type: ButtonType = .filled,
                contentMode: ContentMode = .light,
                size: Size = .regular,
                backgroundColor: Color? = nil,
                isRounded: Bool = true) {
        self.type = type
        self.contentMode = contentMode
        self.size = size
        self.backgroundColor = backgroundColor
        self.isRounded = isRounded
    }

}
