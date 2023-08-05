//
//  RealityKitView.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/15.
//

import SwiftUI
import RealityKit

struct Reality: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let fruitAndCoffee = try! Fruitcoffee.loadScene()
        arView.scene.anchors.append(fruitAndCoffee)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) { }
}
