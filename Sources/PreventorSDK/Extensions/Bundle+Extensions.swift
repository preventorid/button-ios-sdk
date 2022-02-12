//
//  Color+Extensions.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 16/12/21.
//

import Foundation

extension Bundle {
    
    static func psdkUIKitBundle() -> Bundle? {
        return Bundle.module
    }
    
    static func readLocalFile(forName name: String) -> Data? {
        do {
            guard let bundle = Bundle.psdkUIKitBundle() else {
                return nil
            }
            if let bundlePath = bundle.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
