//
//  PreViewView.swift
//  ObjectRecognition
//
//  Created by mystic on 2022/06/19.
//
import UIKit
import AVFoundation

class CapturePreviewView: UIView {
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
