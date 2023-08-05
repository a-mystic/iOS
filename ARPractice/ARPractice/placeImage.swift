//
//  placeImage.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/16.
//

import SwiftUI
import RealityKit
import ARKit

struct PlaceImageView: UIViewRepresentable {
    let image: UIImage
    let geometry: GeometryProxy
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        if let image = image.cgImage {
            let arImage = ARReferenceImage(image, orientation: .up, physicalWidth: geometry.size.width)
            arImage.name = ""
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) { }
}
