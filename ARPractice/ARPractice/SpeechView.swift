//
//  SpeechView.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/17.
//

import SwiftUI
import Speech

struct SpeechView: View {
    @State var SpeechText: String = ""
    @State var SpeechState = false
    
    struct Speech {
        // Speech Recognition
        static let speechRecognizer = SFSpeechRecognizer()
        static var speechRequest = SFSpeechAudioBufferRecognitionRequest()
        static var speechTask = SFSpeechRecognitionTask()
        // Audio
        static let audioEngine = AVAudioEngine()
        static let audioSession = AVAudioSession.sharedInstance()
    }
    
    var body: some View {
        VStack {
            Text(SpeechText)
            Button {
                SpeechState.toggle()
                if !SpeechText.isEmpty {
                    SpeechText = ""
                }
            } label: {
                Text("speech")
            }.onAppear {
                SpeechRecognition()
            }
            if SpeechState {
                Text("SpeechState")
            }
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
            print(error)
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
        Speech.speechTask = speechRecognizer.recognitionTask(with: Speech.speechRequest) { result, error in
                guard let result = result else { return }
            if let result = result.bestTranscription.segments.last?.substring {
                SpeechText = result
                move(result)
            }
        }
    }
    
    private func move(_ str: String) {
        if str.contains("back") {
            print("back")
        } else if str.contains("forward") {
            print("forward")
        }
    }
}
