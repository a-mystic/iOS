//
//  CapturePreviewview.swift
//  FacialEmotionDetection
//
//  Created by mystic on 2022/06/20.
//
import UIKit
import AVFoundation

class CapturePreviewView: UIView {
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
