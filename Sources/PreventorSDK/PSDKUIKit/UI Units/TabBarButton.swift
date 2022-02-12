//
//  TabBarButton.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 17/01/22.
//

import SwiftUI

struct TabBarButton: View {
    
    var icon: Image
    @Binding var isSelected: Bool
    var barColor: Color { isSelected ? .colorSecondaryHigh : .psdkWhite }
    var backgroundColor: Color { isSelected ? .colorSecondaryLow : .psdkWhite}
    var tintColorImage: Color { isSelected ? .colorSecondaryHigh: .colorSurfaceHigh}
    
    var body: some View {
        VStack {
            icon
                .padding(.top, 10)
                .padding(.bottom, 7)
                .foregroundColor(tintColorImage)
            Rectangle()
                .frame(height: 3.0, alignment: .bottom)
                .foregroundColor(barColor)
        }
        .background(backgroundColor)
    }
}
