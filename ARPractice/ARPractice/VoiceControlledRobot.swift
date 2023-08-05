//
//  VoiceControlledRobot.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/14.
//

import SwiftUI
import ARKit
import RealityKit
import Speech

class VoiceControlledRobotController: UIViewController {
    var arView = ARView(frame: .zero)
    var robotEntity = Entity()
    var moveToLocation = Transform()
    var moveDuration = Double(5)
    
    struct Speech {
        // Speech Recognition
        static let speechRecognizer = SFSpeechRecognizer()
        static let speechRequest = SFSpeechAudioBufferRecognitionRequest()
        static var speechTask = SFSpeechRecognitionTask()
        // Audio
        static let audioEngine = AVAudioEngine()
        static let audioSession = AVAudioSession.sharedInstance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startARSession()
        robotEntity = try! Entity.loadModel(named: "Dragon 2.5_fbx")
//        robotEntity = try! MakeBall.loadBall()
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
        SpeechRecognition()
        self.view.addSubview(arView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let width = self.view.window?.windowScene?.screen.bounds.width,
           let height = self.view.window?.windowScene?.screen.bounds.height {
            self.arView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }
    }
    
    @objc
    private func handleTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: arView)
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult = results.first {
            let worldPosition = simd_make_float3(firstResult.worldTransform.columns.3)
            placeObject(object: robotEntity, at: worldPosition)
        }
    }
    
    private func startARSession() {
        arView.automaticallyConfigureSession = true
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
//        arView.debugOptions = .showAnchorGeometry   // show raycast field like green...
        arView.session.run(config)
    }
    
    private func placeObject(object: Entity, at position: SIMD3<Float>) {
        let objectAnchor = AnchorEntity(world: position)
        objectAnchor.addChild(object)
        arView.scene.addAnchor(objectAnchor)
    }
    
    private func move(direction: String) {
        if direction.contains("forward") {
            moveToLocation.translation = robotEntity.transform.translation + simd_float3(x: 0, y: 0, z: 20)
            robotEntity.move(to: moveToLocation, relativeTo: robotEntity, duration: moveDuration)
            walkAnimation(moveDuration: moveDuration)
        } else if direction.contains("back") {
            moveToLocation.translation = robotEntity.transform.translation + simd_float3(x: 0, y: 0, z: -20)
            robotEntity.move(to: moveToLocation, relativeTo: robotEntity, duration: moveDuration)
            walkAnimation(moveDuration: moveDuration)
        } else if direction.contains("left") {
            let rotateToAngle = simd_quatf(angle: GLKMathDegreesToRadians(90), axis: SIMD3(x: 0, y: 1, z: 0))
            robotEntity.setOrientation(rotateToAngle, relativeTo: robotEntity)
        } else if direction.contains("right") {
            let rotateToAngle = simd_quatf(angle: GLKMathDegreesToRadians(-90), axis: SIMD3(x: 0, y: 1, z: 0))
            robotEntity.setOrientation(rotateToAngle, relativeTo: robotEntity)
        } else {
            print("no movement animation")
        }
    }
    
    private func walkAnimation(moveDuration: Double) {
        if let robotAnimation = robotEntity.availableAnimations.first {
            robotEntity.playAnimation(robotAnimation.repeat(duration: moveDuration),  transitionDuration: 0.5, startsPaused: false)
        } else {
            print("no animation")
        }
    }
    
    private func SpeechRecognition() {
        requestPermission()
        startAudioRecording()
        speechRecognize()
    }
    
    private func requestPermission() {
        SFSpeechRecognizer.requestAuthorization { authoriztionStatus in
            if authoriztionStatus == .authorized {
                print("Authorized")
            } else if authoriztionStatus == .denied {
                print("denied")
            } else if authoriztionStatus == .notDetermined {
                print("wating")
            } else if authoriztionStatus == .restricted {
                print("not available")
            }
        }
    }
    
    private func startAudioRecording() {
        let node = Speech.audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            Speech.speechRequest.append(buffer)
        }
        do {
            try Speech.audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try Speech.audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            Speech.audioEngine.prepare()
            try Speech.audioEngine.start()
        } catch {
            
        }
    }
    
    private func speechRecognize() {
        guard let speechRecognizer = SFSpeechRecognizer() else {
            print("speech recognize is not available")
            return
        }
        if !(speechRecognizer.isAvailable) {
            print("Temporarily not working")
        }
        var count = 0
        Speech.speechTask = speechRecognizer.recognitionTask(with: Speech.speechRequest, resultHandler: { result, error in
            count += 1
            if count == 1 {
                guard let result = result else { return }
                if let recognizedText = result.bestTranscription.segments.last {
                    self.move(direction: recognizedText.substring)
                }
            } else if count >= 3 {
                count = 0
            }
        })
    }
}

struct VoiceControlledRobotView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> VoiceControlledRobotController {
        return VoiceControlledRobotController()
    }
    
    func updateUIViewController(_ uiViewController: VoiceControlledRobotController, context: Context) { }
}
