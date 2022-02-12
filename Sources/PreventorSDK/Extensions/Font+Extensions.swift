//
//  Font+Extensions.swift
//  PreventorSdk
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import SwiftUI
import UIKit

extension Font {
    
    static var psdkH1: Font {
        return Font.custom("Hind-Medium", size: 30)
    }
    
    static var psdkH5: Font {
        return Font.custom("Hind-Regular", size: 24)
    }
    
    static var psdkH6: Font {
        return Font.custom("Hind-Regular", size: 18)
    }
    
    static var psdkH7: Font {
        return Font.custom("Hind-Regular", size: 16)
    }
    
    static var psdkH8: Font {
        return Font.custom("Hind-Regular", size: 14)
    }
    
    static var psdkL3: Font {
        return Font.custom("Hind-Light", size: 12)
    }
}

extension UIFont {
    
    @available(iOSApplicationExtension, unavailable)
    private static func registerFont(withName name: String, fileExtension: String) {
        let fontUrl = Bundle.module.url(forResource: name, withExtension: fileExtension)
        if let dataProvider = CGDataProvider(url: fontUrl! as CFURL),
           let newFont = CGFont(dataProvider) {
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(newFont, &error)
                {
                    print("Error loading Font!")
            } else {
                print("Loaded font")
            }
        } else {
            assertionFailure("Error loading font")
        }
    }

    @available(iOSApplicationExtension, unavailable)
    static func loadFonts() {
        registerFont(withName: "Hind-Bold", fileExtension: "ttf")
        registerFont(withName: "Hind-Light", fileExtension: "ttf")
        registerFont(withName: "Hind-Medium", fileExtension: "ttf")
        registerFont(withName: "Hind-Regular", fileExtension: "ttf")
        registerFont(withName: "Hind-SemiBold", fileExtension: "ttf")
    }
    
    static var psdkH2: UIFont {
        guard let font = UIFont(name: "Hind-Bold", size: 68) else {
            fatalError("Font not found")
        }
        return font
    }
    
    static var psdkH5: UIFont {
        guard let font = UIFont(name: "Hind-Regular", size: 24) else {
            fatalError("Font not found")
        }
        return font
    }
    
    static var psdkH6: UIFont {
        guard let font = UIFont(name: "Hind-Regular", size: 18) else {
            fatalError("Font not found")
        }
        return font
    }
    
    static var psdkH7: UIFont {
        guard let font = UIFont(name: "Hind-Regular", size: 16) else {
            fatalError("Font not found")
        }
        return font
    }
    
    static var psdkH8: UIFont {
        guard let font = UIFont(name: "Hind-Regular", size: 14) else {
            fatalError("Font not found")
        }
        return font
    }
    
    static var psdkL3: UIFont {
        guard let font = UIFont(name: "Hind-Light", size: 12) else {
            fatalError("Font not found")
        }
        return font
    }
    
}
