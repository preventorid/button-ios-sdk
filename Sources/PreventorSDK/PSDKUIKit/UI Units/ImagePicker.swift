//
//  ImagePicker.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 17/01/22.
//

import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    
    let picker = UIImagePickerController()
    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void
    let cameraView = UIView()
    let bounds: CGRect
    let type: ScanType
    var coordinator: Coordinator {
        picker.delegate as! Coordinator
    }
    var textManager: ButtonText = LanguageManager.shared.language.button

    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePicker: self,
                           sourceType: sourceType,
                           onImagePicked: onImagePicked)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        picker.sourceType = sourceType
        
        picker.delegate = context.coordinator
        picker.showsCameraControls = false
        picker.cameraOverlayView = addOverlay()
        picker.view.frame = bounds
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    func addSilhouette(_ cameraView: UIView) {
        let coordinator = self.coordinator
        let width = bounds.width
        let height = bounds.height
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let size = CGSize(width: width * 0.888, height: height * 0.37)
        let origin = CGPoint(x: rect.midX - size.width / 2, y: rect.midY - size.height / 2)
        var path = Rectangle().path(in: rect)
        let crop = CGRect(origin: origin, size: size)
        path.addRect(crop)
        coordinator.crop = .init(origin: .init(x: crop.minX/rect.width, y: crop.minY/520),
                                 size: .init(width: 0.888,
                                             height: size.height/520))
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor.white.cgColor
        fillLayer.opacity = 0.7
        let fillLayer1 = CAShapeLayer()
        fillLayer1.path = UIBezierPath(roundedRect: crop, cornerRadius: 4).cgPath
        fillLayer1.strokeColor = UIColor.psdkColorPrimaryLigth200.cgColor
        fillLayer1.fillColor = UIColor.clear.cgColor
        fillLayer1.fillRule = .evenOdd
        fillLayer1.lineWidth = 8
        
        cameraView.layer.addSublayer(fillLayer)
        cameraView.layer.addSublayer(fillLayer1)
    }
    
    func buildButton(title: String, isSelect: Bool, frame: CGRect) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .psdkL3
        if isSelect {
            button.setTitleColor(.psdkWhite, for: .normal)
            button.backgroundColor = .colorSecondaryHigh
        } else {
            button.setTitleColor(.psdkColorTextLow, for: .normal)
            button.backgroundColor = .white
        }
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 16
        button.frame = frame
        return button
    }
    
    func addTopButtons() {
        let size = CGSize(width: 83, height: 32)
        if DocumentModel.DocType.current?.quantity == .one {
            let leftButton = buildButton(title: textManager.front,
                                         isSelect: type == .front,
                                         frame: CGRect(
                                            origin: .init(x: (bounds.midX - size.width)/2,
                                                          y: bounds.height * 0.0315),
                                            size: size))
            cameraView.addSubview(leftButton)
        } else {
            let container = UIView()
            container.backgroundColor = .psdkWhite
            container.layer.cornerRadius = 16
            container.frame = CGRect(
                origin: .init(x: bounds.midX - size.width, y: bounds.height * 0.0315),
                size: .init(width: size.width * 2, height: size.height)
            )
            let leftButton = buildButton(title: textManager.front,
                                         isSelect: type == .front,
                                         frame: CGRect(origin: .zero, size: size))
            
            let rightButton = buildButton(title: textManager.back,
                                          isSelect: type == .back,
                                          frame: CGRect(origin: .init(x: size.width, y: 0), size: size))
            container.addSubview(leftButton)
            container.addSubview(rightButton)
            cameraView.addSubview(container)
        }
    }
    
    func addCaptureButton() {
        let coordinator = self.coordinator
        let size = CGSize(width: 66, height: 66)
        let button = UIButton()
        button.frame =  CGRect(origin: .init(x: bounds.midX - (size.width/2),
                                             y: bounds.height * 0.85),
                               size: size)
        button.setBackgroundImage(.captureOn, for: .normal)
        button.setBackgroundImage(.captureOff, for: .focused)
        button.setBackgroundImage(.captureOff, for: .selected)
        
        button.addTarget(coordinator, action: #selector(coordinator.takePicture), for: .touchUpInside)
        cameraView.addSubview(button)
    }

    func addOverlay() -> UIView? {
        cameraView.frame = bounds
        cameraView.tag = 101
        addSilhouette(cameraView)
        addTopButtons()
        addCaptureButton()
        return cameraView
    }
    
    func takePicture() {
        picker.takePicture()
    }
    
    func confirmPicture() {
        
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        private let sourceType: UIImagePickerController.SourceType
        private let onImagePicked: (UIImage) -> Void
        private let imagePicker: ImagePicker
        var crop: CGRect = .infinite
        
        init(
            imagePicker: ImagePicker,
             sourceType: UIImagePickerController.SourceType,
             onImagePicked: @escaping (UIImage) -> Void
        ) {
            self.imagePicker = imagePicker
            self.sourceType = sourceType
            self.onImagePicked = onImagePicked
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.fixOrientation(img: uiImage, completion: { fixedImage -> Void in
                self.cropImage(image: fixedImage, sizePercentage: self.crop, completion: { mimage -> Void in
                    DispatchQueue.main.async {
                        self.onImagePicked(mimage)
                     }
                })
            })
        }
        
        func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
            navigationController.isNavigationBarHidden = true
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
        }
        
        func fixOrientation(img: UIImage, completion: @escaping (UIImage)-> ()) {
            DispatchQueue.global(qos: .background).async {
                if (img.imageOrientation == .up) {
                    completion(img)
                }
                
                UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
                let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
                img.draw(in: rect)
                
                let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                
                completion(normalizedImage)
            }
        }
        
        func cropImage(image: UIImage, sizePercentage: CGRect, completion: @escaping (UIImage) -> ()) {
            DispatchQueue.global(qos: .background).async {
                let origin = CGPoint(x: image.size.width * sizePercentage.minX,
                                     y: image.size.height * sizePercentage.minY)
                
                let cgCroppedImage = image.cgImage!.cropping(
                    to: CGRect(origin: origin,
                               size: CGSize(width: image.size.width * sizePercentage.width,
                                            height: image.size.height * sizePercentage.height)))!
                
                let croppedImage = UIImage(cgImage: cgCroppedImage, scale: image.scale, orientation: image.imageOrientation)
                
                completion(croppedImage)
            }
        }
        
        @objc func takePicture() {
            imagePicker.takePicture()
        }
        
        @objc func confirmPicture() {
            imagePicker.confirmPicture()
        }
        
    }
    
    enum ScanType {
        case front
        case back
    }
    
}
