//
//  GeneralBody.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 30/12/21.
//

import SwiftUI
import Lottie

struct GeneralBody: View {
    
    let title: String
    let subTitle: String
    let image: Image?
    let lottie: LottieView?
    let style: GeneralBodyStyle
    
    var bodyImage: AnyView? {
        if let image = self.image {
            return AnyView(image)
        } else if let lottie = self.lottie {
            return AnyView(lottie)
        }
        return nil
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack {
                if style.withSpacerTop {
                    Spacer()
                }
                PSDKText(title, font: .psdkH5)
                    .padding(.top, height * style.titleTopPersentage)
                bodyImage?
                    .frame(width: width * style.imageSize.width,
                           height: height * style.imageSize.height,
                           alignment: .center)
                    .padding(.top, height * style.imageTopPersentage)
                PSDKText(subTitle)
                    .padding(.top, height * style.titleTopPersentage)
                if style.withSpacerBottom {
                    Spacer()
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
              )
            .padding(width * style.leadignPadding)
        }
    }
    
    init(
        title: String,
        subTitle: String = "",
        image: Image? = nil,
        lottie: LottieView? = nil,
        style: GeneralBodyStyle = .init()
    ) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
        self.lottie = lottie
        self.style = style
    }
    
    init(
        model: GeneralBodyModel,
        style: GeneralBodyStyle = .init()
    ) {
        self.title = model.title
        self.subTitle = model.subTitle
        self.image = model.image
        self.lottie = model.lottie
        self.style = style
    }
    
}

struct GeneralBodyModel {
    
    let title: String
    let subTitle: String
    var image: Image? = nil
    var lottie: LottieView? = nil
    
}

struct GeneralBodyStyle {
    
    var titleTopPersentage: CGFloat = 0.0197
    var descriptionTopPersentage: CGFloat = 0.0211
    var imageTopPersentage: CGFloat  = 0.0329
    var imageSize: CGSize = CGSize(width: 0.4722, height: 0.2237)
    var leadignPadding: CGFloat = 0.067
    var withSpacerTop: Bool = false
    var withSpacerBottom: Bool = true
    
}

struct GeneralBodyStyleV2 {
    
    let titleTopPersentage: CGFloat = 0.0197
    let descriptionTopPersentage: CGFloat = 0.0211
    let imageTopPersentage: CGFloat  = 0.0329
    let imageSize: CGSize = CGSize(width: 0.4722, height: 0.2237)
    let leadignPadding: CGFloat = 0.067
    let showNextButton: Bool = true
    let showPrevButton: Bool = false
    let prevButtonTitle: String = ""
    var NextButtonTitle: String = LanguageManager.shared.language.button.next
    var withSpacerTop: Bool = true
    var withSpacerBottom: Bool = false
    var prevAction: () -> Void = {}
    var nextAction: () -> Void = {}
    
}


