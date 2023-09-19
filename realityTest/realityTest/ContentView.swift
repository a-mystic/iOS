//
//  ContentView.swift
//  realityTest
//
//  Created by a mystic on 2023/09/19.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let horizonAnchor = AnchorEntity(plane: .horizontal)
        if let box = try? Entity.load(named: "testreal") {
            horizonAnchor.addChild(box)
        }
        arView.scene.anchors.append(horizonAnchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
