//
//  PersonalInfoView+SubViews.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import SwiftUI

struct CardView<Content> : View where Content : View {
    
    let title: String
    let leftImage: Image
    let content: () -> Content
    
    var body: some View {
        HStack(alignment: .top){
            leftImage
                .foregroundColor(.colorSecondaryHigh)
            VStack(alignment: .leading){
                PSDKText(title, font: .psdkL3)
                content()
                    .frame(maxWidth: .infinity,  alignment: .leading)
            }
            .padding(.leading, 11)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .cornerRadius(8)
        .background(RoundedRectangle(cornerRadius: 8)
                        .fill(Color.psdkWhite)
                        .shadow(color: .psdkShadowBoxButtonColor, radius: 8, x: 0, y: 2)
        )
    }
    
    init(title: String, leftImage: Image, content: @escaping () -> Content){
        self.title = title
        self.leftImage = leftImage
        self.content = content
    }
    
}
