//
//  LottieView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 20/12/21.
//


import SwiftUI
import Lottie
import Combine

struct LottieView: UIViewRepresentable {
    
    let animationName: String
    
    init(animationName: String) {
        self.animationName = animationName
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view: UIView = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let animationView = AnimationView()
        uiView.subviews.forEach { view in
            UIView.animate(withDuration: 0.5, animations: {
                view.isHidden = true
                view.removeFromSuperview()
            }) { (success) in
                
            }
        }
        uiView.addSubview(animationView)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
         animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
         animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])
        var animation: Lottie.Animation?
        if let bundle = Bundle.psdkUIKitBundle() {
            animation = Lottie.Animation.named(animationName, bundle: bundle)
        }
        animationView.animation = animation
        animationView.play()
    }
    
}
