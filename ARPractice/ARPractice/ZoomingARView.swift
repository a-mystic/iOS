//
//  ZoomingARView.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/15.
//

import SwiftUI
import ARKit
import RealityKit

struct ZoomingARView: UIViewRepresentable {     // not zooming
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let config = ARImageTrackingConfiguration()
        config.isAutoFocusEnabled = true
        arView.session.run(config)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) { }
}
