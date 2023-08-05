//
//  ImageTracking.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/20.
//

import SwiftUI
import RealityKit
import ARKit

class ImageTrackingController: UIViewController, ARSessionDelegate {
    let image = UIImage(named: "note")!.cgImage!
    let arView = ARView(frame: .zero)
    var referenceSet = Set<ARReferenceImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.frame = self.view.frame
        arView.session.delegate = self
        ImageTracking()
        self.view.addSubview(arView)
    }
    
    func ImageTracking() {
        let referenceImage = ARReferenceImage(image, orientation: .up, physicalWidth: 1)    // input from user degress is meter
        print(image.width)
        referenceSet.insert(referenceImage)
        let configuration = ARImageTrackingConfiguration()
        configuration.isAutoFocusEnabled = true
        configuration.trackingImages = referenceSet
        configuration.maximumNumberOfTrackedImages = 1
        arView.session.run(configuration)
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let imageAnchor = anchor as? ARImageAnchor {
                print("imageAnchor")
                let sphere = createSphere()
                placeObject(object: sphere, imageAnchor: imageAnchor)
                
            }
        }
    }
    
    func placeObject(object: ModelEntity, imageAnchor: ARImageAnchor) {
        let imageAnchorEntity = AnchorEntity(anchor: imageAnchor)
        let rotationAngle = simd_quatf(angle: GLKMathRadiansToDegrees(-90), axis: SIMD3<Float>(x: 0, y: 0, z: 0))
        object.setOrientation(rotationAngle, relativeTo: imageAnchorEntity)
        let bookWidth = imageAnchor.referenceImage.physicalSize.width
        object.setPosition(SIMD3<Float>(x: 0, y: 0, z: 0), relativeTo: imageAnchorEntity)
        imageAnchorEntity.addChild(object)
        arView.scene.addAnchor(imageAnchorEntity)
    }
    
    func createSphere() -> ModelEntity {
        let sphere = MeshResource.generateSphere(radius: 0.5)
        let sphereMaterial = SimpleMaterial(color: .white,roughness: 0 ,isMetallic: true)
        let sphereEntity = ModelEntity(mesh: sphere, materials: [sphereMaterial])
        return sphereEntity
    }
}

struct ImageTracking: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ImageTrackingController {
        return ImageTrackingController()
    }
    
    func updateUIViewController(_ uiViewController: ImageTrackingController, context: Context) { }
}

