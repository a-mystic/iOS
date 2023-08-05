//
//  ARScenev.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/16.
//

import SwiftUI
import SceneKit
import ARKit

struct AR {
    static var ARSceneView = ARSCNView(frame: .zero)
}

struct ARScenev: UIViewRepresentable {
    @Binding var image: UIImage?

    func makeUIView(context: Context) -> ARSCNView {
        AR.ARSceneView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        AR.ARSceneView.session.run(ARWorldTrackingConfiguration())
        return AR.ARSceneView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) { }
}
