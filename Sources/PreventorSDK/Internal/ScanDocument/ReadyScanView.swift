//
//  ReadyScanView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import SwiftUI
import UIKit
import DocumentReader

struct ReadyScanView: BaseView, RegulaScanViewDelegate {
    
    @ObservedObject private(set) var store: ReduxStore<ReadyScanState>
    let controller: UIViewController = UIViewController()
    var viewKey: ViewKey? {
        screen == .ready ?  .readyDocument : nil
    }
    var nextButtonText: String {
        LanguageManager.shared.language.button.iamReady
    }
    var showNextButton: Bool {
        screen == .ready
    }
    var screen: ReadyScanState.Screen {
        store.state.screen
    }
    var textManager: ButtonText = LanguageManager.shared.language.button
    
    var contentBody: some View {
        
        let model = ReadyScanModel(from: self.store.state.type)
        
        return GeometryReader { reader in
            let width = reader.size.width
            let height = reader.size.height
            if screen == .ready {
                VStack(alignment: .center){
                    PSDKText(model.title, font: .psdkH5)
                        .padding(.top, height * 0.02)
                        .padding(.horizontal, width * 0.03)
                    model.image
                        .padding(.top, height * 0.032)
                    PSDKText(model.subTitle)
                        .padding(.top, height * 0.021)
                    PSDKText(LanguageManager.shared.language.pages.globalDocument.subTitle2,
                             textColor: .psdkColorTextLow,
                             font: .psdkH8 )
                        .padding(.top, height * 0.017)
                        .padding(.horizontal, width * 0.06)
                }
                .padding(.horizontal, width * 0.067)
                .frame(minWidth: 0, maxWidth: .infinity)
                if store.state.showRegulaScan {
                    RegulaScanView(delegate: self)
                }
            } else if screen == .takeFrontPhoto {
                ImagePicker(sourceType: .camera,
                            onImagePicked: onImagePicked,
                            bounds: CGRect(x: 0, y: 0, width: width, height: height), type: .front)
            } else if screen == .takeBackPhoto {
                ImagePicker(sourceType: .camera,
                            onImagePicked: onImagePicked,
                            bounds: CGRect(x: 0, y: 0, width: width, height: height), type: .back)
            } else {
                if let image = store.state.image {
                    VStack {
                        Spacer()
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: width * 0.888, height: height * 0.37, alignment: .center)
                            .cornerRadius(4)
                        Spacer()
                        HStack {
                            Button(action: {
                                store.dispatch(
                                    ReadyScanAction.updateScreen(
                                        screen: screen == .showFrontPhoto ? .takeFrontPhoto : .takeBackPhoto))
                            }) {
                                HStack {
                                    Image.retakePicture
                                        .resizable()
                                        .padding(10)
                                        .frame(width: 36, height: 36, alignment: .center)
                                        .foregroundColor(.psdkWhite)
                                        .background(Color.psdkColorSemanticDanger)
                                        .cornerRadius(4)
                                    Text(textManager.retake)
                                        .font(.psdkH8)
                                }
                            }
                            Spacer()
                            Button(action: {
                                if screen == .showFrontPhoto {
                                    store.dispatch(ReadyScanAction.saveFrontImage(image: image))
                                } else {
                                    store.dispatch(ReadyScanAction.saveBackImage(image: image))
                                }
                            }) {
                                HStack {
                                    Text(textManager.confirm)
                                        .font(.psdkH8)
                                    Image.done
                                        .resizable()
                                        .padding(10)
                                        .frame(width: 36, height: 36, alignment: .center)
                                        .foregroundColor(.psdkWhite)
                                        .background(Color.psdkColorPrimaryLigth200)
                                        .cornerRadius(4)
                                }
                            }
                        }
                        .padding(.bottom, height * 0.0315)
                        .padding(.horizontal, height * 0.0615)
                    }
                }
            }
        }
    }
    
    func onImagePicked(_ image: UIImage) {
        if screen == .takeFrontPhoto {
            store.dispatch(ReadyScanAction.showFrontPhoto(image: image))
        } else if screen == .takeBackPhoto {
            store.dispatch(ReadyScanAction.showBackPhoto(image: image))
        }
    }
    
    func nextAction() {
        switch store.state.scanMode {
        case .withOutRegula:
            store.dispatch(ReadyScanAction.updateScreen(screen: .takeFrontPhoto))
        case .withRegula:
            store.dispatch(ReadyScanAction.showRegulaScan)
        }
    }
    
    func complete(data: DocumentReaderResults?) {
        store.dispatch(ReadyScanAction.hiddeRegulaScan(data: data))
    }
    
    func handleError() {
        
    }
    
    func showScaner() -> Bool {
        store.state.showRegulaScan
    }
    
    func getController() -> UIViewController {
        print(controller)
        return controller
    }
    
}
