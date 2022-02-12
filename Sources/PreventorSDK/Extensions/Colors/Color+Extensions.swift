//
//  Color+Extensions.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 16/12/21.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let opacity, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (opacity, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (opacity, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (opacity, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (opacity, red, green, blue) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(opacity) / 255
        )
    }
    
    static var psdkRed: Color {
        return Color(.psdkRed)
    }
    
    static var psdkWhite: Color {
        return Color(.psdkWhite)
    }
    
    static var psdkTextColorPrimaryLight: Color {
        return Color(.psdkTextColorPrimaryLight)
    }
    
    static var psdkShadowBoxButtonColor: Color {
        return Color(.psdkShadowBoxButtonColor)
    }
    
    static var psdkColorPrimaryLigth100: Color {
        return Color(.psdkColorPrimaryLigth100)
    }
    
    static var psdkColorPrimaryLigth200: Color {
        return Color(.psdkColorPrimaryLigth200)
    }
    
    static var psdkColorTextFieldMedium: Color {
        return Color(.psdkColorTextFieldMedium)
    }
    
    static var psdkColorTextLow: Color {
        return Color(.psdkColorTextLow)
    }
    
    static var psdkGrayLowEmphasis: Color {
        return Color(.psdkGrayLowEmphasis)
    }
    
    static var psdkColorSemanticDanger: Color {
        return Color(.psdkColorSemanticDanger)
    }
    
    static var colorSurfaceHigh: Color {
        return Color(.colorSurfaceHigh)
    }
    
    static var colorProgressBar: Color {
        return Color(.colorProgressBar)
    }
    
    static var colorSecondaryHigh: Color {
        return Color(.colorSecondaryHigh)
    }
    
    static var colorSecondaryLow: Color {
        return Color(.colorSecondaryLow)
    }
    
    static var colorEmphasisHigh: Color {
        return Color(.colorEmphasisHigh)
    }
    
    static var colorGreenNormal: Color {
        return Color(.colorGreenNormal)
    }
    
}

extension UIColor {
    static func colorFromLocalBundle(named name: String) -> UIColor {
        guard let color = UIColor(named: name, in: Bundle.module, compatibleWith: nil) else {
            fatalError("Color not found")
        }
        return color
    }
    static var psdkRed: UIColor {
        UIColor.colorFromLocalBundle(named: "color-red")
    }
    
    static var psdkWhite: UIColor {
        UIColor.colorFromLocalBundle(named: "color-white")
    }
    
    static var psdkTextColorPrimaryLight: UIColor {
        UIColor.colorFromLocalBundle(named: "text-color-primary-light")
    }
    
    static var psdkShadowBoxButtonColor: UIColor {
        UIColor.colorFromLocalBundle(named: "shadow-box-button-color")
    }
    
    static var psdkColorPrimaryLigth100: UIColor {
        UIColor.colorFromLocalBundle(named: "color-primary-ligth100")
    }
    
    static var psdkColorPrimaryLigth200: UIColor {
        UIColor.colorFromLocalBundle(named: "color-primary-ligth200")
    }
    
    static var psdkColorTextFieldMedium: UIColor {
        UIColor.colorFromLocalBundle(named: "color-text-field-medium")
    }
                                     
    static var psdkColorTextLow: UIColor {
        UIColor.colorFromLocalBundle(named: "color-text-low")
    }
    
    static var psdkGrayLowEmphasis: UIColor {
        UIColor.colorFromLocalBundle(named: "gray-low-emphasis")
    }
    
    static var psdkColorSemanticDanger: UIColor {
        UIColor.colorFromLocalBundle(named: "color-semantic-danger")
    }
    
    static var colorSurfaceHigh: UIColor {
        UIColor.colorFromLocalBundle(named: "color-surface-high")
    }
    
    static var colorProgressBar: UIColor {
        UIColor.colorFromLocalBundle(named: "color-progress-bar")
    }
    
    static var colorSecondaryHigh: UIColor {
        UIColor.colorFromLocalBundle(named: "color-secondary-high")
    }
    
    static var colorSecondaryLow: UIColor {
        UIColor.colorFromLocalBundle(named: "color-secondary-low")
    }
    
    static var colorEmphasisHigh: UIColor {
        UIColor.colorFromLocalBundle(named: "color-emphasis-high")
    }
    
    static var colorGreenNormal: UIColor {
        UIColor.colorFromLocalBundle(named: "color-green-normal")
    }
    
}
