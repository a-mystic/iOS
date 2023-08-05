//
//  FloatingVideoARView.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/13.
//

import SwiftUI
import RealityKit
import ARKit
import AVKit

class FloatingVideoARViewController: UIViewController, ARSessionDelegate {  // Floating and imageTracking ARVideo
    var arView = ARView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageTracking()
        arView.session.delegate = self
    }
    
    private func ImageTracking() {
        guard let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pics/mouse", bundle: Bundle.main) else {
            print("Image not available")
            return
        }
        let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages = imageToTrack
        configuration.maximumNumberOfTrackedImages = 1
        arView.session.run(configuration)
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let imageAnchor = anchor as? ARImageAnchor {
                let videoScreen = createVideoScreen(
                    width: Float(imageAnchor.referenceImage.physicalSize.width),
                    height: Float(imageAnchor.referenceImage.physicalSize.height)
                )
                placeVideoScreen(videoScreen: videoScreen, imageAnchor: imageAnchor)
            }
        }
    }
    
    private func placeVideoScreen(videoScreen: ModelEntity, imageAnchor: ARImageAnchor) {
        let imageAnchorEntity = AnchorEntity(anchor: imageAnchor)
        let rotationAngle = simd_quatf(angle: GLKMathDegreesToRadians(-90), axis: SIMD3(x: 1, y: 0, z: 0))
        videoScreen.setOrientation(rotationAngle, relativeTo: imageAnchorEntity)
        let bookWidth = imageAnchor.referenceImage.physicalSize.width
        videoScreen.setPosition(SIMD3(x: Float(bookWidth), y: 0, z: 0), relativeTo: imageAnchorEntity)
        imageAnchorEntity.addChild(videoScreen)
        arView.scene.addAnchor(imageAnchorEntity)
    }
    
    private func createVideoScreen(width: Float, height: Float) -> ModelEntity {
        let screenMesh = MeshResource.generatePlane(width: width, height: height)
        guard let videoItem = createVideoItem(with: "ElonClip") else { return ModelEntity() } // add videofile(mp4) later
        let videoMaterial = createVideoMaterial(with: videoItem)
        let videoScreenModel = ModelEntity(mesh: screenMesh, materials: [videoMaterial])
        return videoScreenModel
    }
    
    private func createVideoItem(with filename: String) -> AVPlayerItem? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp4") else { return nil }
        let asset = AVURLAsset(url: url)
        let videoItem = AVPlayerItem(asset: asset)
        return videoItem
    }
    
    private func createVideoMaterial(with videoItem: AVPlayerItem) -> VideoMaterial {
        let player = AVPlayer()
        let videoMaterial = VideoMaterial(avPlayer: player)
        player.replaceCurrentItem(with: videoItem)
        player.play()
        return videoMaterial
    }
}

struct FloatingVideoARView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FloatingVideoARViewController {
        return FloatingVideoARViewController()
    }
    
    func updateUIViewController(_ uiViewController: FloatingVideoARViewController, context: Context) { }
}
