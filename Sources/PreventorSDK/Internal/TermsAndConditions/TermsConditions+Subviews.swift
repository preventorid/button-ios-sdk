//
//  TermsConditions+Subviews.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 18/12/21.
//

import SwiftUI

struct TermView: View {
    
    let text: String
    
    var body: some View {
        HStack{
            Image.bulletPointList
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
                .padding(.trailing, 16)
            PSDKText(text,
                     font: .psdkH7,
                     alignment: .leading)
            Spacer()
        }
    }
    
}
