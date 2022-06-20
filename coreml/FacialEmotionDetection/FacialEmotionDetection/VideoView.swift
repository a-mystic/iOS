//
//  VideoView.swift
//  FacialEmotionDetection
//
//  Created by mystic on 2022/06/20.
//
import SwiftUI
import UIKit
import Vision
import AVFoundation

class ViewController: UIViewController{
    var previewView: CapturePreviewView! = CapturePreviewView()
    var viewVisualizer: EmotionVisualizerView! = EmotionVisualizerView()
    var statusLabel: UILabel! = UILabel()
    let videoCapture : VideoCapture = VideoCapture()
    let imageProcessor : ImageProcessor = ImageProcessor()
    let model = ExpressionRecognitionModelRaw()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoCapture.delegate = self
        
        videoCapture.asyncInit { (success) in
            if success{
                // Assign the capture session instance being previewed
                (self.previewView.layer as! AVCaptureVideoPreviewLayer).session = self.videoCapture.captureSession
                // You use the videoGravity property to influence how content is viewed relative to the layer bounds;
                // in this case setting it to full the screen while respecting the aspect ratio.
                (self.previewView.layer as! AVCaptureVideoPreviewLayer).videoGravity = AVLayerVideoGravity.resizeAspectFill
                let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                self.previewView.layer.frame = frame
                self.viewVisualizer.frame = CGRect(x:100,y:300,width:frame.width / 2 , height: frame.height / 2 )
                self.viewVisualizer.backgroundColor = .clear
                
                self.view.layer.addSublayer(self.previewView.layer)
                self.videoCapture.startCapturing()
            } else{
                fatalError("Failed to init VideoCapture")
            }
        }
        
        imageProcessor.delegate = self
    }
}

extension ViewController : VideoCaptureDelegate{
    
    func onFrameCaptured(
        videoCapture: VideoCapture,
        pixelBuffer:CVPixelBuffer?,
        timestamp:CMTime){
        // Unwrap the parameter pixxelBuffer; exit early if nil
        guard let pixelBuffer = pixelBuffer else{
            print("WARNING: onFrameCaptured; null pixelBuffer")
            return
        }
        
        // extract faces
        self.imageProcessor.getFaces(
            pixelBuffer: pixelBuffer)
    }
}

extension ViewController : ImageProcessorDelegate{
    
    func onImageProcessorCompleted(
        status: Int,
        faces:[MLMultiArray]?){
        guard let faces = faces else{ return }
        
        self.statusLabel.isHidden = faces.count > 0
        
        guard faces.count > 0 else{
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            for faceData in faces{
                
                let prediction = try? self.model
                    .prediction(image: faceData)
                
                if let classPredictions =
                    prediction?.classLabelProbs{
                    DispatchQueue.main.sync {
                        self.viewVisualizer.update(
                            labelConference: classPredictions
                        )
                        self.view.addSubview(self.viewVisualizer)
                    }
                }
            }
        }
    }
}


struct VideoView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {    }
    
    typealias UIViewControllerType = ViewController
    
    
}
