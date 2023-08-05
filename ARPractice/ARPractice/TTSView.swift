//
//  TTSView.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/17.
//

import AVFoundation
import SwiftUI

struct TTSView: View {
    private let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        Button {
            play("hi i'am jhon watson")
        } label: {
            Text("tts")
        }

    }
    
    func play(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.4
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
