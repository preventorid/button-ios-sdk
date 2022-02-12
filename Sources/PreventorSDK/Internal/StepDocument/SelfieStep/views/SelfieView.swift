//
//  SelfieView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 11/01/22.
//

import SwiftUI
import Combine

struct SelfieView: BaseView {
    
    @ObservedObject private(set) var store: ReduxStore<SelfieState>
    @State var showCircleProgress: Bool = false
    @State var count: Float = 0
    @State var timer: Timer? = nil
    @State var finish: Bool = false
    let delegate = LiveFeedView.Delegate()
    var introText: GenericView = LanguageManager.shared.language.pages.prepareSelfie
    var selfieText: CameraSelfie = LanguageManager.shared.language.pages.cameraSelfie
    var button: ButtonText = LanguageManager.shared.language.button
    
    var screen: SelfieState.Screen {
        store.state.screen
    }
    
    var showNextButton: Bool {
        screen == .intro
    }
    
    var title: String {
        showCircleProgress ? selfieText.correct.title : selfieText.far.title
    }
    
    var subTitle: String {
        showCircleProgress ? selfieText.correct.subTitle: selfieText.far.subTitle
    }
    
    var contentBody: some View {
        GeometryReader { proxy in
            if screen == .intro {
                GeneralBody(title: introText.title,
                            subTitle: introText.subTitle,
                            image: .biometricsSelfie,
                            style: .init())
                    .onAppear {
                        updateNavigationSettings()
                    }
            } else if screen == .selfie {
                let width = proxy.size.width
                let height = proxy.size.height
                let padding = 6.0
                let size = CGSize(width: width * 0.7667,
                                  height: width * 0.7667)
                let origin = CGPoint(x: width/2 - size.width/2,
                                     y: height/2 - size.height/2)
                let sizeFramework = CGSize(width: size.width - (padding * 2),
                                           height: size.height - (padding * 2))
                let originFramework = CGPoint(x: origin.x + padding,
                                              y: origin.y + padding)
                
                LiveFeedView(frame: CGRect(x: 0, y: 0, width: width, height: height),
                             framework: CGRect(origin: origin, size: size),
                             showCircleProgress: $showCircleProgress,
                             delegate: delegate)
                    .onAppear {
                        delegate.startRuning()
                        updateNavigationSettings()
                    }
                CircleWindows(size: size, origin: origin)
                    .fill(style: FillStyle(eoFill: true))
                    .foregroundColor(.white)
                    .opacity(0.65)
                ZStack {
                    if showCircleProgress {
                        CircularProgressBar(progress: $count)
                            .padding(.all, 4)
                    } else {
                        Image.circleGreenFramework
                            .resizable()
                    }
                }
                .frame(width: sizeFramework.width, height: sizeFramework.height, alignment: .center)
                .offset(x: originFramework.x, y: originFramework.y)
                VStack {
                    PSDKText(title, font: .psdkH5)
                        .padding(.top, 14)
                    PSDKText(subTitle)
                }
                .padding(.horizontal, width * 0.16)
                .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
        .onReceive(Just(showCircleProgress)) { show in
            if show {
                if timer == nil {
                    count = 0.0
                    timer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                                 repeats: true) {[weak delegate] timer in
                        count += 0.2
                        if count == 0.2, let image = delegate?.lastImage {
                            PSDKSession.shared.setSelfie01(image: image)
                        }
                        
                        if count > 1.5 || !showCircleProgress {
                            timer.invalidate()
                            self.timer = nil
                            self.showCircleProgress = false
                            if let image = delegate?.lastImage {
                                delegate?.stopRuning()
                                PSDKSession.shared.setSelfie02(image: image)
                                store.dispatch(StepDocumentAction.nextScreen())
                            }
                        }
                    }
                }
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
        .onDisappear {
            delegate.captureSession.stopRunning()
        }
    }
    
    func updateNavigationSettings() {
        if let coordinator = store.coordinator as? StepDocumentCoordinator,
           let settings = navigationSettings {
            coordinator.updateNavigationSettings(settings: settings, animated: true)
        }
    }
    
    func nextAction() {
        store.dispatch(SelfieAction.updateScreen(screen: .selfie))
    }
    
}
