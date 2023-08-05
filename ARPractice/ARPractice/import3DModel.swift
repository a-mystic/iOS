//
//  import3DModel.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/18.
//

import SwiftUI
import RealityKit

class import3DModelController: UIViewController {
    let arView = ARView(frame: .zero)
    let anchor = AnchorEntity(plane: .horizontal)
    let picachu = try! Picachu.load장면()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.frame = view.frame
        anchor.addChild(picachu)
        arView.scene.addAnchor(anchor)
        self.view.addSubview(arView)
    }
}

struct import3DModelContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> import3DModelController {
        return import3DModelController()
    }
    
    func updateUIViewController(_ uiViewController: import3DModelController, context: Context) { }
}
