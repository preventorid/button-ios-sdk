//
//  LiveFeed.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 17/01/22.
//

import SwiftUI
import Vision
import AVFoundation

struct LiveFeedView: UIViewRepresentable {
    
    @Binding var showCircleProgress: Bool
    let frame: CGRect
    let framework: CGRect
    let view: UIView
    unowned let delegate: Delegate
    
    init(frame: CGRect, framework: CGRect, showCircleProgress: Binding<Bool>, delegate: Delegate) {
        self._showCircleProgress = showCircleProgress
        self.frame = frame
        self.framework = framework
        self.delegate = delegate
        self.view = delegate.view
        delegate.setParent(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        view.frame = frame
        delegate.setupCamera()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    
    class Delegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        
        
        private var parent: LiveFeedView! = nil
        private var analice: UInt8 = 0
        private var timer: Timer? = nil
        private var count = 0
        private var isStopped: Bool = false
        var lastImage: UIImage? = nil
        var previewLayer: AVCaptureVideoPreviewLayer
        var maxFrameCircle: CGRect
        let captureSession = AVCaptureSession()
        let videoDataOutput = AVCaptureVideoDataOutput()
        let circle: UIImageView
        let view = UIView()

        override init() {
            previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            circle = UIImageView()
            circle.isHidden = true
            maxFrameCircle = .zero
        }
        
        func setParent(parent: LiveFeedView) {
            self.parent = parent
            let padding = 10.0
            maxFrameCircle = CGRect(x: parent.framework.minX + padding/2,
                                    y: parent.framework.minY + padding/2,
                                    width: parent.framework.width - padding,
                                    height: parent.framework.height - padding )
        }
        
        func setupCamera() {
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front)
            if let device = deviceDiscoverySession.devices.first {
                if let deviceInput = try? AVCaptureDeviceInput(device: device) {
                    if captureSession.canAddInput(deviceInput) {
                        captureSession.addInput(deviceInput)
                    }
                    setupPreview()
                }
            }
        }
        
        private func setupPreview() {
            previewLayer.videoGravity = .resizeAspectFill
            if previewLayer.superlayer != parent.view.layer {
                parent.view.layer.addSublayer(self.previewLayer)
            }
            circle.removeFromSuperview()
            parent.view.addSubview(circle)
            previewLayer.frame = self.parent.view.frame
            
            videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]

            if videoDataOutput.sampleBufferDelegate == nil {
                videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera queue"))
            }
            if captureSession.canAddOutput(videoDataOutput) {
                captureSession.addOutput(videoDataOutput)
            }
            let videoConnection = self.videoDataOutput.connection(with: .video)
            videoConnection?.videoOrientation = .portrait
        }
        
        func startRuning(){
            isStopped = false
            captureSession.startRunning()
        }
        
        func stopRuning(){
            isStopped = true
            captureSession.stopRunning()
        }
        
        func analyzeProximity(frame: CGRect){
            let y =  frame.midY - parent.framework.midY
            let x =  frame.midX - parent.framework.midX
            let centerDistance = sqrt((y*y) + (x*x))
            let widthDiference = parent.framework.width - frame.width
            if widthDiference > 0 {
                if widthDiference < 40 &&
                    centerDistance < 30 {
                    circle.image = .circleGreenThree
                    if timer == nil && !parent.showCircleProgress {
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: evaluateTime)
                    }
                    return
                }
                if widthDiference < 80 &&
                    centerDistance < 60 {
                    circle.image = .circleGreenOneTwo
                    resetTimer()
                    return
                }
            }
            resetTimer()
            circle.image = .circleRedOne
        }
        
        private func stopTimer() {
            if timer != nil {
                timer!.invalidate()
                count = 0
                timer = nil
            }
        }
        
        private func resetTimer() {
            parent.showCircleProgress = false
            stopTimer()
        }
        
        private func evaluateTime(t: Timer) {
            count += 1
            if count > 1 {
                circle.frame = maxFrameCircle
            }
            if count > 3 {
                parent.showCircleProgress = true
                stopTimer()
            }
        }
        
        private func handleFaceDetectionObservations(observations: [VNFaceObservation]) {
            
            if let observation = observations.first {
                circle.isHidden = parent.showCircleProgress
                let faceRectConverted = previewLayer.layerRectConverted(
                    fromMetadataOutputRect: observation.boundingBox)
                var sizeMax = faceRectConverted.width + 10
                if sizeMax < faceRectConverted.height {
                    sizeMax = faceRectConverted.height
                }
                let frame = CGRect(x: faceRectConverted.minX,
                                  y: faceRectConverted.minY,
                                  width: sizeMax,
                                  height: sizeMax)
                analyzeProximity(frame: frame)
                UIView.animate(withDuration: 0.5, animations: {
                    self.circle.layoutIfNeeded()
                    self.circle.frame = frame
                }) { (success) in
                    
                }
            } else {
                circle.isHidden = true
            }
        }
        
        func convert(cmage: CIImage) -> UIImage {
             let context = CIContext(options: nil)
             let cgImage = context.createCGImage(cmage, from: cmage.extent)!
             let image = UIImage(cgImage: cgImage)
             return image
        }
        
        func captureOutput(_ output: AVCaptureOutput,
                           didOutput sampleBuffer: CMSampleBuffer,
                           from connection: AVCaptureConnection
        ) {
            if !isStopped && (analice % 4) == 0 {
                guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                    return
                }
                let faceDetectionRequest = VNDetectFaceLandmarksRequest(
                    completionHandler: { (request: VNRequest, error: Error?) in
                        DispatchQueue.main.async {
                            if let observations = request.results as? [VNFaceObservation],
                               !self.isStopped {
                                self.handleFaceDetectionObservations(
                                    observations: observations)
                            }
                        }
                    })
                lastImage = UIImage(ciImage: CIImage(cvPixelBuffer: imageBuffer))
                let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: imageBuffer,
                                                                orientation: .leftMirrored,
                                                                options: [:])
                do {
                    try imageRequestHandler.perform([faceDetectionRequest])
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            analice = analice &+ 1
            
        }
    }
    
}

