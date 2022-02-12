//
//  HyperlinkText.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 17/01/22.
//

import SwiftUI

struct HyperlinkText: View {
    
    @Binding var strings: [StringWithAttributes]
    let html: String
    
    init(html: String,
         strings: Binding<[StringWithAttributes]>) {
        self.html = html
        self._strings = strings
        syncUp()
    }
    
    func syncUp(){
        if let data = html.data(using: .utf8) {
            DispatchQueue.main.async {
                if let attributes = try? NSAttributedString(data: data,
                                                           options: [.documentType: NSAttributedString.DocumentType.html,
                                                                     .characterEncoding:String.Encoding.utf8.rawValue],
                                                           documentAttributes: nil) {
                    setStrings(attributes)
                } else {
                    setStrings(nil)
                }
            }
        }else {
            strings = []
        }
    }
    
    func setStrings(_ attributedString: NSAttributedString?) {
        withAnimation {
            strings = attributedString?.stringsWithAttributes ?? []
        }
    }
    
    var body: some View {
        FlowLayout(mode: .vstack,
                   binding: .constant(false),
                   items: strings,
                   itemSpacing: 0) { string in
            if let link = string.attrs[.link],
               let url = link as? URL {
                PSDKText(string.string,
                         textColor: .psdkColorPrimaryLigth200,
                         font: .psdkH8)
                    .onTapGesture {
                        UIApplication.shared.open(url)
                    }
            } else {
                PSDKText(string.string, font: .psdkH8)
            }
        }
    }
}
