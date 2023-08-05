//
//  imagetack.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/18.
//

import SwiftUI
import ARKit
import RealityKit

struct imagetrack: UIViewRepresentable {     // not zooming
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let config = ARImageTrackingConfiguration()
        config.isAutoFocusEnabled = true
        arView.session.run(config)
//        let imagetac = try! Imagetack.load장면()
        let imageanchor = AnchorEntity(plane: .horizontal)
        imageanchor.addChild(imageanchor)
        arView.scene.addAnchor(imageanchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) { }
}
