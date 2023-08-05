//
//  VideoView.swift
//  ObjectRecognition
//
//  Created by mystic on 2022/06/19.
//

import SwiftUI
import AVFoundation
import UIKit

class videocontroller: UIViewController{
    var previewView: CapturePreviewView = CapturePreviewView()
    let videoCapture : VideoCapture = VideoCapture()
    let context = CIContext()
    let model = Inceptionv3()
//    var resultLabel: UILabel!
    var labelset: (String) -> Void
    
    init(labelset: @escaping (String) -> Void) {
        self.labelset = labelset
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func labelsetup() {
//        resultLabel = UILabel()
//        resultLabel.text = ""
//        resultLabel.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width, height: 80)
//        resultLabel.textColor = UIColor.black
//        resultLabel.textAlignment = NSTextAlignment.center
//        resultLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
//        resultLabel.backgroundColor = UIColor.clear
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        labelsetup()
        self.videoCapture.delegate = self
        
        if self.videoCapture.initCamera(){
            // Assign the capture session instance being previewed
            (self.previewView.layer as! AVCaptureVideoPreviewLayer).session = self.videoCapture.captureSession
            // You use the videoGravity property to influence how content is viewed relative to the layer bounds;
            // in this case setting it to full the screen while respecting the aspect ratio.
            (self.previewView.layer as! AVCaptureVideoPreviewLayer).videoGravity = AVLayerVideoGravity.resizeAspectFill
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            previewView.layer.frame = frame
            
            self.view.layer.addSublayer(previewView.layer)
//            self.view.addSubview(resultLabel)
            self.videoCapture.asyncStartCapturing()

            
        } else{
            fatalError("Failed to init VideoCapture")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension videocontroller : VideoCaptureDelegate{
    
    func onFrameCaptured(videoCapture: VideoCapture, pixelBuffer:CVPixelBuffer?, timestamp:CMTime){
        // Unwrap the parameter pixxelBuffer; exit early if nil
        guard let pixelBuffer = pixelBuffer else{ return }

        // Prepare our image for our model (resizing)
        guard let scaledPixelBuffer = CIImage(cvImageBuffer: pixelBuffer)
            .resize(size: CGSize(width: 299, height: 299))
            .toPixelBuffer(context: context) else{ return }

        // Try to make a prediction
        let prediction = try? self.model.prediction(image:scaledPixelBuffer)

        // Update label
        DispatchQueue.main.sync {
            if let str = prediction?.classLabel {
             labelset(str)
            }
//            self.resultLabel.text = prediction?.classLabel ?? "Unknown"
        }
    }
}

struct VideoView: UIViewControllerRepresentable{
    var labelset: (String) -> Void
    
    func makeUIViewController(context: Context) -> videocontroller {
        return videocontroller(labelset: labelset)
    }
    
    func updateUIViewController(_ uiViewController: videocontroller, context: Context) {    }
    
    typealias UIViewControllerType = videocontroller
    
    
}
