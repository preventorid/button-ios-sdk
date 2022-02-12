//
//  CircularProgressBar.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 17/01/22.
//

import SwiftUI

struct CircularProgressBar: View {
    
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6.0)
                .foregroundColor(Color.colorGreenNormal)
            
            Circle()
                .trim(from: CGFloat(max(self.progress - 0.3, 0.0)), to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.psdkGrayLowEmphasis)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear(duration: 0.5))
                .padding(.all, 8)
        }
    }
    
}
