//
//  ARVideoScreen.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/13.
//

import SwiftUI
import RealityKit
import AVKit
import ARKit

class ARVideoScreenController: UIViewController {
    var arView = ARView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaneDetection()
        TapDetection()
        self.view.addSubview(arView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let width = self.view.window?.windowScene?.screen.bounds.width,
           let height = self.view.window?.windowScene?.screen.bounds.height {
            self.arView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }
    }
    
    private func PlaneDetection() {
        arView.automaticallyConfigureSession = true
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }
    
    private func TapDetection() {
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
    }
    
    @objc
    private func handleTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: arView)
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult = results.first {
            let worldPosition = simd_make_float3(firstResult.worldTransform.columns.3)
            let videoScreen = createVideoScreen(width: 0.4, height: 0.2)
            videoScreen.setPosition(SIMD3(x: 0, y: 0.2/2, z: 0), relativeTo: videoScreen)
            placeScreen(screen: videoScreen, at: worldPosition)
            installGesture(on: videoScreen)
        }
    }
    
    private func placeScreen(screen: ModelEntity, at position: SIMD3<Float>) {
        let anchor = AnchorEntity(world: position)
        anchor.addChild(screen)
        arView.scene.addAnchor(anchor)
    }
    
    private func installGesture(on model: ModelEntity) {
        model.generateCollisionShapes(recursive: true)
        arView.installGestures([.rotation], for: model)
    }
    
    private func createVideoScreen(width: Float, height: Float) -> ModelEntity {
        let screenMesh = MeshResource.generatePlane(width: width, height: height)
        let url = "https://p-events-delivery.akamaized.net/2605bdtgclbnfypwzfkzdsupvcyzhhbx/m3u8/hls_vod_mvp.m3u8"
        guard let videoItem = createVideoItem(with: url) else { return ModelEntity() }
        let videoMaterial = createVideoMaterials(with: videoItem)
        let videoScreenModelEntity = ModelEntity(mesh: screenMesh, materials: [videoMaterial])
        return videoScreenModelEntity
    }
    
    private func createVideoItem(with url: String) -> AVPlayerItem? {
        guard let url = URL(string: url) else { return nil }
        let asset = AVURLAsset(url: url)
        let videoItem = AVPlayerItem(asset: asset)
        return videoItem
    }
    
    private func createVideoMaterials(with videoItem: AVPlayerItem) -> VideoMaterial {
        let player = AVPlayer()
        let videoMaterial = VideoMaterial(avPlayer: player)
        player.replaceCurrentItem(with: videoItem)
        player.play()
        return videoMaterial
    }
}

struct ARVideoScreenView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARVideoScreenController {
        return ARVideoScreenController()
    }
    
    func updateUIViewController(_ uiViewController: ARVideoScreenController, context: Context) { }
}
