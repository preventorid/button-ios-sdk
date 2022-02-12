//
//  ProgressBar.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 22/12/21.
//

import SwiftUI

struct ProgressBar: View {
    
    let barHeight: CGFloat
    let barColor: UIColor
    let progressColor: UIColor
    let progressPercentage: CGFloat
    let verticalPadding: CGFloat
    let isRounded: Bool
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack(alignment: .leading) {
                    Spacer()
                        .frame(width: proxy.size.width, height: self.barHeight)
                        .background(Color(self.barColor))
                        .cornerRadius(isRounded ? self.barHeight / 2.0 : 0)
                    Spacer()
                        .frame(width: proxy.size.width * self.progressPercentage, height: self.barHeight)
                        .background(Color(self.progressColor))
                        .cornerRadius(isRounded ? self.barHeight / 2.0 : 0)
                }
            }
            .frame(width: proxy.size.width)
            .padding(.vertical, self.verticalPadding)
        }
        .frame(height: self.barHeight + verticalPadding * 2.0)
    }
    
    init(minValue: Double = 0,
                maxValue: Double,
                currentValue: Double,
                barHeight: CGFloat = 10,
                barColor: UIColor = .colorProgressBar,
                progressColor: UIColor = .psdkColorPrimaryLigth200,
                verticalPadding: CGFloat = 10,
                isRounded: Bool = true) {
        self.barHeight = barHeight
        self.barColor = barColor
        self.progressColor = progressColor
        self.progressPercentage = min(CGFloat(currentValue / (maxValue - minValue)), 1)
        self.verticalPadding = verticalPadding
        self.isRounded = isRounded
    }
    
}
