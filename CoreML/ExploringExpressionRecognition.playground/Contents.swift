//: Playground - noun: a place where people can play

import UIKit
import Vision
import CoreML
import PlaygroundSupport

var images = [UIImage]()
for i in 1...3 {
    guard let image = UIImage(named: "images/joshua_newnham_\(i).jpg") else { fatalError() }
    images.append(image)
}
let faceIdx = 0
let imageView = UIImageView(image:images[faceIdx])
imageView.contentMode = .scaleAspectFit
// Required to run tasks in the background
PlaygroundPage.current.needsIndefiniteExecution = true

let faceDetection = VNDetectFaceRectanglesRequest()
let faceDetectionRequest = VNSequenceRequestHandler()

try? faceDetectionRequest.perform([faceDetection],
                                  on:images[faceIdx].cgImage!, orientation: CGImagePropertyOrientation(images[faceIdx].imageOrientation))
if let faceDetectionResults = faceDetection.results as? [VNFaceObservation] {
    for face in faceDetectionResults {
        if let currentImage = imageView.image{
            let bbox = face.boundingBox
            let imageSize = CGSize(width:currentImage.size.width, height:currentImage.size.height)
            let w = bbox.width * imageSize.width
            let h = bbox.height * imageSize.height
            let x = bbox.origin.x * imageSize.width
            let y = bbox.origin.y * imageSize.height
            let faceRect = CGRect(x:x,y:y,width:w,height:h)
            let invertedY = imageSize.height - (faceRect.origin.y + faceRect.height)
            let invertedFaceRect = CGRect(x:x,y:invertedY,width:w,height:h)
            imageView.drawRect(rect: invertedFaceRect)
        }
    }
}


imageView.image = images[faceIdx]
let faceLandmarks = VNDetectFaceLandmarksRequest()




if let faceLandmarkDetectionResults = faceLandmarks.results as? [VNFaceObservation]{
    for face in faceLandmarkDetectionResults{
        if let currentImage = imageView.image{
            // As we had before; we have access to the boundingbox
            // of the face(s)
            let bbox = face.boundingBox
            
            let imageSize = CGSize(width:currentImage.size.width,
                                   height: currentImage.size.height)
            
            let w = bbox.width * imageSize.width
            let h = bbox.height * imageSize.height
            let x = bbox.origin.x * imageSize.width
            let y = bbox.origin.y * imageSize.height
            
            let faceRect = CGRect(x: x,
                                  y: y,
                                  width: w,
                                  height: h)
            
            /*
             We also have access to facial landmarks include:
             left and right eye, mouth, nose, nose crest, face contour,
             left and right eyebrow, inner and outer lips,
             median line (center of face), left and right pupil
             https://developer.apple.com/documentation/vision/vnfacelandmarks2d
            */
            
            /*
             Lets create a utility function to return a transformed
             set of points for a given landmark (the points are
             normalised i.e. 0.0 - 1.0 with respect to the image dimensions
            */
            func getTransformedPoints(
                landmark:VNFaceLandmarkRegion2D,
                faceRect:CGRect,
                imageSize:CGSize) -> [CGPoint]{
                print("gettranse")
                // last point is 0.0
                return landmark.normalizedPoints.map({ (np) -> CGPoint in
                    return CGPoint(
                        x: faceRect.origin.x + np.x * faceRect.size.width,
                        y: imageSize.height - (np.y * faceRect.size.height + faceRect.origin.y))
                })
            }
            
            if let landmarks = face.landmarks?.leftEye {
                let transformedPoints = getTransformedPoints(
                    landmark: landmarks,
                    faceRect: faceRect,
                    imageSize: imageSize)
                
                imageView.drawPath(pathPoints: transformedPoints,
                                   closePath: true,
                                   color: UIColor.blue,
                                   lineWidth: 1.0,
                                   vFlip: false)
                
                // Find the center of the eyes
                var center = transformedPoints.reduce(CGPoint.zero, { (result, point) -> CGPoint in
                    return CGPoint(
                        x:result.x + point.x,
                        y:result.y + point.y)
                })
                
                center.x /= CGFloat(transformedPoints.count)
                center.y /= CGFloat(transformedPoints.count)
                imageView.drawCircle(center: center,
                                     radius: 2,
                                     color: UIColor.blue,
                                     lineWidth: 1.0,
                                     vFlip: false)
            }
            
            if let landmarks = face.landmarks?.rightEye {
                let transformedPoints = getTransformedPoints(
                    landmark: landmarks,
                    faceRect: faceRect,
                    imageSize: imageSize)
                
                imageView.drawPath(pathPoints: transformedPoints,
                                   closePath: true,
                                   color: UIColor.blue,
                                   lineWidth: 1.0,
                                   vFlip: false)
                
                // Find the center of the eyes
                var center = transformedPoints.reduce(CGPoint.zero, { (result, point) -> CGPoint in
                    return CGPoint(
                        x:result.x + point.x,
                        y:result.y + point.y)
                })
                
                center.x /= CGFloat(transformedPoints.count)
                center.y /= CGFloat(transformedPoints.count)
                imageView.drawCircle(center: center,
                                     radius: 2,
                                     color: UIColor.blue,
                                     lineWidth: 1.0,
                                     vFlip: false)
            }
            
            if let landmarks = face.landmarks?.faceContour {
                let transformedPoints = getTransformedPoints(
                    landmark: landmarks,
                    faceRect: faceRect,
                    imageSize: imageSize)
                
                imageView.drawPath(pathPoints: transformedPoints,
                                   closePath: false,
                                   color: UIColor.blue,
                                   lineWidth: 1.0,
                                   vFlip: false)
            }
            
            if let landmarks = face.landmarks?.nose {
                let transformedPoints = getTransformedPoints(
                    landmark: landmarks,
                    faceRect: faceRect,
                    imageSize: imageSize)
                
                imageView.drawPath(pathPoints: transformedPoints,
                                   closePath: false,
                                   color: UIColor.blue,
                                   lineWidth: 1.0,
                                   vFlip: false)
            }
            
            if let landmarks = face.landmarks?.noseCrest {
                let transformedPoints = getTransformedPoints(
                    landmark: landmarks,
                    faceRect: faceRect,
                    imageSize: imageSize)
                
                imageView.drawPath(pathPoints: transformedPoints,
                                   closePath: false,
                                   color: UIColor.blue,
                                   lineWidth: 1.0,
                                   vFlip: false)
            }
            
            if let landmarks = face.landmarks?.innerLips {
                let transformedPoints = getTransformedPoints(
                    landmark: landmarks,
                    faceRect: faceRect,
                    imageSize: imageSize)
                
                imageView.drawPath(pathPoints: transformedPoints,
                                   closePath: false,
                                   color: UIColor.blue,
                                   lineWidth: 1.0,
                                   vFlip: false)
            }
            
            if let landmarks = face.landmarks?.outerLips {
                let transformedPoints = getTransformedPoints(
                    landmark: landmarks,
                    faceRect: faceRect,
                    imageSize: imageSize)
                
                imageView.drawPath(pathPoints: transformedPoints,
                                   closePath: false,
                                   color: UIColor.blue,
                                   lineWidth: 1.0,
                                   vFlip: false)
            }
        }
    }
}


