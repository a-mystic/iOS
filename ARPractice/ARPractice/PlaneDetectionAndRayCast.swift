//
//  PlaneDetectionAndRayCast.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/17.
//

import SwiftUI
import RealityKit
import ARKit

class PlaneDetectionAndRayCastController: UIViewController {
    var arView = ARView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaneDetection()
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
        arView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
        self.view.addSubview(arView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        arView.frame = self.view.frame
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: arView)
        let horizontal = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult = horizontal.first {
            let worldPos = simd_make_float3(firstResult.worldTransform.columns.3)
            let sphere = createSphere()
            placeObject(object: sphere, at: worldPos)
        }
//        let vertical = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .vertical)
//        if let firstResult = vertical.first {
//            let worldPos = simd_make_float3(firstResult.worldTransform.columns.3)
//            let sphere = createSphere()
//            placeObject(object: sphere, at: worldPos)
//        }
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        let tapLocation = recognizer.location(in: arView)
        let horizontal = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult = horizontal.first {
            let worldPos = simd_make_float3(firstResult.worldTransform.columns.3)
            let sphere = createSphere()
            placeObject(object: sphere, at: worldPos)
        }
//        let vertical = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .vertical)
//        if let firstResult = vertical.first {
//            let worldPos = simd_make_float3(firstResult.worldTransform.columns.3)
//            let sphere = createSphere()
//            placeObject(object: sphere, at: worldPos)
//        }
    }
    
    func PlaneDetection() {
        arView.automaticallyConfigureSession = true
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }
    
    func createSphere() -> ModelEntity {
        let sphere = MeshResource.generateSphere(radius: 0.1)
        let sphereMaterial = SimpleMaterial(color: .white,roughness: 0 ,isMetallic: true)
        let sphereEntity = ModelEntity(mesh: sphere, materials: [sphereMaterial])
        return sphereEntity
    }
    
    func placeObject(object: ModelEntity, at location: SIMD3<Float>) {
        let objectAnchor = AnchorEntity(world: location)
        objectAnchor.addChild(objectAnchor)
        arView.scene.addAnchor(objectAnchor)
    }
}

struct PlaneDetectionAndRayCast: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PlaneDetectionAndRayCastController {
        return PlaneDetectionAndRayCastController()
    }
    
    func updateUIViewController(_ uiViewController: PlaneDetectionAndRayCastController, context: Context) { }
}

