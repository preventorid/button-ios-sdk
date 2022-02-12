//
//  ApplicationUtil.swift
//  PreventorSdk
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import UIKit

enum WindowIdentifier: String {
    
    case main = "com.preventor-sdk.window.identifier.main",
         alert = "com.preventor-sdk.window.identifier.alert"
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class ApplicationUtil {
    
    @available(iOSApplicationExtension, unavailable)
    class func endEditing() {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.last
        keyWindow?.endEditing(true)
    }
    
    @available(iOSApplicationExtension, unavailable)
    class func safeAreaInsetsTop() -> CGFloat {
        let window = UIApplication.shared.windows.filter({ $0.accessibilityIdentifier == WindowIdentifier.main.rawValue }).last
        let safeAreaInsetsTop = window?.safeAreaInsets.top ?? 0
        return safeAreaInsetsTop
    }
    
    @available(iOSApplicationExtension, unavailable)
    class func safeAreaInsetsBottom() -> CGFloat {
        let window = UIApplication.shared.windows.filter({ $0.accessibilityIdentifier == WindowIdentifier.main.rawValue }).last
        let safeAreaInsetsBottom = window?.safeAreaInsets.bottom ?? 0
        return safeAreaInsetsBottom
    }
    
    class func getImageFrom(view: UIView, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func getImageFrom(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
}
