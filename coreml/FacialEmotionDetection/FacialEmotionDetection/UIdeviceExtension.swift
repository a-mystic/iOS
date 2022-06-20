//
//  UIdeviceExtension.swift
//  FacialEmotionDetection
//
//  Created by mystic on 2022/06/20.
//
import UIKit

extension UIDevice{
    
    private func exifOrientationForDeviceOrientation(_ deviceOrientation: UIDeviceOrientation) -> CGImagePropertyOrientation {
        
        switch deviceOrientation {
        case .portraitUpsideDown:
            return .rightMirrored
            
        case .landscapeLeft:
            return .downMirrored
            
        case .landscapeRight:
            return .upMirrored
            
        default:
            return .leftMirrored
        }
    }
    
    var exifOrientationForCurrentDeviceOrientation : CGImagePropertyOrientation {
        get{
            return exifOrientationForDeviceOrientation(UIDevice.current.orientation)
        }
    }
    
}
